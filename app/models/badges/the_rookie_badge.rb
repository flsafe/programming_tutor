class TheRookieBadge < Badge
  def has_earned?(stats)
    stats.total_xp >= 1
  end

  def affect(stats)
    stats.total_xp += bonus[:total_xp]
    stats.save
  end

  def bonus
    b = Hash.new
    b[:total_xp] = 1500
    b
  end
end
