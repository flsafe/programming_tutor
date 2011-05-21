require 'spec_helper'

describe CodeController do

  def valid_attributes
    {:title=>"Title1",
    :description=>"Description1",
    :text=>"Text1"}
  end

  describe "#start" do
    before(:each) do
      @user = mock_model(User, :code_session=>nil).as_null_object
      controller.stub(:current_user).and_return(@user)
      Exercise.stub(:find).and_return(stub_model(Exercise))
    end

    context "when the user has no current session" do
      it "starts a new code session" do
        @user.should_receive(:start_coding)
        get 'start', :id=>0
      end

      it "redirects to #code" do
        get 'start', :id=>0
        response.should redirect_to(:action=>:show)
      end
    end

    context "when the user already has a session" do
      before(:each) do
        @user.stub(:code_session).and_return stub_model(CodeSession)
      end

      it "redirects to 'already_doing_exercise" do
        get 'start', :id=>0 
        response.should redirect_to choose_code_path 
      end

      it "does not start a new session" do
        @user.should_not_receive(:start_code_session)
      end
    end
  end

  describe "get #show" do
    before(:each) do
      @user = User.create!(:username=>"frank",
                         :password=>'password',
                         :password_confirmation=>'password',
                         :email=>'frank@mail.com')
      @exercise = Exercise.create!(:title=>"exercise",
                                 :minutes=>1,
                                 :unit_test=>stub_model(UnitTest, 
                                                        :src_code=>"c", 
                                                        :src_language=>'c'),
                                 :solution_template=>stub_model(SolutionTemplate, 
                                                                :src_code=>'c', 
                                                                :src_language=>'c',
                                                                :prototype=>'c'))
      controller.stub(:current_user).and_return(@user)
      @user.start_coding @exercise
    end

    it "assigns the exercise for this code session" do
      get :show
      assigns(:exercise).should eq(@exercise)
    end

    it "assigns the time remaining to complete the exercise"
  end
end