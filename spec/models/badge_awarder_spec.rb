require 'spec_helper'

describe BadgeAwarder do
  describe "#after_save" do
    POINTS_PER_FIELD = 1

    before(:each) do
      @user = Factory.create(:user)
      @first_ex_badge = Factory.create(:the_rookie_badge)
      @exercise = Factory.build(:exercise)
      StatsSheet.shared_xp_fields.each do |m|
        @exercise.stats_sheet.send("#{m}=", POINTS_PER_FIELD)
      end
      @exercise.save!
    end

    it "assigns to the user any badges that they have earned" do
      @grade_sheet = create_grade_sheet
      @grade_sheet.save!
      @user.earned_badges.find(:first, 
               :conditions=>{:title=>"The Rookie"}).should_not == nil
    end

    it "creates a new notification for the user" do
      @grade_sheet = create_grade_sheet
      @grade_sheet.save!
      Notification.where(:user_id=>@user).count.should == 1
    end

    def create_grade_sheet
      gs = GradeSheet.new(:user=>@user,
                     :exercise=>@exercise,
                     :src_code=>"code")
      gs.add_unit_test("Test one"=>{:input=>'a',
                                    :output=>'a',
                                    :expected=>'a'})

      gs
    end
  end
end
