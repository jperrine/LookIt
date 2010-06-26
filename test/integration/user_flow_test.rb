require 'test_helper'

class UserFlowTest < ActionController::IntegrationTest
  fixtures :all
  
  def setup
    @user = users(:valid_user)
  end
  
  test 'user registration' do 
    get "/"
    assert_response :success
    @new_user =  {:email => 'me@me.com', :username => 'jabba', :password => 'password', :password_confirmation => 'password', :display_name => 'Jimmy'}
    post_via_redirect "/users", :user => @new_user
    @new_user = User.find_by_username('jabba')
    assert_equal "/users/#{@new_user.to_param}", path
    assert_equal session[:user_id], @new_user.id
  end
  
  test 'user login' do
    #get '/users/login'
    #post '/users/login', {:username => @user.username, :password => 'password'}
    #assert_equal "/users/#{@user.to_param}", path
    #assert_equal session[:user_id], @user.id
  end
end
