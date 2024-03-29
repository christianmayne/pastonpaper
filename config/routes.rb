ActionController::Routing::Routes.draw do |map|


  map.resources :users , :member => {:profile => :get}
  
  map.resources :user_sessions
  map.resources :home, :collection => {:document_search => :get, :simple_location_search => :get, :date_search => :get,
                                       :simple_people_search => :get, :simple_organisation_search => :get, :search_results => :any}
  map.resources :documents
  map.connect 'document_image_remove/:id',:controller=>'documents',:action=>'remove_image'

  map.login 'login',  :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.register 'register', :controller => 'users', :action => 'new'
  map.home 'home', :controller => 'home', :action => 'index'
  map.changepassword "changepassword",:controller => "users",:action=>"changepassword"
  map.root :controller => 'home', :action => 'index'
  
  match "/account/deactivate" => "users#accountdeactivate" ,:as =>"deactivateaccount"

  map.connect '/document_statuses/', :controller=>'document_statuses', :action=>'index'
  map.connect '/document_statuses/:id', :controller=>'document_statuses', :action=>'show'

  # Routes for Static Pages 
  match '/about', :to=> 'pages#about'
  match '/contact', :to => 'pages#contact'
  match '/privacy', :to => 'pages#privacy'
  match '/terms', :to => 'pages#terms'
  match '/profile', :to => 'pages#profile'
 
  
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
