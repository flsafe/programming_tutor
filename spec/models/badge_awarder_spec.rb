require 'spec_helper'

describe BadgeAwarder do
  describe "#after_save" do
    POINTS_PER_FIELD = 1

    before(:each) do
      @user = Factory.create(:user)
      @first_ex_badge = Factory.create(:the_rookie_badge)
      @course = Factory.build :course
      @lesson = @course.lessons.first
      @exercise = @lesson.exercises.first
      StatsSheet.shared_xp_fields.each do |m|
        @exercise.stats_sheet.send("#{m}=", POINTS_PER_FIELD)
      end
      @exercise.save!
    end

    it "assigns to the user any badges that they have earned" do
      @grade_sheet = build_grade_sheet
      @grade_sheet.save!
      @user.earned_badges.find(:first, 
               :conditions=>{:title=>"The Rookie"}).should_not == nil
    end
    it "awards any badge bonus" do
      @grade_sheet = build_grade_sheet
      @grade_sheet.save!
      @user.stats_sheet.total_xp.should >= @first_ex_badge.bonus[:total_xp]
    end
    it "creates a new notification for the user" do
      lambda{
        @grade_sheet = build_grade_sheet
        @grade_sheet.save!
      }.should change(Notification.where(:user_id => @user), :count)
    end

    def build_grade_sheet
      gs = GradeSheet.new(:user=>@user,
                     :exercise=>@exercise,
                     :lesson => @lesson,
                     :course => @course,
                     :src_code=>"code")
      gs.add_unit_test("Test one"=>{:input=>'a',
                                    :output=>'a',
                                    :expected=>'a'})

      gs
    end
  end
end
