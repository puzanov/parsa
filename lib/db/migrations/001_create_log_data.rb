class CreateLogData < ActiveRecord::Migration
  def self.up
    create_table :log_datas do |t|
      t.integer :file_id
      t.integer :bytes
      t.datetime :date
    end
  end

  def self.down
    drop_table :log_datas
  end
end
