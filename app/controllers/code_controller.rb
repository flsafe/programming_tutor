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

  # GET code (code url)
  # Show the text editor and problem text
  def show
    begin
      @exercise = current_user.current_exercise
    rescue ActiveRecord::RecordNotFound
      redirect_to home_url, :notice=>"Exercise doesn't exist."
    else
      respond_to do |format|
        format.html
      end
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
