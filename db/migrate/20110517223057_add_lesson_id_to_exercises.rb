class AddLessonIdToExercises < ActiveRecord::Migration
  def self.up
    add_column :exercises, :lesson_id, :integer
  end

  def self.down
    remove_column :exercises, :lesson_id 
  end
end
