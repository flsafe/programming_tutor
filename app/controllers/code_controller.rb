class CodeController < ApplicationController

  # POST code/start/:id
  # Create a new exercise session
  def start
    session[:current_exercise_id] = params[:id]
    redirect_to :controller=>:code, :action=>:show
  end

  # POST code/quit
  # End the current exercise session
  def quit

  end

  # GET code
  # Show the text editor and problem text
  def show
    begin
      @exercise = Exercise.find(session[:current_exercise_id]) 
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
  # without submitting a grade and give
  # feedback.
  def check

  end

  # GET code/check
  def get_check
    
  end

  # POST code/grade
  # Submit code to be graded.
  def grade

  end

  # GET code/grade
  def get_grade

  end
end
