class RemoteFileGetter
  def get_file data
    Net::SSH.start(data.host, data.username, :password => data.password) do |ssh|
      ssh.sftp.connect do |sftp|
        ssh.exec!("gzip #{data.remote_file}")
        sftp.download!("#{data.remote_file}.gz", "#{data.local_file}.gz")
        system("gunzip", data.local_file)
      end
    end  
  end
end

class RemoteFileGetterData
  attr_accessor :remote_file, :local_file, :host, :username, :password
end

