class CodeSession < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise

  validates :user, :exercise, :presence=>true
end
