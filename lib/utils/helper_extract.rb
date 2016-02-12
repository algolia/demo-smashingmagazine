# Will extract content from HTML page and save it as JSON

module HelperExtract

  # Download content from url and return the raw content
  def get_raw_content(url)
    filepath = local_path(url)

    # Some files are wrongly downloaded as f*** gzip
    if system("file #{filepath} | grep 'gzip compressed data'")
      puts 'File was returned gzipped... unzipping'
      `mv #{filepath} #{filepath}.gz && gunzip #{filepath}.gz`
    end
    File.open(filepath).read
  end

  def save_json(data, dest)
    dest = json_path(dest)

    FileUtils.mkdir_p(File.dirname(dest))
    content = JSON.pretty_generate(data)
    File.open(dest, 'w') do |file|
      file.write(content)
    end
  end


end
