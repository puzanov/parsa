class RenameLogData < ActiveRecord::Migration
  def self.up
    rename_table :log_datas, :log_data
  end

  def self.down
    rename_table :log_data, :log_datas
  end
end
