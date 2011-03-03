class ChangeDateColumn < ActiveRecord::Migration
  def self.up
    change_column :log_data, :date, :date  
  end

  def self.down
    change_column :log_data, :date, :datetime  
  end
end
