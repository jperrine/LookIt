require 'test_helper'

class PageTest < ActiveSupport::TestCase
  fixtures :pages, :looks, :users
  
  def setup
    @valid_page = pages(:valid_page)
    @invalid_page = pages(:invalid_page)
    @look = looks(:valid_look)
    @user = users(:valid_user)
  end
  
  test "valid page" do
    assert @valid_page.valid?
    assert @valid_page.save
  end
  
  test "invalid page properties" do
    assert !@invalid_page.valid?
    assert @invalid_page.errors.invalid?(:title)
    assert @invalid_page.errors.invalid?(:content)
    assert @invalid_page.errors.invalid?(:posted)
    assert @invalid_page.errors.invalid?(:look_id)
    assert !@invalid_page.save
  end
  
  test "page belongs to look" do
    assert @valid_page.look_id
    assert @valid_page.look == @look
    look_has_page = false
    @look.pages.each do |p|
      if p == @valid_page
        look_has_page = true
      end
    end
    assert look_has_page
  end
end
