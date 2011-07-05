class LessonCertificate < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :course
  belongs_to :user

  validates :lesson_id, :uniqueness => true
  validates :lesson, :course, :user, :presence => true
end
