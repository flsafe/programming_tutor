Then /^I should have the exercise experience points assigned to me$/ do
  # These stats were specified when the grade sheet was created.
  @I.stats_sheet(true)
  total = @I.stats_sheet.get_shared_xp_fields.count * POINTS_PER_XP_FIELD
  @I.stats_sheet.total_xp.should == total
end
