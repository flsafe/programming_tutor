class AddCourseIdToLessonCertificate < ActiveRecord::Migration
  def self.up
    add_column :lesson_certificates, :course_id, :integer
  end

  def self.down
    remove_column :lesson_certificates, :course_id
  end
end
