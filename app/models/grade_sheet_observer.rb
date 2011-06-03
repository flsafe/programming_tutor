class GradeSheetObserver < ActiveRecord::Observer
  def after_save(grade_sheet)
    grade_sheet.user_stats_sheet.update_with(grade_sheet)
  end
end
