require 'vcr'

VCR.config do |c|
  c.stub_with :webmock
  c.cassette_library_dir     = File.join('features', 'cassettes')
  c.default_cassette_options = { :record => :new_episodes }
end

VCR.cucumber_tags do |t|
  t.tag  '@with_vcr' # uses default record mode since no options are given
end
