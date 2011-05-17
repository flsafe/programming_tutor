class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.string :model_table_name
      t.integer :model_id
      t.string :statistic_name

      t.timestamps
    end
  end

  def self.down
    drop_table :statistics
  end
end
