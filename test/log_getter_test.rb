require "config"
require "test/unit"
require "digest/md5"
require "lib/log_getter"

class LogGetterTest < Test::Unit::TestCase
  @@remote_file = "/mnt/src/parsa/test/data/access.log.gz"
  @@local_file  = "/mnt/src/parsa/test/data/from_sftp_access.log.gz"
  
  def setup
    puts "deleting #{@@local_file}"
    File.delete(@@local_file) if File.exists?(@@local_file)
  end
  
  def test_get_file
    remote_file_md5_sum = "d472821707a0cc2d25e884b9766ebe8f"
    local_file_md5_sum = ""
    
    data = LogGetterData.new
    data.host = "ubuntu"
    data.username = "oleg"
    data.password = "oleg"
    data.remote_file = @@remote_file
    data.local_file = @@local_file

    log_getter = LogGetter.new
    log_getter.get_log(data)
    
    local_file_md5_sum = Digest::MD5.hexdigest(File.read(@@local_file))
    assert_equal(local_file_md5_sum, remote_file_md5_sum)
  end
end
