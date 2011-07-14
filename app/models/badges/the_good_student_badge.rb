class TheGoodStudentBadge < Badge

  after_initialize :set_description

  def set_description
    self.title = "The Good Student Badge"
    self.description = "Finish a course by completing the lessons in increasing difficulty +1500 XP"
    self.image_url = "http://example.com/example.png"
    self.finished = true 
  end

  # Write a function definition that
  # returns true if the StatsSheet meets the criteria
  # for awarding this badge.
  def has_earned?(stats)
    if stats.xp.instance_of?(User)
      @user = stats.xp
      @lessons = get_lessons_in_completion_order
      completed_in_increasing_order?
    end
  end

  # Write a function that affects the user's 
  # stats when this badge is awareded. 
  def affect(stats)
    stats.total_xp += bonus[:total_xp]
  end

  def get_lessons_in_completion_order
    course_certs = CourseCertificate.where(:user_id => @user.id).joins(:course).order(:created_at).limit(1)
    [] if course_certs.empty?
    course = course_certs.first.course

    lessons = LessonCertificate
    .where(:user_id => @user.id, :course_id => course.id)
      .joins(:lesson).order('created_at ASC')
        .map{|lc| lc.lesson}
    lessons
  end

  def completed_in_increasing_order?
    return false if @lessons.empty?

    current_diffculty = @lessons.first.difficulty
    @lessons.each do |l|
      difficulty = l.difficulty
      if difficulty != current_diffculty
        if difficulty == current_diffculty + 1
          current_diffculty = difficulty
        else
          return false
        end
      end
    end
    true
  end

  # Describes any bonus points that this badge
  # awards when the badge is awarded.
  def bonus
    b = Hash.new(0)
    b[:total_xp] = 1500
    b
  end
end
