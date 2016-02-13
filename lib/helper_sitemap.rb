require 'nokogiri'
# Helper methods to read sitemaps
class HelperSitemap
  # Returns a list of urls from a list of sitemap filepaths
  # Args:
  #   - *sitemaps: A list of sitemap filepaths
  # Returns:
  #   - Array: Sorted list of unique urls in the sitemaps
  def self.get_urls(*sitemaps)
    urls = []
    sitemaps.each do |sitemap|
      doc = Nokogiri::XML(File.open(sitemap))
      urls += doc.css('url loc').map(&:text)
    end

    urls.sort!.uniq!
    urls
  end
end
