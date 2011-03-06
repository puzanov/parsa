class LogPosition < ActiveRecord::Base
  set_table_name :log_position
  def self.get_existing_or_new data
    log_position = LogPosition.where(:filepath => data.remote_file, :host => data.host).first
    if log_position.nil?
      LOG.info "#{data.host} Working with new log"
      log_position = LogPosition.new
      log_position.host = data.host
      log_position.filepath = data.remote_file
      log_position.position = 0
    else
      LOG.warn "#{data.host} Log is not new!"
      LOG.warn "#{data.host} skipping #{log_position.position} lines"
    end
    return log_position
  end
end

