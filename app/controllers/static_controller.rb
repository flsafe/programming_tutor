class StaticController < ApplicationController
  def index
    @lessons = Lesson.finished.order("created_at desc").limit(3)
    @leaders = User.leaders
    @courses = current_user.admin? ? Course.all : Course.finished
  end
  
  def about
  end

  def terms
  end

  def privacy 
  end
end
