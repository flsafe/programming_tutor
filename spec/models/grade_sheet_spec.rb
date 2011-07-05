require 'spec_helper'

describe GradeSheet do
  describe "GradeSheet#grades_for" do
    before(:each) do
      @user = Factory.create :user
      @course = Factory.create :course
      @lesson = @course.lessons.first
      @lesson.exercises << Factory.build(:exercise)
      @ex1 = @lesson.exercises[0] 
      @ex2 = @lesson.exercises[1] 
    end

    it "returns a hash representing for the exercises the user has done and the grade" do
      do_exercise_with_perfect_grade(@ex1)
      do_exercise_with_perfect_grade(@ex2)
      GradeSheet.grades_for(@user).should == {@ex1.id => 100.0, @ex2.id => 100.0}  
    end
    it "returns the higest grade for each exercise" do
      do_exercise_with_failing_grade(@ex1)
      do_exercise_with_perfect_grade(@ex1)
      GradeSheet.grades_for(@user).should == {@ex1.id => 100.0}
    end

    def do_exercise_with_perfect_grade(exercise)
      create_perfect_grade_sheet(exercise).save!
    end

    def do_exercise_with_failing_grade(exercise)
      gs = create_perfect_grade_sheet(exercise)
      gs.add_unit_test("test1" => {:input => "a", :output => "b", :expected => "a"})
      gs.save!
    end

    def create_perfect_grade_sheet(exercise)
      gs = GradeSheet.new(:user=>@user,
            :exercise => exercise,
            :lesson => @lesson,
            :course => @course)
      gs.add_unit_test("test1" => {:input => "a", :output => "a", :expected => "a"})
      gs
    end
  end

  describe "#add_unit_test" do
  end
end
