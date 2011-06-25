# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#

# Sample user for development
if Rails.env != 'production'
  user = User.find_or_create_by_username 'user'
  user.update_attributes(:password=>'password',
                         :password_confirmation => 'password',
                         :email => 'user@mail.com')
  user.admin = true
  user.save!
end


# Sample lesson for the sample exercise
l = Lesson.find_or_create_by_title "Manipulating Strings"
l.description = "Learn basic operations on strings."
l.text  = "Remove a character from a string"
l.finished = true
l.save!


# Sample exercise
e = Exercise.find_or_create_by_title "Remove A Letter From A String"
e.title       = "Remove A Letter From A String"
e.description = "Write a function that removes a specific character from a string."
e.text        = "Write a function that takes a character and a string as aruguments. The function removes the character from the string."
e.minutes     = 15
e.unit_test   = UnitTest.new(:src_code=>IO.read("#{Rails.root}/content/unit_test.c"),
                           :src_language=>"c")
e.finished = true
e.lesson      = l
e.save!
e.stats_sheet.sorting_xp = 100
e.stats_sheet.array_xp = 100
e.stats_sheet.save!


# The badges that will be active
active_badges = []

active_badges << TheRookieBadge.new do |b|
  b.title = "The Rookie"
  b.description = "Complete your first exercise"
  b.finished = true
end


# Save or update the badges
active_badges.each do |b|
  db_badge = Badge.find_or_create_by_type b.type
  db_badge.update_attributes(b.attributes)
  db_badge.save!
end
