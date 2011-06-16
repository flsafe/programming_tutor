class Lesson < ActiveRecord::Base

  validates :title, :presence=>true

  has_many :exercises

  scope :finished, lambda{ where(:finished => true) }

  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
