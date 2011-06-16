# User's can earn badges. The field earn_conditions
# is expected to be the definition (in string form) of a function named
# `has_earned?(stats_sheet)` that returns true if the badge should
# be awared.

class Badge < ActiveRecord::Base

  has_and_belongs_to_many :users

  scope :finished, lambda{ where(:finished => true)}

  # Return the user's unearned badges
  def self.unearned_badges_for(user)
    badge_ids = user.earned_badges.map{|b| b.id}.push(0)
    where("badges.id NOT IN (:badge_ids)", :badge_ids=>badge_ids).all
  end

  # Returns true if this badge whould be
  # rewarded based on the user's stat_sheet
  def award?(stats_sheet)
    if earn_conditions
      begin
      class_eval earn_conditions 
      has_earned?(stats_sheet)
      rescue
        nil
      end
    end
  end
end
