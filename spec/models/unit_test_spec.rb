require 'spec_helper'

describe UnitTest do
  describe "#run_with" do
    before(:each) do
      @unit_test = UnitTest.new(:src_code=>"def test_method1;end ; def test_method2;end", :src_language=>"ruby") 
      IdeoneClient.stub(:new).and_return stub("IdeoneClient")
    end
    it "initializes a grade sheet with the src code parameter" do
      attrs = {:src_code=>'code'}
      GradeSheet.should_receive(:new).with(attrs)
      @unit_test.run_with('code')
    end

    it "class evaluates the unit test src_code" do
      @unit_test.should_receive(:class_eval)
      @unit_test.run_with("code")
    end

    it "calls each method begining with 'test' once" do
      @unit_test.should_receive(:send).with(:test_method1).once
      @unit_test.should_receive(:send).with(:test_method2).once
      @unit_test.run_with("code")
    end

    it "returns a grade sheet" do
     gs =  @unit_test.run_with("code")
     gs.src_code.should == "code" 
    end
  end
end
