class AddFinishedToBadges < ActiveRecord::Migration
  def self.up
    add_column :badges, :finished, :boolean
  end

  def self.down
    remove_column :badges, :finished
  end
end
