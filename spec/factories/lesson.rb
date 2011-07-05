Factory.define :lesson do |l|
  l.title "Lesson"
  l.description "description"
  l.text "text"
  l.finished true
  l.difficulty 1
  l.exercises {|exercises| [exercises.association(:exercise)]}
end
