class AddDifficultyToLesson < ActiveRecord::Migration
  def self.up
    add_column :lessons, :difficulty, :integer
  end

  def self.down
    remove_column :lessons, :difficulty
  end
end
