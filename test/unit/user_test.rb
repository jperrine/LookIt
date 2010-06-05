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
    assert user.errors.invalid?(:birthdate)
  end
  
  test "valid user attributes" do
    assert @valid_user.valid?
    assert @valid_user.save
    @valid_user.username = nil
    assert !@valid_user.valid?
  end
  
  test "tests duplicate username and email check" do
    #todo implement
  end
  
end
