Factory.define :course do |c|
  c.title "Course"
  c.description "Description"
  c.finished true
  c.lessons {|lessons| [lessons.association(:lesson)]}
end
