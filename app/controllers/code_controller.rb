class CodeController < ApplicationController

  # POST code/start/:id
  # Create a new exercise session
  def start
    begin
      exercise = Exercise.find params[:id]
      respond_to do |format|
        format.html do
          if current_user.code_session
            url = choose_code_url
          else
            current_user.start_coding exercise 
            url = code_url
          end
          redirect_to url
        end
      end
    rescue ActiveRecord::RecordNotFound
      logger.info("Attempt to code invalid exercise '#{params[:id]}'")
      redirect_to home_url, :notice=>"Invalid exerise"
    end
  end

  # POST code/quit
  # End the current exercise session
  def quit

  end

  # POST code/do_action
  # Distpatch to the the approriate action
  # depending which submit button the user
  # clicked.
  def do_action
    session[:code] = params[:code]
    session[:message] = Code.new(params[:code]).get_syntax_message
    respond_to do |format|
      format.html {redirect_to(:action=>:show)}
    end
  end

  # GET code (code url)
  # Show the text editor and problem text
  def show
    @exercise = current_user.current_exercise
    @code = Code.new(session[:code] || {:src_code=>@exercise.prototype})
    @message = session[:message] || ""

    respond_to do |format|
      format.html
    end
  end

  # POST code/check
  # Run the code throught unit tests
  # without submitting a grade.
  def check

  end

  # GET code/check
  # Get the results of running
  # the code through the unit tests.
  def get_check
    
  end

  # POST code/grade
  # Submit code to be graded.
  def grade

  end

  # GET code/grade
  # Get grade 
  def get_grade

  end

  # GET code/already_doing_exercise
  # Give option of redirecting to the current exercise
  # or starting a new one
  def already_doing_exercise

  end
end
