require "config"
require "lib/log_filename.rb"
require "lib/remote_file_getter.rb"
require "lib/log_parser"
#require "lib/log_data_manager2"
require "lib/utils"
require "lib/log_position"
require "lib/fastdate.rb"

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
#  log_data_manager = LogDataManager2.new
  db = Mysql.new('localhost', 'parsa', 'parsa', 'parsa')
#  rescue Mysql::Error
#    LOG.error "Could not connect to database #{db::errstr}"
  statement = db.prepare "INSERT INTO log_data (file_id,bytes,date) values (?,?,?) on duplicate key update bytes = bytes + ?"
  dateparser = Fastdate.new

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
    
  #  log_data_manager.save log_data
    statement.execute log_data[0],log_data[1],dateparser.parse(log_data[2]),log_data[1]
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
