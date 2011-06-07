class UserActionObserver

  DO_ACTION = 'do_action'

  def self.filter(controller)
    if controller.action_name == DO_ACTION
      @user = controller.send(:current_user)
      @controller = controller

      commit = @controller.params[:commit]
      msg = CodeController::DISPATCH_TABLE[commit] 
      send(msg)
    end
  end

  def self.do_syntax_check
     @user.stats_sheet.syntax_checks_count += 1
     @user.stats_sheet.save
  end

  def self.do_solution_check
    @user.stats_sheet.solution_checks_count += 1
    @user.stats_sheet.save
  end

  def self.do_solution_grading
    elapsed = (Time.now - @user.code_session.created_at).ceil()
    @user.stats_sheet.practice_seconds_count += elapsed
    @user.stats_sheet.save
  end

  def self.do_quit
  end
end
