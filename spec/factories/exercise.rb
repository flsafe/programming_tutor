Factory.define :exercise do |f|
  f.title "Exercise"
  f.unit_test {|ut| ut.association :unit_test}
  f.minutes 1
end
