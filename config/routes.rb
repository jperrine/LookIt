ActionController::Routing::Routes.draw do |map|
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
  
  map.login '/login.:format', :controller => 'users', :action => 'login'
  map.logout '/logout.:format', :controller => 'users', :action => 'logout'
  
  map.resources :users do |users|
  	users.resources :looks do |looks|
  	  looks.resources :pages
	  end
  end
  
  map.publish '/users/:user_id/looks/:id/publish.:format', :controller => 'looks', :action => 'publish'
	map.unpublish '/users/:user_id/looks/:id/unpublish.:format', :controller => 'looks', :action => 'unpublish'
  
  map.published_looks '/users/:user_id/published-looks', :controller => 'users', :action => 'published_looks'
  map.working_looks '/users/:user_id/working-looks', :controller => 'users', :action => 'working_looks'
  
  map.connect '/user/check_username', :controller => 'users', :action => 'check_username'

  map.connect '/public-looks/view/:look_id/pages/:id', :controller => 'published_looks', :action => 'view'
  map.connect '/public-looks/:action/:id.:format', :controller => 'published_looks'
  
  #map.connect 'home/:action', :controller => 'home'
  #map.connect 'home/:action.:format', :controller => 'home'
  
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
  map.root :controller => 'users', :action => 'new'
  
end
