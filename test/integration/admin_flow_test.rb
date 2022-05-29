require 'test_helper'

class AdminFlowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  # test "login as admin and view all bookings" do
  # end

  setup do
    @room = rooms(:room1)
    # admin user
    @normal_user = users(:user1)
    @admin_user = users(:user2)
  end

  test 'login as admin and create rooms' do
    get login_path
    assert_response :success

    post login_path, params: { username: @admin_user.username, password: 'VMware1!' }
    assert_redirected_to root_path

    get rooms_url
    assert_response :success

    assert_difference('Room.count') do
      post rooms_url, params: { room: { capacity: 10, name: 'Tester Room' } }
    end

    follow_redirect!
    assert_response :success
    assert_match 'Tester Room', response.body
  end

  test 'login as admin and create user' do
    get login_path
    assert_response :success

    post login_path, params: { username: @admin_user.username, password: 'VMware1!' }
    assert_redirected_to root_path

    get users_url
    assert_response :success
    assert_difference('User.count') do
      post users_url,
           params: { user: { email: 'test@email.com', first_name: 'Test', last_name: 'Testing', password: 'VMware1!',
                             username: 'tester123' } }
    end

    follow_redirect!
    assert_response :success
    assert_match 'tester123', response.body
  end

  test 'non-admin users are unable to access all admin pages' do
    get login_path
    assert_response :success

    post login_path, params: { username: @normal_user.username, password: 'VMware1!' }
    assert_redirected_to root_path

    get users_path
    assert_redirected_to root_path

    get rooms_path
    assert_redirected_to root_path
  end
end
