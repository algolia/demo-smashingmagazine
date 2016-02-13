
# Will push JSON data to Algolia
module HelperPush
  # Create the Algolia index. Expect all the Algolia credentials
  # - application_id
  # - api_key
  # - index_name
  def init_index(application_id, api_key, index_name)
    Algolia.init application_id: application_id,
                 api_key: api_key

    index = Algolia::Index.new(index_name)
    index
  end

  # Will push records to the index, by batch
  # Records too big or too small will be removed before pushing
  def index_json(files, index)
    # Reject files too big or too small
    files.reject! do |file|
      size = File.size(file)
      size == 0 || size > 100_000
    end

    # Push records by batch of 1000
    index.clear_index
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

end
