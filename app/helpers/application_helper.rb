module ApplicationHelper
  def badge_progress(user)
    badge_count = Badge.count(:all)
    user_badge_count = user.earned_badges.count
    return "#{user_badge_count}/#{badge_count}"
  end
end
