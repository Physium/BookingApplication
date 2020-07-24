require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    test_password = BCrypt::Password.create("VMware1!")
    @user = User.new(first_name:"Ah Kow", last_name:"Tan", email:"ahkow@vmware.com", username:"ahkow", password_digest: test_password)
  end

  test "user should be valid" do
    assert @user.valid?
  end

  test "first name should be present" do
    @user.first_name = " "
    assert_not @user.valid?
  end

  test "last name should be present" do
    @user.last_name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end
  
  test "email should be valid" do
    @user.email = "abcdefg"
    assert_not @user.valid? 
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should be unique" do
    @user.save
    test_password = BCrypt::Password.create("VMware1!")
    @user2 = User.new(first_name:"Ah Kow", last_name:"Tan", email:"ahkow@vmware.com", username:"ahkow", password_digest: test_password)
    assert_not @user2.valid?
  end

  test "username should not be too short" do
    @user.username = "ab"
    assert_not @user.valid?
  end
end
