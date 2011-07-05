class AddCourseIdToGradeSheet < ActiveRecord::Migration
  def self.up
    add_column :grade_sheets, :course_id, :integer
  end

  def self.down
    remove_column :grade_sheets, :course_id
  end
end
