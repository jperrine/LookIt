ActionController::Routing::Routes.draw do |map|  
  map.resources :users, 
    :collection => {:check_username => :get, :login => [:get, :post], :logout => :get} do |users|
  	users.resources :looks, 
  	  :collection => {:published => :get, :working => :get},
  	  :member => {:publish => :put, :unpublish => :put} do |looks|
  	    looks.resources :pages, :except => 'index'
	  end
  end
  map.connect '/users/:user_id/looks/tags/:id', :controller => 'looks', :action => 'tags'
  map.connect '/users/:id/edit/password', :controller => 'users', :action => 'change_password'

  map.connect '/public-looks/view/:look_id/pages/:id.:format', :controller => 'published_looks', :action => 'view'
  map.connect '/public-looks/:action/:id.:format', :controller => 'published_looks'
  
  map.root :controller => 'users', :action => 'new'
  map.catch_all '*url', :controller => 'error'
end
