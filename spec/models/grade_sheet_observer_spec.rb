require 'spec_helper'

describe GradeSheetObserver do

  POINTS_PER_FIELD = 100

  describe "#after_save" do
    before(:each) do
      @user = Factory.create(:user)
      @course = Factory.create(:course)
      @lesson = @course.lessons.first
      @exercise = @lesson.exercises.first 
      StatsSheet.shared_xp_fields.each do |m|
        @exercise.stats_sheet.send("#{m}=", POINTS_PER_FIELD)
      end
      @exercise.save!
    end

    it "saves updates the experience points in the user's stats sheet if the grade is a 100" do
      do_exercise_with_perfect_grade(@exercise)
      @user.stats_sheet.total_xp.should == StatsSheet.shared_xp_fields.count * POINTS_PER_FIELD
    end

    it "it does not update experience points if the grade is not a 100" do
      gs = create_perfect_grade(@exercise) 
      gs.add_unit_test("Test two"=>{:input=>'a', :output=>'b', :expected=>'a'})
      gs.save!
      @user.stats_sheet.total_xp.should == 0 
    end

    it "does not update experience points if the user already has a 100 for that exercise" do
      do_exercise_with_perfect_grade(@exercise)
      do_exercise_with_perfect_grade(@exercise)
      @user.stats_sheet.total_xp.should == StatsSheet.shared_xp_fields.count * POINTS_PER_FIELD
    end

    it "It sets the current level" do
      do_exercise_with_perfect_grade(@exercise)
      @user.stats_sheet.level.should_not == 0
    end

    it "sets the xp to the next level" do
      do_exercise_with_perfect_grade(@exercise)
      @user.stats_sheet.xp_to_next_level.should_not == 0
    end

    it "creates a completed lesson if the user has completed all the exercises in a lesson" do
      finish_course 
      LessonCertificate.count.should == 1 
    end

    it "creates a completed course cert if the user has completed all the exercises in a course" do
      finish_course 
      CourseCertificate.count.should == 1
    end

    def finish_course 
      lessons = @course.lessons
      lessons.each do |lesson|
        exercises = lesson.exercises
        exercises.each{|e| do_exercise_with_perfect_grade(e)}
      end
    end

    def do_exercise_with_perfect_grade(exercise)
      create_perfect_grade(exercise).save!
    end

    def create_perfect_grade(exercise)
      gs = GradeSheet.new :user=>@user, 
        :exercise => exercise, 
        :course => @course, 
        :lesson => @lesson
      gs.add_unit_test("test1" => {:input => "a", :output => "a", :expected => "a"})
      gs
    end
  end
end
