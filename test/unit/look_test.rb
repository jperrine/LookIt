require 'test_helper'

class LookTest < ActiveSupport::TestCase
  fixtures :looks
  
  def setup
    @valid_look = looks(:valid_look)
    @invalid_look = looks(:invalid_look)
  end
  
  test "invalid look attributes" do
    look = Look.new
    assert !look.valid?
    assert look.errors.invalid?(:title)
    assert look.errors.invalid?(:content)
    assert look.errors.invalid?(:posted)
    assert look.errors.invalid?(:user_id)
    assert look.errors.invalid?(:published)
  end
  
  test "valid look attributes" do
    assert @valid_look.valid?
    assert @valid_look.save
    @valid_look.title = nil
    assert !@valid_user.valid?
  end
end
