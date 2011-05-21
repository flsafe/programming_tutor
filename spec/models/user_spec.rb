require 'spec_helper'

describe User do

  def valid_attributes
    {:username=>"frank", 
     :password=>"password", 
     :password_confirmation=>"password",
     :email=>"frank@mail.com"}
  end

  describe ".start_coding" do
    before(:each) do
      @user = User.create!(valid_attributes)
    end

    it "assigns a new code session to the user" do
      @user.should_receive(:code_session=)
      @user.start_coding(stub_model(Exercise))
    end

    it "saves the new session" do
      expect {
        @user.start_coding(stub_model(Exercise))
      }.to change {CodeSession.count}
    end

    context "when the user already has an exercise session" do
      it "doesn't assign a new session until #end_session is called" do
        @user.start_coding(stub_model(Exercise))

        @user.should_not_receive(:code_session=)
        @user.start_coding(stub_model(Exercise))
      end
    end
  end

  describe "#end_code_session" do
    before(:each) do
      @user = User.create!(valid_attributes)
      @mock_session = mock_model(CodeSession).as_null_object
      @user.code_session = @mock_session
    end

    it "destrosy the current session" do
      @mock_session.should_receive(:destroy)
      @user.end_code_session
    end

    it "unassigns the current session" do
      @user.should_receive(:code_session=).with(nil)
      @user.end_code_session
    end

    context "when the user has no session" do
      it "does nothing" do
        @user.code_session = nil
        @user.should_not_receive(:code_session=)
        @user.end_code_session
      end
    end
  end

  describe "#seconds_left_in_code_session" do
    it "returns the number of seconds left in the code session" do 
      pending
      user = User.create!(valid_attributes)
      exercise = stub_model(Exercise, :minutes=>30)
      user.start_coding exercise
      user.code_session.stub(:created_at=>Time.new("1:00"))
      Time.stub(:now).and_return(Time.new("1:25"))
      user.seconds_left_in_code_session.should == 5 * 60 # 5 mins * 60 sec/min
    end
  end
end
