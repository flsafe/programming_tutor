class AddLocCountToStatsSheet < ActiveRecord::Migration
  def self.up
    add_column :stats_sheets, :loc_count, :integer, :default => 0
  end

  def self.down
    remove_column :stats_sheets, :loc_count
  end
end
