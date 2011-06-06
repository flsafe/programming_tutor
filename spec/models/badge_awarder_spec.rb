require 'spec_helper'

describe BadgeAwarder do
  describe "#after_save" do

    def get_xp_fields(user_stats_sheet)
      user_stats_sheet.public_methods.select{|m| m=~ /_xp$/}.reject do |m| 
        m=~/^autosave/ or m=~/total_xp/ or m=~/^_/
      end
    end

    POINTS_PER_FIELD = 1

    it "assigns to the user any badges that they have earned" do
      @user = User.create!(:username=>"frank",
               :email=>"frank@mail.com",
               :password=>"password",
               :password_confirmation=>"password")

      first_ex_badge = Badge.create!(:title=>"The Rookie",
                         :description=>"Finish your first ex",
                         :earn_conditions=>"def has_earned?(ss) ss.total_xp > 1;end")
      first_ex_badge.save!

      @exercise = Exercise.create!(:title=>"Exercise",
                   :unit_test=>stub_model(UnitTest, :src_code=>"c", :src_language=>"c"),
                   :solution_template=>stub_model(SolutionTemplate, :src_code=>"c", :src_language=>"c"),
                   :minutes=>1)
      @xp_fields = get_xp_fields(@user.stats_sheet)
      @xp_fields.each do |m|
        @exercise.stats_sheet.send("#{m}=", POINTS_PER_FIELD)
      end
      @exercise.save!


      @grade_sheet = GradeSheet.new(:user=>@user,
                     :exercise=>@exercise,
                     :src_code=>"code")
      @grade_sheet.add_unit_test("Test one"=>{:input=>'a',
                                             :output=>'a',
                                             :expected=>'a'})
      @grade_sheet.save!

      @user.earned_badges.find(:first, 
               :conditions=>{:title=>"The Rookie"}).should_not == nil
    end
  end
end
