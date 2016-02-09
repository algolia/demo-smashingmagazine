#!/usr/bin/env ruby
require 'English'
require 'action_view'
require 'algoliasearch'
require 'date'
require 'fileutils'
require 'json'
require 'nokogiri'
require 'parallel'
require 'uri'

# Provides common and convenient method to scrap a website to extract data in
# json form.
module ScrapperHelper
  def index_init(application_id, api_key, index_name)
    Algolia.init application_id: application_id,
                 api_key: api_key

    index = Algolia::Index.new(index_name)
    index
  end

  def index_json(files, index)
    # Reject files too big or too small
    files.reject! do |file|
      size = File.size(file)
      size == 0 || size > 100_000
    end

    # index.clear_index
    files.sort.each_slice(1000) do |batch|
      from = File.basename(batch.first)
      to = File.basename(batch.last)
      puts "Indexing from #{from} to #{to}"

      objects = batch.map do |file|
        JSON.parse(File.open(file, 'r').read)
      end

      index.add_objects(objects)
    end
  end

  def filepath_from_args(args)
    args.map { |arg| File.expand_path(arg) }
  end

  def sanitize_filename(filename)
    filename.gsub(%r{[^0-9A-Za-z.\-/]}, '_')
  end

  def get_tweet_count(url)
    twitter_api_url = "http://urls.api.twitter.com/1/urls/count.json?url=#{url}"
    data = JSON.parse(`wget --random-wait -q -O - "#{twitter_api_url}"`)
    data['count']
  end

  def local_path(url)
    path = sanitize_filename(URI(url).path)
    File.expand_path(File.join('.', '_cache', path))
  end

  def get_raw_content(url)
    filepath = local_path(url)

    # Some files are wrongly downloaded as f*** gzip
    if system("file #{filepath} | grep 'gzip compressed data'")
      puts 'File was returned gzipped... unzipping'
      `mv #{filepath} #{filepath}.gz && gunzip #{filepath}.gz`
    end
    File.open(filepath).read
  end

  def download_file(url, retry_count = 0)
    dest = local_path(url)

    # Trying to download this files too many times and failed
    if retry_count > 2
      `echo "404" > #{dest}`
      return true
    end

    # File already here, won't download again
    return true if File.exist?(dest) && File.size(dest) > 0

    puts "Downloading #{url}" if retry_count == 0
    FileUtils.mkdir_p(File.dirname(dest))
    `wget "#{url}" --random-wait -O #{dest} 2>/dev/null`

    # Check that the file is actually saved
    return true if File.size(dest) > 0

    retry_count += 1
    download_file(url, retry_count)
  end

  def json_path(dest)
    dirname = File.dirname(dest)
    basename = sanitize_filename(File.basename(dest) + '.json')
    File.expand_path(File.join('json', dirname, basename))
  end

  def save_json(data, dest)
    dest = json_path(dest)

    FileUtils.mkdir_p(File.dirname(dest))
    content = JSON.pretty_generate(data)
    File.open(dest, 'w') do |file|
      file.write(content)
    end
  end

  def log_error(data, error)
    puts "✘ Error with #{data[:url]}"

    content = []
    content << "Date: #{DateTime.now}"
    content << "URL: #{data[:url]}"
    content << "Error: #{error}"
    content << "_cache: #{local_path(data[:url])}"
    content << "Data: #{JSON.pretty_generate(data)}"
    content << "Stacktrace: #{error.backtrace.join("\n")}"
    content << ''
    content << '=========================================='
    content << ''
    puts content

    log_name = "error-log_#{File.basename($PROGRAM_NAME)}.txt"
    File.open(log_name, 'a') do |file|
      file.write(content.join("\n"))
    end
  end

  def run
    @sitemaps.each do |sitemap|
      pages = get_pages(sitemap)
      Parallel.each(pages) do |data|
        next unless download_file(data[:url])

        begin
          puts "Extracting data from #{data[:url]}"
          data = extract_more_data(data)
          next unless data
        rescue StandardError => error
          log_error(data, error)
          exit 1
        end

        save_json(data, output_name(data))
      end
    end
  end
end
