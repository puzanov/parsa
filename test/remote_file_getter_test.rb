require "config"
require "test/unit"
require "digest/md5"
require "lib/remote_file_getter"

class RemoteFileGetterTest < Test::Unit::TestCase
  @@remote_file = "/mnt/src/parsa/test/data/raw/access.log"
  @@remote_archived_file = "/tmp/access.log.gz"
  @@local_file  = "/mnt/src/parsa/test/data/from_sftp_access.log"
  @@remote_file_md5_sum = "0f2c7530017c03e4133c07695caee2dd"
  
  def setup
    puts "deleting #{@@local_file}"
    File.delete(@@local_file) if File.exists?(@@local_file)
    File.delete(@@remote_archived_file) if File.exists?(@@remote_archived_file)
  end

  def test_archive_and_get_file
    data = RemoteFileGetterData.new
    data.host = "ubuntu"
    data.username = "oleg"
    data.password = "oleg"
    data.remote_file = @@remote_file
    data.remote_archived_file = @@remote_archived_file
    data.local_file = @@local_file

    remote_file_getter = RemoteFileGetter.new
    remote_file_getter.get_file(data)
    
    local_file_md5_sum = Digest::MD5.hexdigest(File.read(@@local_file))
    assert_equal(local_file_md5_sum, @@remote_file_md5_sum)
  end
end
