require "config"
require "test/unit"
require "lib/log_filename"

class LogFilenameTest < Test::Unit::TestCase
  def test_get
    filename = LogFilename.get
    date = 1.day.ago.to_date.to_s.split("-")
    assert_equal filename, "access-#{date[0]}_#{date[1]}_#{date[2]}.log"
  end
end
