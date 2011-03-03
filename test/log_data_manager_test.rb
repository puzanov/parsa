require "config"
require "test/unit"
require "lib/log_data_manager"

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

  def test_date
    log_data1 = LogData.new
    log_data1.date = DateTime.now
    log_data1.save
    
    log_data2 = LogData.find(log_data1.id)
  end

  def test_save
    old_data = LogData.new
    old_data.file_id = 1
    old_data.bytes = 1
    old_data.date = DateTime.now
    old_data.save
    
    log_data = LogData.new
    log_data.file_id = 1
    log_data.bytes = 1
    log_data.date = DateTime.now
    
    log_data_manager = LogDataManager.new
    log_data_manager.save log_data

    check_log_data = LogData.where(:file_id => 1, :date => DateTime.now.to_date).first
    assert_equal(2, check_log_data.bytes)
  end
end
