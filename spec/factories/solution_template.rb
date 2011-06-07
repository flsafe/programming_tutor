Factory.define :solution_template do |f|
  f.src_code IO.read(File.join(Rails.root, "content", "solution_template.c"))
  f.src_language 'c'
end
