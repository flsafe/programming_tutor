Given /^there exists a first exercise badge in the database$/ do
  @first_exercise_badge = Factory.create :the_rookie_badge
end

Then /^I should have the exercise experience points assigned to me$/ do
  @I.stats_sheet(true)
  expected_total = @I.stats_sheet.get_shared_xp_fields.count * POINTS_PER_XP_FIELD
  badge_bonus = @I.earned_badges.reduce(0){|sum, b| sum + b.bonus[:total_xp]}
  (@I.stats_sheet.total_xp - badge_bonus).should == expected_total
end

Then /^I should have my usage statistics updated$/ do
  @I.stats_sheet(true).syntax_checks_count.should == 1
  @I.stats_sheet(true).solution_checks_count.should == 1
  @I.stats_sheet.practice_seconds_count.should >= 1
  @I.stats_sheet.loc_count.should >= 1
  
  visit stats_sheet_path

  page.should have_css(".usage-statistic", :count=>StatsSheet.usage_count_fields.count)
end

Then /^I should have the first exercise badge$/ do
  @I.earned_badges.find(:first, 
                        :conditions=>{:title=>"The Rookie"}).should_not == nil 
  @I.stats_sheet.total_xp >= @first_exercise_badge.bonus[:total_xp]
end
