class Lesson < ActiveRecord::Base
  validates :title, :description, :text, :presence=>true
  validates :title, :uniqueness=>true

  def to_param
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
