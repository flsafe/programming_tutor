class AddFinishedToExercises < ActiveRecord::Migration
  def self.up
    add_column :exercises, :finished, :boolean
  end

  def self.down
    remove_column :exercises, :finished
  end
end
