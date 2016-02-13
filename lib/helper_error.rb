module HelperError

  def log_error(data, error)
    puts "✘ Error with #{data[:url]}"

    content = []
    content << "Date: #{DateTime.now}"
    content << "URL: #{data[:url]}"
    content << "Error: #{error}"
    content << "_cache: #{local_path(data[:url])}"
    content << "Data: #{JSON.pretty_generate(data)}"
    content << "Stacktrace: #{error.backtrace.join("\n")}"
    content << ''
    content << '=========================================='
    content << ''
    puts content

    log_name = "error-log_#{File.basename($PROGRAM_NAME)}.txt"
    File.open(log_name, 'a') do |file|
      file.write(content.join("\n"))
    end
  end
end
