# Will scrap the given website, and is agnostic to its content. The real scraper
# will inherit from it and will have all the specifics defined.
#
module HelperScraper
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


  # OVERRIDABLE
  # All the methods below can be overriden in the main scraper file. They can be
  # used to fine tune what is done on specific part of the process.

  # Checks if a specific url should be excluded from the scraping
  def excluded_url?(_url)
    false
  end

  # Check if a specific page should be excluded from the extracting process,
  # based on its DOM content and url
  def excluded_html?(_doc, _url)
    false
  end

  # Check if a specific record should be excluded from the indexing, based on
  # its content, its original page and url
  def excluded_record?(_record, _doc, _url)
    false
  end
end
