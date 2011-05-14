class Lesson < ActiveRecord::Base
  validates :title, :description, :text, :presence=>true
  validates :title, :uniqueness=>true
end
