class AddFinishedToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :finished, :boolean
  end

  def self.down
    remove_column :courses, :finished
  end
end
