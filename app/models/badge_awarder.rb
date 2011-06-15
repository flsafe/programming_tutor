# Observes the user stats_sheet and awards badges
# when the badge's award critiria are met. 

class BadgeAwarder < ActiveRecord::Observer

  observe StatsSheet

  # Award unearned badges to the user associated with
  # the stats sheet if the badge criteria is met and
  # the user is not anonymous.
  def after_save(stats_sheet)
    user = stats_sheet.xp
    if user.instance_of?(User) and !user.anonymous?
      user = stats_sheet.xp
      newly_earned = select_earned_from(Badge.unearned_badges_for(user), stats_sheet)
      user.earned_badges << newly_earned
      user.save!

      newly_earned.each do |b|
        Notification.create(:user_id=>user, 
                            :text=>"Woot! You just earned a badge: #{b.title}")
      end
    end
  end

  def select_earned_from(unearned, stats_sheet)
    unearned.select{|b| b.award?(stats_sheet)}
  end
end
