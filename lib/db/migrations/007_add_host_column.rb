class AddHostColumn < ActiveRecord::Migration
  def self.up
    add_column :log_position, :host, :string  
  end

  def self.down
    remove_column :log_position, :host  
  end
end
