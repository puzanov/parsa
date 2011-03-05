class RemoteFileGetter
  def get_file data
    LOG.info "Connecting to #{data.host} as #{data.username}"
    Net::SSH.start(data.host, data.username, :password => data.password) do |ssh|
      ssh.sftp.connect do |sftp|
        LOG.info "#{data.host} Gziping remote file #{data.remote_file} to #{data.remote_archived_file}"
        ssh.exec!("gzip #{data.remote_file} -c > #{data.remote_archived_file}")
        
        LOG.info "#{data.host} Downloading remote file to #{data.local_file}.gz from #{data.host}"
        sftp.download!("#{data.remote_archived_file}", "#{data.local_file}.gz")
        
        LOG.info "#{data.host} Deleting remote gzipped file"
        ssh.exec!("rm #{data.remote_archived_file}.gz")
        
        LOG.info "Gunziping local file #{data.local_file}"
        system("gunzip", data.local_file)
      end
    end  
  end
end

class RemoteFileGetterData
  attr_accessor :remote_file, :remote_archived_file, :local_file, :host, :username, :password
end

