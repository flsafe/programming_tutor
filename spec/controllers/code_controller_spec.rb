require 'spec_helper'

describe CodeController do
  before(:each) do
    @user = User.create!(:username=>"frank",
                         :password=>'password',
                         :password_confirmation=>'password',
                         :email=>'frank@mail.com').as_null_object
    controller.stub(:current_user).and_return(@user)

    @lesson = Lesson.create!(:title=>"Lesson1")
    @exercise = Exercise.create!(:title=>"exercise",
                                 :minutes=>1,
                                 :unit_test=>stub_model(UnitTest, 
                                                        :src_code=>"c", 
                                                        :src_language=>'c'),
                                 :solution_template=>stub_model(SolutionTemplate, 
                                                                :src_code=>'c', 
                                                                :src_language=>'c',
                                                                :prototype=>'c')).as_null_object
    @lesson.exercises << @exercise
  end

  def valid_attributes
    {:title=>"Title1",
    :description=>"Description1",
    :text=>"Text1"}
  end

  describe "#start" do
    before(:each) do
    end

    context "when the user has no current code session for an exercise" do
      it "starts a new code session" do
        @user.should_receive(:start_coding)
        get 'start', :id=>@exercise.id
      end
      it "redirects to #show" do
        get 'start', :id=>@exercise.id
        response.should redirect_to(:action=>:show)
      end
    end

    context "when the user already has code session for an exercise" do
      before(:each) do
        @user.stub(:code_session).and_return stub_model(CodeSession)
      end
      it "redirects to #already_doing_exercise" do
        get 'start', :id=>@exercise.id
        response.should redirect_to choose_code_path 
      end
      it "does not start a new code session" do
        @user.should_not_receive(:start_code_session)
        get 'start', :id=>@exercise.id
      end
      context "when the the user's current exercise is requested" do
        it "redirects to #show" do
          @user.stub(:current_exercise).and_return(@exercise)
          get 'start', :id=>@exercise.id
          response.should redirect_to code_path
        end
      end
    end
  end

  describe "post do_action" do
    before(:each) do
      @user.start_coding @exercise
    end
    it "saves the users code to the current rails session (to redisplay with non ajax clients)"do
      post :do_action, :code=>{'src_code'=>"int main(){return 0;}"}, :commit=>"Check Syntax"
      session[:code].should == {'src_code'=>"int main(){return 0;}"}
    end

    context "when the user pressed the 'Check Syntax' button" do
      it "runs a syntax check on the code" do
        Code.stub(:new).and_return(@code = mock_model(Code)) 
        @code.should_receive :get_syntax_message
        post :do_action, :commit=>"Check Syntax"
      end
      it  "assigns the syntax check message to session[:message]"do
        @code = stub_model(Code, :get_syntax_message=>"None")
        Code.stub(:new).and_return(@code)
        post :do_action, :commit=>"Check Syntax"
        session[:message].should == "None"
      end
    end

    context "when the user pressed the 'Check Solution' button" do
      before(:each) do
        @user.start_coding @exercise
        @code = stub_model(Code, :check_against=>"unit test results")
        Code.stub(:new).and_return(@code)
      end
      it "runs the code through the unit tests" do
        @code.should_receive :check_against
        post :do_action, :commit=>"Check Solution"
      end
      it  "assigns the syntax check message to session[:message]"do
        post :do_action, :commit=>"Check Solution"
        session[:message].should == "unit test results"
      end
    end

    context "when the user pressed the 'Submit Solution' button" do
      before(:each) do
        @user.start_coding @exercise
        Code.stub(:new).and_return(@code = mock_model(Code).as_null_object) 
        @code.stub(:grade_against).and_return(@gs = stub_model(GradeSheet))
      end
      it "grades the user's code" do
        @code.should_receive(:grade_against)
        post :do_action, :commit=>"Submit Solution"
      end
      it "saves the resultant grade sheet in the session" do
        post :do_action, :commit=>"Submit Solution"
        session[:grade_sheet].should_not == nil 
      end
      it "ends the current exercise session" do
        controller.should_receive :do_quit
        post :do_action, :commit=>"Submit Solution"
      end
      it "redirects to the grade action" do
        post :do_action, :commit=>"Submit Solution"
        response.should redirect_to(:action=>:grade)
      end
    end

    context "When the user pressed 'Quit'" do
      before(:each) do
        @user.start_coding @exercise
      end
      it "destroys the users' current code session" do
        @user.code_session = mock_model(CodeSession).as_null_object
        @user.code_session.should_receive(:destroy)
        post :do_action, :commit=>"Quit"
      end
      it "assigns nil to the user's code session" do
        post :do_action, :commit=>"Quit"
        @user.code_session.should == nil
      end
      it "assigns nil to the session code variable" do
        session[:code] = 'Test Code'
        post :do_action, :commit=>"Quit", :code=>"Test Code"
        session[:code].should == nil
      end
      it "assigns nil to the session message variable" do
        session[:message] = 'Test Code'
        post :do_action, :commit=>"Quit", :code=>"Test Code"
        session[:message].should == nil
      end
      it "redirects to the exercise's lesson page" do
        post :do_action, :commit=>"Quit"
        response.should redirect_to lesson_path(@lesson) 
      end
    end
  end

  describe "get #show" do
    before(:each) do
      @user.start_coding @exercise
    end

    it "assigns the exercise for this code session" do
      get :show
      assigns(:exercise).should eq(@exercise)
    end

    it "assigns the message" do
      get :show
      assigns(:message).should_not == nil
    end
  end

  describe "get grade" do
    it "assigns the grade sheet" do
      session[:grade_sheet] = (@gs = stub_model(GradeSheet))
      get :grade
      assigns(:grade_sheet).should_not == nil
    end
  end
end
