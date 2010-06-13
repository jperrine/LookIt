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
  end
  
  test "valid look attributes" do
    assert @valid_look.valid?
    assert @valid_look.save
    @valid_look.title = nil
    assert !@valid_look.valid?
  end
  
  test "valid look has_many pages" do
    page = Page.new
    page.title = "title"
    page.content = "content"
    page.posted = Time.now
    page.look = @valid_look
    assert page.save
    look_has_page = false
    @valid_look.pages.each do |p|
      if p == page
        look_has_page = true
      end
    end
    assert look_has_page
    assert page.look == @valid_look
  end
end
