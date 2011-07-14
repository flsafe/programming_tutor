require 'spec_helper'

# This is a template spec that you should
# modify to describe the Ten Thousand Lines Of Code badge.

describe TenThousandLinesOfCode do
  before(:each) do
    @badge = TenThousandLinesOfCode.new
  end

  describe "#has_earned?" do
    it "awards the badge if the stats has at least 1 xp" do
      stats = stub_model(StatsSheet, :loc_count => 10000)
      @badge.has_earned?(stats).should == true    
    end
    it "does not award the badge if the total xp is < 10000" do
      stats = stub_model(StatsSheet, :loc_count => 1000)
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
