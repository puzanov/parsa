require "config"
require "lib/log_filename.rb"
require "lib/remote_file_getter.rb"
require "lib/log_parser"
require "lib/log_data_manager"
require "lib/utils"
require "lib/log_position"

Help.show_me_if_needed_and_exit

LOG.info "Starting parsa"
threads = Array.new

CONFIG["servers"].each do |server|
  threads << Thread.new {
  LOG.info "Working with #{server["host"]}"
  
  log_filename = LogFilename.get_by_argv server["log_filename_prefix"]
  data = RemoteFileGetterData.build_itself_using server, log_filename
  LocalLogs.delete data.local_file

  remote_getter = RemoteFileGetter.new
  remote_getter.get_file(data)

  log_parser = LogParser.new
  log_data_manager = LogDataManager.new
  lines_number = CountLines.of data.local_file
  processed_lines = 0
  checkpoints = [1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 96, 97, 98, 99]

  log_position = LogPosition.get_existing_or_new data
  
  File.readlines(data.local_file).collect do |line|
    processed_lines += 1
    
    next if processed_lines <= log_position.position
    log_position.position = processed_lines
    log_position.save

    log_data = log_parser.parse(line)
    next if log_data.nil?
    
    log_data_manager.save log_data
    percent = (processed_lines * 100 / lines_number)
    if checkpoints.include?(percent)
      checkpoints.delete(percent)
      LOG.info "#{data.host} #{percent}% is done..."
    end
  end
  } 
end

threads.each do |thread|
  begin
    thread.join
  rescue Exception => ex
    LOG.error "ERROR IN CLASS #{$!.inspect}"
    LOG.error "ERROR MESSAGE: #{ex.message}"
    LOG.error "ERROR BACKTRACE: #{ex.backtrace.join("\n")}"
  end
end

LOG.info "Ending parsa"
