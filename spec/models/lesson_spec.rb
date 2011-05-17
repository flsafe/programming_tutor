require 'spec_helper'

describe Lesson do

  def valid_attributes 
    return {:title=>'title', 
            :description=>'description',
            :text=>'text'}
  end

  before(:each) do
    @lesson = Lesson.new(valid_attributes)
  end

  it "is valid with valid attributes" do
    @lesson.should be_valid
  end

  it "is not valid without a title" do
    @lesson.title = nil
    @lesson.should_not be_valid
  end
end
