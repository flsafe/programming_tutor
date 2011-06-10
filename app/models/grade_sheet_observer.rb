class GradeSheetObserver < ActiveRecord::Observer

  def after_save(grade_sheet)
    @grade_sheet = grade_sheet

    if not_a_retake and @grade_sheet.grade == 100.0
      grade_sheet.user_stats_sheet.update_with(@grade_sheet)
    end
  end

  def not_a_retake 
    1 >= GradeSheet.where(:grade=>100.0,
                     :user_id=>@grade_sheet.user.id,
                     :exercise_id=>@grade_sheet.exercise.id).count

  end
end
