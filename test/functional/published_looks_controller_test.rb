require 'test_helper'

class PublishedLooksControllerTest < ActionController::TestCase
  fixtures :users, :looks, :pages
  
  def setup
    @user = users(:valid_user)
    @look = looks(:published_look)
    @page = pages(:published_page)
  end
  
  test 'published looks index' do
    get :index
    assert_response :success
    assert_template 'index'
  end
  
  test 'search' do
    get :search
    assert_response :success
    assert_template 'search'
  end
  
  test 'search results' do
    get :results, {:query => 'jperrine'}
    assert_response :success
    assert_template 'results'
  end
  
  test 'view by user' do
    get :user, {:id => @user.id}
    assert_response :success
    assert_template 'user'
  end
  
  test 'view look directly' do
    get :view, {:id => @look.id}
    assert_response :success
    assert_template 'view'
  end
  
  test 'view look page' do
    get :view, {:look_id => @look.id, :id => @page.id}
    assert_response :success
    assert_template 'view'
  end
  
  test 'view looks by tag' do
    get :tag, {:id => 'tagtest'}
    assert_response :success
    assert_template 'tag'
  end
end
