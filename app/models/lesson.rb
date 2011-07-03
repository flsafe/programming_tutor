class Lesson < ActiveRecord::Base

  validates :title, :presence=>true

  has_many :exercises

  scope :finished, lambda{ where(:finished => true) }

  def to_s
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-').downcase}"
  end
  
  def to_param
    to_s
  end
end
