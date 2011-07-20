require 'spec_helper'

# This is a template spec that you should
# modify to describe the My First Semester Badge badge.

describe MyFirstSemesterBadge do
  before(:each) do
    @badge = MyFirstSemesterBadge.new

    @user = Factory.create :user
    @course = Factory.create :course
  end

  describe "#has_earned?" do
    it "Awards the badge if the user has at least one completed course certificate" do
      CourseCertificate.create! :user => @user, :course => @course
      stats = stub_model(StatsSheet, :total_xp=>100, :xp => @user)
      @badge.has_earned?(stats).should == true    
    end
    it "doesn't reward the badge if the user has 0 completed course certificates" do
      stats = stub_model(StatsSheet, :xp => @user)
      @badge.has_earned?(stats).should == false 
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
end
