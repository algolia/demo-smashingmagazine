require 'parallel'
require_relative './helper_path'

# Will download distant files and save them on disk
module HelperDownload
  # take each url
  # follow the link and save it to disk in the download folder
  # handle gzip weirdness


  # Download to disk all the urls passed
  # Args:
  #   - urls (Array): Array of urls
  # Returns:
  #   - true if everything is downloaded correctly
  def self.download(urls)
    Parallel.each(urls) do |url|
      if already_downloaded?(url)
        puts "✘ Already downloaded #{url}"
        next
      end
      puts "✔ Downloading #{url}"
      download_file(url)
    end
  end

  # Check if the specified url is already downloaded
  # Args:
  #   - url (String): The target url
  # Returns:
  #   - Boolean: True if file is already available on disk, False otherwise
  def self.already_downloaded?(url)
    File.exist?(HelperPath.download(url))
  end

  # Downloads the specified url to disk, keeping the same hierarchy structure
  # Args:
  #   - url (String): The target url
  def self.download_file(url)
    output = HelperPath.download(url)

    FileUtils.mkdir_p(File.dirname(output))
    `wget "#{url}" --random-wait -O #{output} 2>/dev/null`
  end

  # # Download the given url to the cache folder
  # def download_file(url, retry_count = 0)
  #   dest = local_path(url)

  #   # Trying to download this files too many times and failed
  #   if retry_count > 2
  #     `echo "404" > #{dest}`
  #     return true
  #   end

  #   # File already here, won't download again
  #   return true if File.exist?(dest) && File.size(dest) > 0

  #   puts "Downloading #{url}" if retry_count == 0
  #   FileUtils.mkdir_p(File.dirname(dest))
  #   `wget "#{url}" --random-wait -O #{dest} 2>/dev/null`

  #   # Check that the file is actually saved
  #   return true if File.size(dest) > 0

  #   retry_count += 1
  #   download_file(url, retry_count)
  # end

end
