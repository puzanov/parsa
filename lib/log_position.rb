class LogPosition < ActiveRecord::Base
  set_table_name :log_position

  def position
    self[:position]
  end

  def filepath
    self[:filename]
  end
end

