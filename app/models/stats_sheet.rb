# Represents a user's XP stats sheet.
# Includes things like the total xp and the xp for
# certain lessons like searching_xp, sorting_xp, linked_list_xp
# and others.
#
# Each completed exercise will contain xp information
# and it is also available in the grade sheet that results 
# when a user does an exercise.

class StatsSheet < ActiveRecord::Base
  belongs_to :xp, :polymorphic=>true

  def update_with(grade_sheet)
    update_shared_xp_fields(grade_sheet)
    calc_total_xp
    self.save!
  end

  # Returns the ...._xp feilds on the stats sheet that
  # are shared by exercises. For example each exercise has
  # xp fields like. Theses experience points are tracked
  # in the users's stats sheet.
  #
  #     searching_xp
  #     sorting_xp
  #     numeric_xp
  #     ...
  #
  # This function returns those fields. It does not return
  # the total_xp field since exercises don't use that field.
  #
  def get_shared_xp_fields
    self.public_methods.select{|m| m=~ /_xp$/}.reject do |m| 
      m=~/^autosave/ or m =~ /total_xp/ or m=~/^_/
    end
  end

  private 

  # The exercise that the user completed is worth
  # xp points. Update this stats sheet with these
  # xp points.
  def update_shared_xp_fields(grade_sheet)
    get_shared_xp_fields.each do |m|
      current_xp = self.send(m)
      updated_xp = current_xp + grade_sheet.exercise_stats_sheet.send(m)
      self[m] += updated_xp
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
  end
end
