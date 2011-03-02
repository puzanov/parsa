require "config"
require "test/unit"
require 'digest/md5'

class LogGetterTest < Test::Unit::TestCase
  @@remote_file = "/mnt/src/parsa/test/data/access.log.gz"
  @@local_file  = "/mnt/src/parsa/test/data/from_sftp_access.log.gz"
  
  def setup
    puts "deleting #{@@local_file}"
    File.delete(@@local_file)
  end
  
  def test_get_file
    remote_file_md5_sum = "d472821707a0cc2d25e884b9766ebe8f"
    local_file_md5_sum = ""
    
    Net::SFTP.start('ubuntu', 'oleg', :password => 'oleg') do |sftp|
      sftp.download!(@@remote_file, @@local_file)
    end
    
    local_file_md5_sum = Digest::MD5.hexdigest(File.read(@@local_file))
    assert_equal(local_file_md5_sum, remote_file_md5_sum)
  end
end


