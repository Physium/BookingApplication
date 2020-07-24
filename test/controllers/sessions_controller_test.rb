require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  setup do 
    test_password = BCrypt::Password.create("VMware1!")
    @user = User.create(first_name:"Ah Kow", last_name:"Tan", email:"ahkow@vmware.com", username:"ahkow", password_digest: test_password)

  end

  test "should get login page" do
    get login_path
    assert_response :success
  end

  test "should store login session via create" do
    post login_path(@user)
    assert_response :success
  end

  test "should destory session via logout" do
    get logout_path
    assert_redirected_to '/'
  end

end
