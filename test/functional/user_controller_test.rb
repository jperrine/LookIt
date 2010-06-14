require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  fixtures :users
  
  def setup
    @user = users(:valid_user)
  end
  
  test "index" do
    get :index
    assert_response :redirect
    assert_redirected_to :action => 'login'
  end
  
  test "show without user" do
    get :show, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'login'
  end
  
  test 'show with user' do
    get :show, {:id => 1}, {:user_id => @user.id}
    assert_response :success
    assert_template 'show'
  end
  
  test 'show with wrong user' do
    get :show, {:id => 3}, {:user_id => @user.id}
    assert_response :redirect
    assert_redirected_to :root
  end
  
  test 'new without logged in user' do
    get :new
    assert_response :success
    assert_template 'new'
  end
  
  test 'new with logged in user' do
    get :new, {}, {:user_id => @user.id}
    assert_response :redirect
    assert_redirected_to :action => 'show'
  end
  
  test 'edit with user' do
    get :edit, {:id => 1}, {:user_id => @user.id}
    assert_response :success
    assert_template 'edit'
  end
  
  test 'edit without user' do
    get :edit, {:id => 1}, {}
    assert_response :redirect
    assert_redirected_to :login
  end
  
  test 'edit wrong user' do
    get :edit, {:id => 3}, {:user_id => @user.id}
    assert_response :redirect
    assert_redirected_to :root
  end
  
  test 'login' do
    post :login, :username => @user.username, :password => 'password'
    assert_response :redirect
    assert_redirected_to @user
    assert_equal session[:user_id], @user.id
  end
  
  test 'login bad password' do
    post :login, :username => @user.username, :password => 'blah'
    assert_template 'login'
    assert_nil session[:user_id]
  end
  
  test 'new user register' do 
    post :create, :user => { :username => 'user', :password => 'password', :email => 'mail@mal.com', :display_name => 'new user' }
    @new_user = User.find_by_username('user')
    assert @new_user
    assert_redirected_to @new_user
  end
  
  test 'logout' do
    get :logout, {}, {:user_id => @user.id}
    assert_nil session[:user_id]
    assert_redirected_to :login
  end
  
  test 'check username' do
    #get :check_username, {:username => @user.username}, {}
    #assert_response false
  end
end