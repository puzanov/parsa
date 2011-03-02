require "config"
require "test/unit"
require "digest/md5"
require "lib/remote_file_getter"

class RemoteFileGetterTest < Test::Unit::TestCase
  @@remote_file = "/mnt/src/parsa/test/data/raw/access.log"
  @@local_file  = "/mnt/src/parsa/test/data/from_sftp_access.log"
  @@remote_file_md5_sum = "0f2c7530017c03e4133c07695caee2dd"
  
  def setup
    puts "deleting #{@@local_file}"
    File.delete(@@local_file) if File.exists?(@@local_file)
    system("gunzip", "#{@@remote_file}.gz") if File.exists?("#{@@remote_file}.gz")
  end

  def test_archive_and_get_file
    data = RemoteFileGetterData.new
    data.host = "ubuntu"
    data.username = "oleg"
    data.password = "oleg"
    data.remote_file = @@remote_file
    data.local_file = @@local_file

    remote_file_getter = RemoteFileGetter.new
    remote_file_getter.get_file(data)
    
    local_file_md5_sum = Digest::MD5.hexdigest(File.read(@@local_file))
    assert_equal(local_file_md5_sum, @@remote_file_md5_sum)
  end
end
