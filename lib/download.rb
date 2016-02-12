require_relative './utils/helper_sitemap'
require_relative './utils/helper_download'

# Download on disk all the url defined in the specified sitemaps
class Download
  def initialize(*args)
    @urls = HelperSitemap.get_urls(*args)
  end

  def run
    # Download all files on disk
    HelperDownload.download(@urls)
  end
end
