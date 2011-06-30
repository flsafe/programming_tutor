class BadgeGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def generate_badge_class
    template "badge.rb.erb", "app/models/badges/#{name.underscore}.rb"
  end

  def generate_badge_spec
    template "badge_spec.rb.erb", "spec/models/badges/#{name.underscore}_spec.rb"
  end

  def generate_new_route
    new_route = "resources :#{name.tableize}, :controller => 'badges'"
    route_file = IO.read(File.join(Rails.root, 'config', 'routes.rb'))
    unless route_file.include?(new_route) 
      route(new_route)
    end
  end

  def show_how_to_activate_badge
    readme("README.erb")
  end
end
