class AddCourseIdToLesson < ActiveRecord::Migration
  def self.up
    add_column :lessons, :course_id, :integer
  end

  def self.down
    remove_column :lessons, :course_id
  end
end
