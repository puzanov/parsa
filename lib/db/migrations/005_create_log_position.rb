class CreateLogPosition < ActiveRecord::Migration
  def self.up
    create_table :log_position do |t|
      t.integer :filepath
      t.integer :position
    end
  end

  def self.down
    drop_table :log_position
  end
end
