class GradeSheetObserver < ActiveRecord::Observer

  def after_save(grade_sheet)
    @grade_sheet = grade_sheet
    @user = grade_sheet.user
    @lesson = grade_sheet.lesson
    @course = grade_sheet.course

    if not_a_retake and @grade_sheet.grade == 100.0
      grade_sheet.user_stats_sheet.update_with(@grade_sheet)
      create_lesson_certificate if lesson_finished?
      create_course_certificate if course_finished?
    end
  end

  def lesson_finished? 
    lesson_exercises = @lesson.exercises.map{|e| e.id}
    grades = GradeSheet.grades_for(@user)
    lesson_exercises.all?{|e| 100.0 == grades[e]}
  end

  def course_finished?
    LessonCertificate.where(:user_id => @user.id,
      :course_id => @course.id).count == @course.lessons.count
  end

  def create_lesson_certificate
    if 0 == LessonCertificate.where(:user_id => @user.id, :lesson_id => @lesson.id).count
      LessonCertificate.create! :user => @user, :lesson => @lesson, :course => @course
    end
  end

  def create_course_certificate
    if 0 == CourseCertificate.where(:user_id => @user.id, :course_id => @course.id).count
      CourseCertificate.create! :user => @user, :course => @course
    end
  end

  def not_a_retake 
    1 >= GradeSheet.where(:grade=>100.0,
                     :user_id=>@user.id,
                     :exercise_id=>@grade_sheet.exercise.id).count

  end
end
