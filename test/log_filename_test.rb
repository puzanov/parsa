require "config"
require "test/unit"
require "lib/log_filename"

class LogFilenameTest < Test::Unit::TestCase
  def test_get_minus1day
    filename = LogFilename.send :minus1day
    date = 1.day.ago.to_date.to_s.split("-")
    assert_equal filename, "access-#{date[0]}_#{date[1]}_#{date[2]}.log"
  end

  def test_get_actual
    filename = LogFilename.send :current
    date = DateTime.now.to_date.to_s.split("-")
    assert_equal filename, "access-#{date[0]}_#{date[1]}_#{date[2]}.log"
  end

  def test_get_past 
    filename = LogFilename.send :past, "2011_03_01"    
    assert_equal filename, "access-2011_03_01.log"
  end
end
