class LessonCertificate < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :course
  belongs_to :user

  validates :lesson, :course, :user, :presence => true
end
