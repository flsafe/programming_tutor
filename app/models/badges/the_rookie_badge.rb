class TheRookieBadge < Badge

  after_initialize :set_description

  def set_description
    self.title = "The Rookie"
    self.description = "Complete your first exercise! +1500 XP"
    self.finished = true
  end

  def has_earned?(stats)
    stats.total_xp >= 1
  end

  def affect(stats)
    stats.total_xp += bonus[:total_xp]
  end

  def bonus
    b = Hash.new(0)
    b[:total_xp] = 1500
    b
  end
end
