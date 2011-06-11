module ExercisesHelper

  def grade_for(user, opts)
    unless user.anonymous?
      exercise = opts[:on]
      grades = GradeSheet.grades_for(user) 
      return grades[exercise.id] || ""         
    end
    ""
  end
end
