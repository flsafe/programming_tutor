# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#

user = User.new(:username=>'user',
                :password=>'password',
                :password_confirmation=>'password',
                :email=>'user@mail.com')
user.admin = true;
user.save!

an_exercise = Exercise.new do |e|
  e.title       = "Remove A Letter From A String"
  e.description = "Write a function that removes a specific character from a string."
  e.text        = "Write a function that takes a character and a string as aruguments. The function removes the character from the string."
  e.minutes     = 15
  e.unit_test   = UnitTest.new(:src_code=>IO.read("#{Rails.root}/content/unit_test.rb"),
                             :src_language=>"ruby")
  e.solution_template = SolutionTemplate.new(:src_code=>IO.read("#{Rails.root}/content/solution_template.c"),
                                             :src_language=>'c')
  e.lesson            = Lesson.create!(:title=>"Manipulating Strings",
                                       :description=>"Learn basic operations on strings",
                                       :text=>"There two ways to remove characters from a string...")
end
an_exercise.save!

an_exercise.stats_sheet.sorting_xp = 100
an_exercise.stats_sheet.array_xp = 100
an_exercise.stats_sheet.save!

first_exercise_badge = Badge.new do |b|
  b.title = "The Rookie"
  b.description = "Complete your first exercise"
  b.earn_conditions = "def has_earned?(stats) stats.total_xp > 1;end"
end
first_exercise_badge.save!
