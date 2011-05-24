class SolutionTemplate < ActiveRecord::Base
  belongs_to :exercise

  validates :src_code, :src_language, :presence=>true

  @@PROTOTYPE_REGEX = /\/\*start_prototype\*\/(.*)\/\*end_prototype\*\//m

  def uploaded_solution_template=(solution_template_field)
    self.src_code = solution_template_field.read
    self.src_language = 'c'
  end

  # Returns the code between the
  # start_prototye and end_prototype markers
  # in the src code for this template.
  def prototype 
    m = src_code.match(@@PROTOTYPE_REGEX)
    if m and m[1]
      m[1].strip.chomp
    else
      ""
    end
  end

  # Fill in the solution tempalte with the user's solution
  # code. 
  def fill_in(solution_snippet)
    src_code.gsub(@@PROTOTYPE_REGEX, solution_snippet).strip.chomp
  end
end
