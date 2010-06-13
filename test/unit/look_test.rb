require 'test_helper'

class LookTest < ActiveSupport::TestCase
  fixtures :looks, :users
  
  def setup
    @valid_look = looks(:valid_look)
    @invalid_look = looks(:invalid_look)
    @user = users(:valid_user)
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
  
  test "valid look has tags" do
    assert @valid_look.tag_list.empty?
    @valid_look.tag_list = "cool, winner, awesome"
    assert @valid_look.save
    assert @valid_look.tag_list == ['cool', 'winner', 'awesome']
  end
  
  test "valid length constraints on title and content" do
    title = ''
    content = ''
    256.times do |x|
      title += '1'
    end
    501.times do |x|
      content += '1'
    end
    @valid_look.title = title
    @valid_look.content = content
    assert !@valid_look.valid?
    assert @valid_look.errors.invalid?(:title)
    assert @valid_look.errors.invalid?(:content)
    assert !@valid_look.save
    @valid_look.title = "new title"
    @valid_look.content = "new content"
    assert @valid_look.save
    assert !@valid_look.errors.invalid?(:content)
    assert !@valid_look.errors.invalid?(:title)
  end
  
  test 'look belongs to user' do
    assert @valid_look.user_id
    assert @valid_look.user == @user
    assert !@user.looks.empty?
  end
end
