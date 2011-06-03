class CreateStatsSheets < ActiveRecord::Migration
  def self.up
    create_table :stats_sheets do |t|
      t.integer :xp_id
      t.string  :xp_type

      t.integer :syntax_checks, :default => 0
      t.integer :solution_checks, :default => 0
      t.integer :total_practice_seconds, :default => 0
      t.integer :total_xp, :default => 0
      t.integer :sorting_xp, :default => 0
      t.integer :searching_xp, :default => 0
      t.integer :numeric_xp, :default => 0
      t.integer :hash_xp, :default => 0
      t.integer :linked_list_xp, :default => 0
      t.integer :array_xp, :default => 0
      t.integer :level, :default => 0
      t.integer :xp_to_next_level, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :stats_sheets
  end
end
