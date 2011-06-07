Factory.define :badge do |f|
  f.title "The Rookie"
  f.description "Finish your first exercise"
  f.earn_conditions "def has_earned?(stats) stats.total_xp > 1;end"
end
