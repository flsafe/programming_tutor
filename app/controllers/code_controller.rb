class CodeController < ApplicationController

  DISPATCH_TABLE = {"Check Syntax"    => :do_syntax_check,
                    "Check Solution"  => :do_solution_check,
                    "Submit Solution" => :do_solution_grading,
                    "Quit"            => :do_quit}

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
            if exercise == current_user.current_exercise
              url = code_path
            else
              url = choose_code_url
            end
          end
          redirect_to url
        end
      end
    rescue ActiveRecord::RecordNotFound
      logger.info("Attempt to code invalid exercise '#{params[:id]}'")
      redirect_to home_url, :notice=>"Invalid exerise"
    end
  end

  # POST code/do_action
  # Distpatch to the the approriate action
  # depending which submit button the user
  # clicked.
  def do_action
    session[:code] = params[:code]
    @code = Code.new(params[:code])
    respond_to do |format|
      format.html do 
        action = send(DISPATCH_TABLE[params[:commit]])
        redirect_to action
      end
      format.js do 
        template = send(DISPATCH_TABLE[params[:commit]])
        render :template=>template, :layout=>false
      end
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

  # These do_xxxx functions handle both AJAX and HTML requests.
  # There is no real difference between the two except that
  # the AJAX requests render a .js.erb file to update the page
  # and the HTML requests to redirect to update the page.
  # The session message is used to share the results of an action
  # after a redirect. 

  def do_syntax_check
    @message = session[:message] = @code.get_syntax_message
    case 
      when request.xhr?
        return 'code/syntax'
      else
        return {:action=>:show}
    end
  end

  def do_solution_check
    case 
      when request.xhr?
      else
        curr_exercise = current_user.current_exercise
        session[:message] = @code.check_against(curr_exercise.unit_test, 
                              curr_exercise.solution_template)
        return {:action=>:show}
    end
  end

  def do_solution_grading
    case 
      when request.xhr?
      else
        curr_exercise = current_user.current_exercise
        @code.grade_against(curr_exercise.unit_test, 
                            curr_exercise.solution_template,
                            current_user)
        return {:action=>:grade}
    end
  end

  def do_quit
    current_user.end_code_session
    case 
      when request.xhr?
      else
        return {:controller=>:lessons}
    end
  end
end
