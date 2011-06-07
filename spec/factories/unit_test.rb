Factory.define :unit_test do |f|
  f.src_code IO.read(File.join(Rails.root, "content", "unit_test.rb"))
  f.src_language 'ruby'
end
