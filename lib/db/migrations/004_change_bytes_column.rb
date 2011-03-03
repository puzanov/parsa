class ChangeBytesColumn < ActiveRecord::Migration
  def self.up
    change_column :log_data, :bytes, :bigint  
  end

  def self.down
    change_column :log_data, :bytes, :int  
  end
end
