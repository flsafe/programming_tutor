class OneThousandLinesOfCode < Badge

  after_initialize :set_description

  def set_description
    self.title = "One Thousand Lines Of Code"
    self.description = "You've written 1K LOC, congrats! +1500 XP"
    self.image_url = "http://example.com/example.png"
    self.finished = true 
  end

  # Write a function definition that
  # returns true if the StatsSheet meets the criteria
  # for awarding this badge.
  def has_earned?(stats)
    stats.loc_count >= 1000
  end

  # Write a function that affects the user's 
  # stats when this badge is awareded. 
  def affect(stats)
    stats.total_xp += bonus[:total_xp]
  end

  # Describes any bonus points that this badge
  # awards when the badge is awarded.
  def bonus
    b = Hash.new(0)
    b[:total_xp] = 1500
    b
  end
end
