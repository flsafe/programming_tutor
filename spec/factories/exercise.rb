Factory.define :exercise do |f|
  f.title "Exercise"
  f.unit_test {|ut| ut.association :unit_test}
  f.solution_template {|st| st.association :solution_template}
  f.minutes 1
end
