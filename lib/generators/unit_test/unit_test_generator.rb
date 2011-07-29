class UnitTestGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :unit_test_functions, :type => :array, :required => true, :banner => "test_name test_name"

  LANG_EXT = {'c' => 'c',
              'javascript' => 'js'}

  def generate_unit_test 
    template "unit_test.#{LANG_EXT[name]}.erb", "unit_test.#{LANG_EXT[name]}"
  end

  private
end
