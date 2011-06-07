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

    it "saves updates the experience points in the user's stats sheet" do
      gs = create_grade_sheet
      gs.save!
      @user.stats_sheet.total_xp.should == StatsSheet.shared_xp_fields.count * POINTS_PER_FIELD
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
