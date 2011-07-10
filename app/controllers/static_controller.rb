class StaticController < ApplicationController
  def index
    @lessons = Lesson.finished.order("created_at desc").limit(3)
    @leaders = User.leaders
  end
  
  def about
  end

  def terms
  end

  def privacy 
  end
end
