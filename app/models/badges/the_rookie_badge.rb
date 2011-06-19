class TheRookieBadge < Badge
  def has_earned?(stats)
    stats.total_xp >= 1
  end
end
