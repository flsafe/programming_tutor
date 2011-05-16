class CreateHints < ActiveRecord::Migration
  def self.up
    create_table :hints do |t|
      t.text :text
      t.integer :exercise_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hints
  end
end
