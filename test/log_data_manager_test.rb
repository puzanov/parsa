require "config"
require "test/unit"
require "lib/log_data"

ActiveRecord::Base.logger = LOG

class LogDataManagerTest < Test::Unit::TestCase
  def setup
    LogData.delete_all
  end
  
  def test_smoke
    log_data = LogData.new
    log_data.file_id = 1
    log_data.bytes = 1
    log_data.date = DateTime.now
    log_data.save
  end
end
