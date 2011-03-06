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
  
  log_filename = LogFilename.send ARGV[0]          if ARGV.length == 1 
  log_filename = LogFilename.send ARGV[0], ARGV[1] if ARGV.length == 2 

  LOG.info "log_filename is #{log_filename}"
  
  data = RemoteFileGetterData.new
  data.host        = server["host"]
  data.username    = server["username"]
  data.password    = server["password"]
  data.remote_file = server["remote_dir"] + "/" + log_filename
  data.remote_archived_file = server["remote_dir_for_archived_log"] + "/" + log_filename + ".gz"
  data.local_file  = server["local_dir"] + "/" + log_filename

  LOG.warn "Delete local log file if exists"
  File.delete(data.local_file) if File.exists?(data.local_file)
  File.delete(data.local_file + ".gz") if File.exists?(data.local_file + ".gz")

  remote_getter = RemoteFileGetter.new
  remote_getter.get_file(data)

  log_parser = LogParser.new
  log_data_manager = LogDataManager.new
  lines_number = CountLines.of data.local_file
  processed_lines = 0
  checkpoints = [1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 96, 97, 98, 99]

  log_position = LogPosition.where(:filepath => data.remote_file, :host => data.host).first
  if log_position.nil?
    LOG.info "#{data.host} Working with new log"
    log_position = LogPosition.new
    log_position.host = data.host
    log_position.filepath = data.remote_file
    log_position.position = 0
  else
    LOG.warn "#{data.host} Log is not new!"
    LOG.warn "#{data.host} skipping #{log_position.position} lines"
  end

  File.readlines(data.local_file).collect do |line|
    processed_lines += 1
    
    next if processed_lines < log_position.position
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
  thread.join
end

LOG.info "Ending parsa"
