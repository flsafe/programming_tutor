require 'spec_helper'

describe TheRookieBadge do
  before(:each) do
    @badge = TheRookieBadge.new
  end

  describe "#has_earned?" do
    it "awards the badge if the stats has at least 1 xp" do
      stats = stub_model(StatsSheet, :total_xp=>100)
      @badge.has_earned?(stats).should == true    
    end
    it "does not award the badge if the total xp is == 0" do
      stats = stub_model(StatsSheet, :total_xp=>0)
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
end
