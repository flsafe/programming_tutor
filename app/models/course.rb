class Course < ActiveRecord::Base

  has_many :lessons, :order => "difficulty ASC", :conditions => ["lessons.finished = ?", true]

  scope :finished, lambda{ where(:finished => true) }

  def to_s
    "#{id}-#{title.gsub(/[^a-z0-9]+/i, '-').downcase}"
  end
  
  def to_param
    to_s
  end
end
