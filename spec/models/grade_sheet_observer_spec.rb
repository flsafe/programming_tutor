require 'spec_helper'

describe GradeSheetObserver do

  POINTS_PER_FIELD = 100

  describe "#after_save" do
    before(:each) do
      @user = User.create!(:username=>"frank",
               :email=>"frank@mail.com",
               :password=>"password",
               :password_confirmation=>"password")

      @exercise = Exercise.create!(:title=>"Exercise",
                   :unit_test=>stub_model(UnitTest, :src_code=>"c", :src_language=>"c"),
                   :solution_template=>stub_model(SolutionTemplate, :src_code=>"c", :src_language=>"c"),
                   :minutes=>1)
      @xp_fields = get_xp_fields(@user.stats_sheet)
      @xp_fields.each do |m|
        @exercise.stats_sheet.send("#{m}=", POINTS_PER_FIELD)
      end
      @exercise.save!
    end

    it "saves updates the experience points in the user's stats sheet" do
      gs = create_grade_sheet
      gs.save!
      @user.stats_sheet.total_xp.should == @xp_fields.count * POINTS_PER_FIELD
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

    def get_xp_fields(user_stats_sheet)
      user_stats_sheet.public_methods.select{|m| m=~ /_xp$/}.reject do |m| 
        m=~/^autosave/ or m=~/total_xp/ or m=~/^_/
      end
    end
  end
end
