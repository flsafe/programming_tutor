# User's can earn badges. The Badge class
# should be considered an abstract class with the
# virtual methods :has_earned?(stats_sheet) and
# :affect(user).
#
# The method :has_earned? return true if the stats_sheet
# given qualifies for the badge. 
# 
# The method :affect(stats_sheet) will award
# bonus points XP points to the given stats sheet. 
class Badge < ActiveRecord::Base

  has_and_belongs_to_many :users

  scope :finished, lambda{ where(:finished => true)}

  # Return the user's unearned badges
  def self.unearned_badges_for(user)
    badge_ids = user.earned_badges.map{|b| b.id}.push(0)
    where("badges.id NOT IN (:badge_ids)", :badge_ids=>badge_ids).all
  end
end
