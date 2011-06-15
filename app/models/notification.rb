class Notification < ActiveRecord::Base
  belongs_to :user

  validates :text, :user_id, :presence => true

  scope :from_last_seconds, lambda{|secs|
          Notification.where("created_at >= ?", secs.seconds.ago)}

  scope :for_user, lambda{|user|
          Notification.where("user_id = ?", user.id)}
end
