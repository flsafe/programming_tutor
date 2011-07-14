# Two models make use of the stats sheet. The user model
# and the exercise model.
#
# A user's stats sheet keeps track of the experience
# points they've earned for completing exercises.
# 
# An exercise's stats sheet describes what xp
# the user will earn after completing the exercise. 

class StatsSheet < ActiveRecord::Base

  belongs_to :xp, :polymorphic=>true

  def update_with(grade_sheet)
    update_shared_xp_fields(grade_sheet)
    update_loc_count(grade_sheet.src_code)
    calc_total_xp
    self.save!
  end

  # Returns the fields ending in _xp. For example:
  #
  #     searching_xp
  #     sorting_xp
  #     numeric_xp
  #     ...
  #
  # It does not return the total_xp field.
  def get_shared_xp_fields
    StatsSheet.shared_xp_fields
  end

  def self.shared_xp_fields
    StatsSheet.column_names.select{|m| m=~ /_xp$/}.reject{|m| m=~/total_xp/}
  end

  def self.usage_count_fields
    StatsSheet.column_names.select{|m| m=~/_count$/}
  end

  private 

  # Update this stats sheet with the xp points
  # the user earned on the grade sheet.
  def update_shared_xp_fields(grade_sheet)
    StatsSheet.shared_xp_fields.each do |m|
      current_xp = self.send(m)
      updated_xp = current_xp + grade_sheet.exercise_stats_sheet.send(m)
      self[m] += updated_xp
    end
  end

  # Update the lines of code this user has typed.
  def update_loc_count(src_code)
    if src_code
      self.loc_count = src_code.each_line.reject{|l| l.blank?}.count
    end
  end

  # Tally up all the xp fields and
  # update the total_xp field.
  def calc_total_xp
    total = 0
    get_shared_xp_fields.each do |m|
      total += send(m) 
    end
    self.total_xp = total

    self.level = XPModel.level(total_xp)
    self.xp_to_next_level = XPModel.xp_to_next(total_xp)
  end
end
