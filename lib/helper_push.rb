require 'algoliasearch'
# Will push JSON data to Algolia
class HelperPush
  def initialize(app_id)
    @app_id = app_id
    @api_key = api_key

    if @api_key.nil?
      puts 'Cannot find your API key.'
      puts 'Usage:'
      puts 'ALGOLIA_API_KEY=XXXXXX ./scripts/push'
      puts 'Or create an ./_algolia_api_key file in the root folder containing'
      puts 'your API key'
      exit 1
    end

    Algolia.init(application_id: @app_id, api_key: @api_key)

    self
  end

  def set_settings(index_name, settings)
    puts "Configuring settings on #{index_name}"
    index = Algolia::Index.new(index_name)
    index.set_settings(settings)
    self
  end

  def push_records(index_name, records)
    records_size = records.length
    puts "Pushing #{records_size} records to #{index_name}"
    index = Algolia::Index.new(index_name)

    slice_size = 500
    records.each_slice(slice_size).with_index do |batch, i|
      from = i * slice_size
      to = [(i + 1) * slice_size, records_size].min
      puts "  Pushing records #{from}-#{to}"
      index.add_objects(batch.to_a)
    end
    self
  end

  def move_index(from, to)
    puts "Renaming #{from} to #{to}"
    Algolia.move_index(from, to)
    self
  end

  def add_slaves(index_name, slaves)
    puts "Adding slaves to #{index_name}:"
    slaves.each do |slave|
      puts "  #{slave}"
    end
    index = Algolia::Index.new(index_name)
    index.set_settings(slaves: slaves)
    self
  end

  # Read the API key either from ENV or from an _algolia_api_key file in
  # source folder
  def api_key
    # First read in ENV
    return ENV['ALGOLIA_API_KEY'] if ENV['ALGOLIA_API_KEY']

    # Otherwise from file in source directory
    key_file = '_algolia_api_key'
    if File.exist?(key_file) && File.size(key_file) > 0
      return File.open(key_file).read.strip
    end
    nil
  end

  #   index
  # end

  # # Will push records to the index, by batch
  # # Records too big or too small will be removed before pushing
  # def index_json(files, index)
  #   # Reject files too big or too small
  #   files.reject! do |file|
  #     size = File.size(file)
  #     size == 0 || size > 100_000
  #   end

  #   # Push records by batch of 1000
  #   index.clear_index
  #   files.sort.each_slice(1000) do |batch|
  #     from = File.basename(batch.first)
  #     to = File.basename(batch.last)
  #     puts "Indexing from #{from} to #{to}"

  #     objects = batch.map do |file|
  #       JSON.parse(File.open(file, 'r').read)
  #     end

  #     index.add_objects(objects)
  #   end
  # end

end
