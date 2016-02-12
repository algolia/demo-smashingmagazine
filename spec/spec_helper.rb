require 'awesome_print'
require_relative '../lib/utils/helper_sitemap'
require_relative '../lib/utils/helper_path'

RSpec.configure do |config|
  config.filter_run(focus: true)
  config.fail_fast = true
  config.run_all_when_everything_filtered = true
end
