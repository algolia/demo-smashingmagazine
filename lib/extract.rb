require_relative './utils/helper_download'
require_relative './utils/helper_extract'

class Extract
  def initialize(selector)
    @files = HelperDownload.all_files
    @selector = selector
  end

  def run
    # Extract records from each page
    HelperExtract.new(@selector).extract(@files)
  end
end
#   def escape_tags(html)
#     html.gsub('<', '&lt;').gsub('>', '&gt;')
#   end
# 
#   def get_type(doc)
#     doc.css('meta[property="og:type"]').attribute('content').text
#   end
# 
# 
# 
#   def get_section(doc)
#     doc.css('meta[property="article:section"]').attribute('content').text
#   end
# 
# 
# 
# 
#   def get_modified_date(doc)
#     element = doc.css('meta[property="article:modified_time"]')
#     return get_published_date(doc) unless element.length > 0
#     string_date = element.attribute('content').text
#     DateTime.parse(string_date).to_time.to_i
#   end
# 
# 
#   def extract_more_data(data)
#     raw = get_raw_content(data[:url])
# 
#     doc = Nokogiri::HTML(raw)
#     data = {
#       objectID: get_object_id(doc),
#       url: data[:url],
#       priority: data[:priority],
#       title: get_title(doc),
#       type: get_type(doc),
#       description: get_description(doc),
#       description_short: get_description_short(doc),
#       tags: get_tags(doc),
#       section: get_section(doc),
#       image: get_image(doc),
#       published_date: get_published_date(doc),
#       modified_date: get_modified_date(doc),
#       author: get_author(doc),
#       comment_count: get_comment_count(doc)
#     }
# 
#     data
#   end
# 
#   def output_name(data)
#     'articles/' + data[:objectID]
#   end
# end
