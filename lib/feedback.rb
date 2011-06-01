class Feedback
  
  # Return a friendly feedback message
  # based on the grade sheet.
  def self.on(grade_sheet)
    if grade_sheet.unit_tests_failed?
      Rails.logger.error "An invalid grade sheet was produced:"
      grade_sheet.errors.full_messages.each {|msg| Rails.logger.error(msg)}
      return "I'm embarrased! An internal error occurred, sorry about that. Try again a bit later."
    end

    grade_sheet.unit_tests.each_pair do |test_name, result|
      if result[:error]
        return to_friendly_error_msg(result[:error])
      elsif result[:output].strip.chomp != result[:expected].strip.chomp
        return to_friendly_msg(result)
      end
    end
    "This looks like it could work!"
  end

  # The unit test encountered an error,
  # give some feedback.
  def self.to_friendly_error_msg(error)
    case error
      when :compile_error then "Your solution doesn't compile!"
      when :runtime_error then "I think this would crash at runtime."
      when :timeout_error then "I think this goes into an infinite loop."
      when :memory_error  then "I think this would run out of memory."
      when :syscall_error then "You don't have to make that system call!"
    end
  end

  # The unit test failed, give some feedback
  def self.to_friendly_msg(result)
    input  = result[:input].strip.chomp
    output = result[:output].strip.chomp

    case input
      when "" then "Are you sure this would work for the empty string?"
      when input.length > 25 then "I'm not sure this is right, double check it"
      else "Are you sure this would work for the input '#{input}'?"
    end
  end
end
