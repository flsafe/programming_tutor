require 'spec_helper'

describe Exercise do

  def valid_user_attributes
    {:username=>'frank',
      :password=>'password',
      :password_confirmation=>'password',
      :email=>'frank@mail.com'}
  end

  def valid_exercise_attributes
    text = {:src_code=>'+', :src_language=>'brainfuck'}
    {:title=>'title',
     :minutes=>'30',
     :solution_template=>stub_model(SolutionTemplate, text),
     :unit_test=>stub_model(UnitTest)}
  end
end
