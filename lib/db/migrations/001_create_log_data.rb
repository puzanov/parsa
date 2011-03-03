class CreateLogDatas < ActiveRecord::Migration
  def self.up
    create_table :log_datas do |t|
      t.int :file_id
      t.int :bytes
      t.date :date
    end
  end

  def self.down
    drop_table :log_datas
  end
end
