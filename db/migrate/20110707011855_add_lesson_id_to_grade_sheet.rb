class AddLessonIdToGradeSheet < ActiveRecord::Migration
  def self.up
    add_column :grade_sheets, :lesson_id, :integer
  end

  def self.down
    remove_column :grade_sheets, :lesson_id
  end
end
