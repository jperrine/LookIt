require 'test_helper'

class LooksControllerTest < ActionController::TestCase
  fixtures :users, :looks, :pages
  
  def setup
    @user = users(:valid_user)
    @look = looks(:valid_look)
    @page = pages(:valid_page)
  end
  #must include :user_id in ALL requests as looks are nested under users in routing
  
  test 'index' do
    get :index, {:user_id => @user.id}, {:user_id => @user.id}
    assert_response :redirect
    assert_redirected_to @user
  end
  
  test 'new look' do
    get :new, {:user_id => @user.id}, {:user_id => @user.id}
    assert_response :success
    assert_template 'new'
  end
  
  test 'edit look' do
    get :edit,  {:user_id => @user.id, :id => @look.id}, {:user_id => @user.id}
    assert_response :success
    assert_template 'edit'
  end
  
  test 'create look' do
    @new_look = {:title => 'test look', :content => 'this look is awesome'}
    post :create, {:user_id => @user.id, :look => @new_look}, {:user_id => @user.id}
    @new_look = Look.find_by_title('test look')
    assert !@new_look.nil?
    assert_redirected_to [@user, @new_look]
  end
  
  test 'update look' do
    @updated_look = {:title => 'updated look title', :content => @look.content}
    put :update, {:user_id => @user.id, :id => @look.id, :look => @updated_look}, {:user_id => @user.id}
    @updated_look = Look.find_by_title('updated look title')
    assert !@updated_look.nil?
    assert_equal @updated_look.id, @look.id
    assert_redirected_to [@user, @updated_look]
  end
  
  test 'show look' do
    get :show, {:user_id => @user.to_param, :id => @look.to_param}, {:user_id => @look.id}
    assert_response :success
    assert_template 'show'
  end
  
  test 'destroy look' do
    @look_to_delete = Look.last
    delete :destroy, {:user_id => @user.to_param, :id => @look_to_delete.to_param }, {:user_id => @user.id}
    assert !Look.exists?(@look_to_delete.id)
    assert_redirected_to @user
  end
  
  test 'unpublish look' do
    put :unpublish, {:user_id => @user.to_param, :id => @look.to_param }, {:user_id => @user.id}
    assert_redirected_to [@user, @look]
    @updated_look = Look.find(@look.id)
    assert !@updated_look.published
  end
  
  test 'publish look' do
    put :publish, {:user_id => @user.to_param, :id => @look.to_param }, {:user_id => @user.id}
    assert_redirected_to [@user, @look]
    @updated_look = Look.find(@look.id)
    assert @updated_look.published
  end
end