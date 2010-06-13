require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users, :looks, :pages
  
  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
    @look = looks(:valid_look)
    @page = pages(:valid_page)
  end
  
  test "invalid user attributes" do
    user = User.new
    assert !user.valid?
    assert user.errors.invalid?(:username)
    assert user.errors.invalid?(:display_name)
    assert user.errors.invalid?(:email)
    user.email = "bobntom@blah"
    assert user.errors.invalid?(:email)
  end
  
  test "valid user attributes" do
    assert @valid_user.valid?
    assert @valid_user.save
    @valid_user.username = nil
    assert !@valid_user.valid?
  end
  
  test "tests duplicate username and email check" do
    user = User.new
    user.username = @valid_user.username
    user.email = @valid_user.email
    assert !user.save
    assert user.errors.invalid?(:username)
    assert user.errors.invalid?(:email)
  end
  
  test "test authentication of user" do 
    user = User.authenticate(@valid_user.username, 'password')
    assert user == @valid_user
    user = User.authenticate(@valid_user.username, '')
    assert user != @valid_user
  end
  
  test "test user.match_password" do
    assert User.match_password(@valid_user.hashed_password, 'password', @valid_user.salt)
    assert !User.match_password(@valid_user.hashed_password, '', @valid_user.salt)
  end
  
  test "test user update_settings" do
    user = User.new
    User.update_settings(@valid_user, user)
    assert_equal user.email, @valid_user.email
    assert_equal user.display_name, @valid_user.display_name
    assert_equal user.birthdate, @valid_user.birthdate
    assert_equal user.bio, @valid_user.bio
  end
  
  test "test user has many looks, which has many pages" do
    assert_equal @valid_user.looks.first, @look
    assert_equal @valid_user.looks.first.pages.first, @page
    assert !@valid_user.looks.empty?
    assert !@valid_user.looks.first.pages.empty?
  end
end
