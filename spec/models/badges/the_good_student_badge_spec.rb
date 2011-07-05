require 'spec_helper'

# This is a template spec that you should
# modify to describe the The Good Student Badge badge.

describe TheGoodStudentBadge do
  before(:each) do
    @user = Factory.create :user
    @badge = TheGoodStudentBadge.new
  end

  describe "#has_earned?" do
    it "Awards the badge if all the users has done all the exercises in increase difficulty" do
      create_course
      do_lessons_in_increasing_difficulty
      @badge.has_earned?(@user.stats_sheet).should == true
    end
    it "does not award the badge if the user did some of the exercises out of order" do
      create_course
      do_lessons_in_decreasing_difficulty
      @badge.has_earned?(@user.stats_sheet).should == false
    end
  end
  
  describe "#affect" do
    it "gives +1500xp to the user" do
      stats = stub_model(StatsSheet, :total_xp=>100)
      @badge.affect(stats)
      stats.total_xp.should == 1600
    end
  end

  describe "#bonus" do
    it "returns hash describing the bonus points the badge awards when earned" do
      @badge.bonus[:this_should_not_exist].should == 0
      @badge.bonus[:total_xp].should == 1500
    end
  end

  def create_course
    @course = Factory.create :course
    @course.lessons << Factory.build(:lesson, :difficulty => 2)
    @course.lessons << Factory.build(:lesson, :difficulty => 3)
    @lessons = @course.lessons
  end

  def do_lessons_in_increasing_difficulty
    @lessons.sort_by{|l|l.difficulty}.each do |lesson|
      lesson.exercises.each{|e| do_exercise_with_perfect_grade(e, lesson)} 
    end
  end

  def do_lessons_in_decreasing_difficulty
    @lessons.sort_by{|l|l.difficulty}.reverse.each do |lesson|
      lesson.exercises.each{|e| do_exercise_with_perfect_grade(e, lesson)} 
    end
  end

  def do_exercise_with_perfect_grade(exercise, lesson)
    gs1 = GradeSheet.new(:user=>@user, 
        :exercise => exercise,
        :lesson => lesson, 
        :course => @course)
    gs1.add_unit_test("test1" => {:input => "a", :output => "a", :expected => "a"})
    gs1.save!
  end
end
