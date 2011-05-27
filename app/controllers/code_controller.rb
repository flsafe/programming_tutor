class CodeController < ApplicationController

  CHECK_SYNTAX    = "Check Syntax"
  CHECK_SOLUTION  = "Check Solution"
  SUBMIT_SOLUTION = "Submit Solution"

  ACTION_FOR = {CHECK_SYNTAX     => :show,
                CHECK_SOLUTION   => :show,
                SUBMIT_SOLUTION  => :grade}

  # POST code/start/:id
  # Create a new exercise session
  def start
    begin
      exercise = Exercise.find params[:id]
      respond_to do |format|
        format.html do
          if current_user.code_session == nil
            current_user.start_coding exercise 
            url = code_url
          else
            url = choose_code_url
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
    @code = Code.new(params[:code])
    session[:message] = case params[:commit]
                          when CHECK_SYNTAX    then do_syntax_check
                          when CHECK_SOLUTION  then do_solution_check
                          when SUBMIT_SOLUTION then do_solution_grading
                        end
    action = ACTION_FOR[params[:commit]] || :show
    respond_to do |format|
      format.html {redirect_to(:action=>action)}
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

  # GET check
  # Get the results of running
  # the code through the unit tests.
  def check
    
  end

  # GET code/grade
  # Get grade for the current exercise
  def grade 
    @grade_sheet = GradeSheet.for(current_user)
  end

  # GET code/already_doing_exercise
  # Give option of redirecting to the current exercise
  # or starting a new one
  def already_doing_exercise
    
  end

  private

  def do_syntax_check
    @code.get_syntax_message
  end

  def do_solution_check
    curr_exercise = current_user.current_exercise
    @code.check_against(curr_exercise.unit_test, 
                        curr_exercise.solution_template)
  end

  def do_solution_grading
    curr_exercise = current_user.current_exercise
    @code.grade_against(curr_exercise.unit_test, 
                        curr_exercise.solution_template,
                        current_user)
  end
end
