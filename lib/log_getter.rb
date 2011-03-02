class LogGetter
  def get_log data
    Net::SFTP.start(data.host, data.username, :password => data.password) do |sftp|
      sftp.download!(data.remote_file, data.local_file)
    end
  end
end

class LogGetterData
  attr_accessor :remote_file, :local_file, :host, :username, :password
end

