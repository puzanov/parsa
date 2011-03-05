class ChangeFilepathColumn < ActiveRecord::Migration
  def self.up
    change_column :log_position, :filepath, :string  
  end

  def self.down
    change_column :log_data, :filepath, :integer  
  end
end
