require 'uri'
# Convenience methods for dealing with filepaths
module HelperPath
  # Sanitize a filename so it can be written on disk without any risk.
  # Removes all special chars.
  # Args:
  #   - filepath (String): Original filepath
  # Returns:
  #   - String: Sanitized filepath
  def self.sanitize(filename)
    filename.gsub(%r{[^0-9A-Za-z.\-/]}, '_')
  end

  # Returns the download path for any given url
  # Args:
  #   - url (String): Input url
  # Returns:
  #   - String: Download filepath
  def self.download(url)
    path = sanitize(URI(url).path)
    path = File.expand_path(File.join('.', '_cache', path))
    path += '.html' unless File.extname(path) == '.html'
    path
  end

  def json_path(dest)
    dirname = File.dirname(dest)
    basename = sanitize_filename(File.basename(dest) + '.json')
    File.expand_path(File.join('json', dirname, basename))
  end


end
