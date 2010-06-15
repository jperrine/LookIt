require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  fixtures :users, :looks, :pages
  
  def setup
    @user = users(:valid_user)
    @look = looks(:valid_look)
    @page = pages(:valid_page)
  end
  
  test 'page index' do
    get :index, {:user_id => @user.to_param, :look_id => @look.to_param}, {:user_id => @user.id}
    assert_redirected_to [@user, @look, @look.pages.first]
  end
  
  test 'new page' do
    get :new, {:user_id => @user.to_param, :look_id => @look.to_param}, {:user_id => @user.id}
    assert_response :success
    assert_template 'new'
  end
  
  test 'edit page' do
    get :edit, {:user_id => @user.to_param, :look_id => @look.to_param, :id => @page.to_param}, {:user_id => @user.id}
    assert_response :success
    assert_template 'edit'
  end
  
  test 'create page' do
    @new_page = {:title => 'my new page', :content => 'this is an awesome'}
    post :create, {:user_id => @user.to_param, :look_id => @look.to_param, :page => @new_page}, {:user_id => @user.id}
    @new_page = Page.find_by_title('my new page')
    assert !@new_page.nil?
    assert_redirected_to [@user, @look, @new_page]
  end
  
  test 'update page' do
    @updated_page = {:title => 'my new page updated', :content => 'this is awesome'}
    put :update, {:user_id => @user.to_param, :look_id => @look.to_param, :id => @page.to_param, :page => @updated_page}, {:user_id => @user.id}
    @updated_page = Page.find_by_title('my new page updated')
    assert_equal @updated_page.id, @page.id
    assert_redirected_to [@user, @look, @updated_page]
  end
  
  test 'show page' do
    get :show, {:user_id => @user.to_param, :look_id => @look.to_param, :id => @page.to_param}, {:user_id => @user.id}
    assert_response :success
    assert_template 'show'
  end
  
  test 'destroy page' do
    delete :destroy, {:user_id => @user.to_param, :look_id => @look.to_param, :id => @page.to_param }, {:user_id => @user.id}
    assert_redirected_to [@user, @look]
    assert !Page.exists?(@page.id)
  end
end