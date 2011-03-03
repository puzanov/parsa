class LogData < ActiveRecord::Base
  def file_id
    self[:file_id]
  end
  def bytes
    self[:bytes]
  end
  def date
    self[:date]
  end
end

