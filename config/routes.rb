ActionController::Routing::Routes.draw do |map|  
  map.login '/login.:format', :controller => 'users', :action => 'login'
  map.logout '/logout.:format', :controller => 'users', :action => 'logout'
  
  map.resources :users do |users|
  	users.resources :looks do |looks|
  	  looks.resources :pages
	  end
  end
  
  map.publish '/users/:user_id/looks/:id/publish.:format', :controller => 'looks', :action => 'publish'
	map.unpublish '/users/:user_id/looks/:id/unpublish.:format', :controller => 'looks', :action => 'unpublish'
  
  map.published_looks '/users/:user_id/published-looks.:format', :controller => 'users', :action => 'published_looks'
  map.working_looks '/users/:user_id/working-looks.:format', :controller => 'users', :action => 'working_looks'
  
  map.connect '/user/check_username', :controller => 'users', :action => 'check_username'

  map.connect '/public-looks/view/:look_id/pages/:id.:format', :controller => 'published_looks', :action => 'view'
  map.connect '/public-looks/:action/:id.:format', :controller => 'published_looks'
  
  map.root :controller => 'users', :action => 'new'
  
end
