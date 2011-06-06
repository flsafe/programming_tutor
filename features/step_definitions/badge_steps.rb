Given /^there exists a first exercise badge in the database$/ do
  @first_exercise_badge = Badge.new do |b|
    b.title = "The Rookie"
    b.description = "Complete your first exercise"
    b.earn_conditions = "def has_earned?(stats) stats.total_xp > 1;end"
  end
  @first_exercise_badge.save!
end

Then /^I should have the exercise experience points assigned to me$/ do
  # These stats were specified when the grade sheet was created.
  @I.stats_sheet(true)
  total = @I.stats_sheet.get_shared_xp_fields.count * POINTS_PER_XP_FIELD
  @I.stats_sheet.total_xp.should == total
end

Then /^I should have the first exercise badge$/ do
  @I.earned_badges.find(:first, 
                        :conditions=>{:title=>"The Rookie"}).should_not == nil 
end
