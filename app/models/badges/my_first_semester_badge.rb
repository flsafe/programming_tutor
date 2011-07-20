class MyFirstSemesterBadge < Badge

  after_initialize :set_description

  def set_description
    self.title = "My First Semester Badge"
    self.description = "Finish your first course +1500 XP"
    self.image_url = "http://example.com/example.png"
    self.finished = true 
  end

  # Write a function definition that
  # returns true if the StatsSheet meets the criteria
  # for awarding this badge.
  def has_earned?(stats)
    user = stats.xp
    if user.instance_of?(User) 
      return CourseCertificate.where(:user_id => user.id).count >= 1
    end
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
