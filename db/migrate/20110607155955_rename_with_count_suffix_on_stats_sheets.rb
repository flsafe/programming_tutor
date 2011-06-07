class RenameWithCountSuffixOnStatsSheets < ActiveRecord::Migration
  def self.up
    rename_column :stats_sheets, :syntax_checks, :syntax_checks_count
    rename_column :stats_sheets, :solution_checks, :solution_checks_count
    rename_column :stats_sheets, :total_practice_seconds, :practice_seconds_count
  end

  def self.down
    rename_column :stats_sheets, :syntax_checks_count, :syntax_checks
    rename_column :stats_sheets, :solution_checks_count, :solution_checks
    rename_column :stats_sheets, :practice_seconds_count, :total_practice_seconds 
  end
end
