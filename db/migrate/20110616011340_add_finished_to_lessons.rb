class AddFinishedToLessons < ActiveRecord::Migration
  def self.up
    add_column :lessons, :finished, :boolean
  end

  def self.down
    remove_column :lessons, :finished
  end
end
