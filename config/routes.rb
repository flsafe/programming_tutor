Rasberry::Application.routes.draw do
  resources :grade_sheets

  resources :exercises

  resources :lessons
  resources :users
  resources :user_sessions

  resource :account, :controller => 'users'

  match "login" => "user_sessions#new", :as=>:login

  # Routes for the text editor used when coding an exercise
  match "code/start/:id"=>"code#start", :as=>:start_coding
  match "code/quit"=>"code#quit", :as=>:quit_coding, :via=>:post

  match "code"=>"code#show", :as=>:code, :via=>:get
  match "code/check"=>"code#check", :as=>:check_code, :via=>:post
  match "code/check"=>"code#get_check", :as=>:get_check, :via=>:get

  match "code/grade"=>"code#grade", :as=>:grade_code, :via=>:post
  match "code/grade"=>"code#get_grade", :as=>:get_grade, :via=>:get

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "lessons#index", :as=>:home

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
