class GradeSheetObserver < ActiveRecord::Observer
  def after_save(grade_sheet)
    if grade_sheet.grade == 100.0
      grade_sheet.user_stats_sheet.update_with(grade_sheet)
    end
  end
end
