# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#
def create_sample_user
  user = User.find_or_create_by_username 'user'
  user.update_attributes(:password=>'password',
                         :password_confirmation => 'password',
                         :email => 'user@mail.com')
  user.admin = true
  user.save!
end

def create_sample_course
  @course = Course.find_or_create_by_title "C Strings"
  @course.title = "C Strings"
  @course.description = "Learn how to deal with C style strings"
  @course.finished = true
  @course.save!
end

def create_sample_lesson
  @lesson = Lesson.find_or_create_by_title "Manipulating Strings"
  @lesson.image_url = "http://lorempixum.com/400/200"
  @lesson.description = "Learn basic operations on strings."
  @lesson.text  = "Remove a character from a string"
  @lesson.finished = true
  @course.lessons << @lesson
end

def create_sample_exercise
  e = Exercise.find_or_create_by_title "Remove A Letter From A String"
  e.title       = "Remove A Letter From A String"
  e.description = "Write a function that removes a specific character from a string."
  e.text        = "Write a function that takes a character and a string as aruguments. The function removes the character from the string."
  e.minutes     = 15
  e.unit_test   = UnitTest.new(:src_code=>IO.read("#{Rails.root}/content/unit_test.c"),
                             :src_language=>"c")
  e.finished = true
  e.lesson      = @lesson
  e.save!
  e.stats_sheet.sorting_xp = 100
  e.stats_sheet.array_xp = 100
  @lesson.exercises << e
end

# Sample data for development 
if "development" == Rails.env 
  create_sample_user
  create_sample_course
  create_sample_lesson
  create_sample_exercise
end

# The badges that will be active
active_badges = []

active_badges << TheRookieBadge.new
active_badges << OneThousandLinesOfCode.new
active_badges << FiveThousandLinesOfCode.new
active_badges << TenThousandLinesOfCode.new

# Save or update the badges
active_badges.each do |b|
  db_badge = Badge.find_or_create_by_type b.type
  db_badge.update_attributes(b.attributes)
  db_badge.save!
end
