require "config"
require "lib/log_filename.rb"
require "lib/remote_file_getter.rb"

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

LOG.info "Ending parsa"
