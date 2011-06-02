class CodeController < ApplicationController

  DISPATCH_TABLE = {"Check Syntax"    => :do_syntax_check,
                    "Check Solution"  => :do_solution_check,
                    "Submit Solution" => :do_solution_grading,
                    "Quit"            => :do_quit}

  before_filter :ensure_exercise_session, :except=>[:start, :grade]

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
  # Get grade for the current exercise.
  def grade 
    @grade_sheet = GradeSheet.new(session[:grade_sheet])
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
  # and the HTML requests redirect to update the page.
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
    curr_exercise = current_user.current_exercise
    @message = session[:message] = @code.check_against(curr_exercise.unit_test, 
                                      curr_exercise.solution_template)
    case 
      when request.xhr?
        return "code/syntax"
      else
        return {:action=>:show}
    end
  end

  def do_solution_grading
    curr_exercise = current_user.current_exercise
    @grade_sheet = @code.grade_against(curr_exercise.unit_test, 
                        curr_exercise.solution_template,
                        current_user)
    session[:grade_sheet] = @grade_sheet.attributes
    do_quit
    case 
      when request.xhr?
        return 'code/grade_sheet'
      else
        return {:action=>:grade}
    end
  end

  def do_quit
    @current_lesson = current_user.current_exercise.lesson
    current_user.end_code_session
    session[:code] = nil
    session[:message] = nil
    case 
      when request.xhr?
        return 'code/quit'
      else
        return lesson_url(@current_lesson)
    end
  end

  def ensure_exercise_session
    if current_user.code_session.nil?
      redirect_to lessons_url, :notice=>"The coding session has expired"
      return false
    end
  end
end
