require "config"
require "lib/log_filename.rb"
require "lib/remote_file_getter.rb"
require "lib/log_parser"

LOG.info "Starting parsa"

log_filename = LogFilename.get

data = RemoteFileGetterData.new
data.host        = CONFIG["host"]
data.username    = CONFIG["username"]
data.password    = CONFIG["password"]
data.remote_file = CONFIG["remote_dir"] + "/" + log_filename
data.local_file  = CONFIG["local_dir"] + "/" + log_filename

remote_getter = RemoteFileGetter.new
remote_getter.get_file(data)

log_parser = LogParser.new
File.readlines(data.local_file).collect do |line|
  log_data = log_parser.parse(line)
  next if log_data.nil?
  puts log_data.inspect
end

LOG.info "Ending parsa"
