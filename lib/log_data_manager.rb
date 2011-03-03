class LogDataManager
  require "lib/log_data"
  
  def save log_data
    existing_log_data = LogData.where(:file_id => log_data.file_id, :date => log_data.date.to_date).first
    unless existing_log_data.nil?
      existing_log_data.bytes += log_data.bytes
      existing_log_data.save
      return
    end
    log_data.save
  end
end

