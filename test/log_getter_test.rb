require "test/unit"

class LogGetterTest < Test::Unit::TestCase
  def test_get_file
    require 'net/sftp'
    Net::SFTP.start('host', 'username', :password => 'password') do |sftp|
      sftp.download!("/path/to/remote", "/path/to/local")
    end
  end
end


