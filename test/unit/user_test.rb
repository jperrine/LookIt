require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  
  def setup
    @valid_user = users(:valid_user)
    @invalid_user = users(:invalid_user)
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
end
