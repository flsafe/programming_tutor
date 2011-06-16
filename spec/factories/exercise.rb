Factory.define :exercise do |f|
  f.title "Exercise"
  f.unit_test {|e| e.association :unit_test}
  f.minutes 15
  f.finished true
end
