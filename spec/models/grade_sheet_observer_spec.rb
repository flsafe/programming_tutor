require 'spec_helper'

describe GradeSheetObserver do

  POINTS_PER_FIELD = 100

  describe "#after_save" do
    before(:each) do
      @user = Factory.create(:user)
      @exercise = Factory.build(:exercise)
      StatsSheet.shared_xp_fields.each do |m|
        @exercise.stats_sheet.send("#{m}=", POINTS_PER_FIELD)
      end
      @exercise.save!
    end

    it "saves updates the experience points in the user's stats sheet if the grade is a 100" do
      gs = create_grade_sheet
      gs.save!
      @user.stats_sheet.total_xp.should == StatsSheet.shared_xp_fields.count * POINTS_PER_FIELD
    end

    it "it does not update experience points if the grade is not a 100" do
      gs = create_grade_sheet
      gs.add_unit_test("Test two"=>{:input=>'a', :output=>'b', :expected=>'a'})
      gs.save!
      @user.stats_sheet.total_xp.should == 0 
    end

    it "It sets the current level" do
      gs = create_grade_sheet
      gs.save!
      @user.stats_sheet.level.should_not == 0
    end

    it "It sets the xp to the next level" do
      gs = create_grade_sheet
      gs.save!
      @user.stats_sheet.xp_to_next_level.should_not == 0
    end

    def create_grade_sheet
      @grade_sheet = GradeSheet.new(:user=>@user,
                     :exercise=>@exercise,
                     :src_code=>"code")
      @grade_sheet.add_unit_test("Test one"=>{:input=>'a',
                                             :output=>'a',
                                             :expected=>'a'})
      @grade_sheet
    end
  end
end
