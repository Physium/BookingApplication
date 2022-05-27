require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    # admin user
    @user = users(:user2)
  end

  test 'should get index' do
    sign_in_as(@user)
    get users_url
    assert_response :success
  end

  test 'should get new' do
    get new_user_url
    assert_response :success
  end

  test 'should create user' do
    test_password = BCrypt::Password.create('VMware1!')

    assert_difference('User.count') do
      post users_url,
           params: { user: { email: 'test@email.com', first_name: 'Test', last_name: 'Testing', password: 'VMware1!',
                             username: 'tester123' } }
    end

    assert_redirected_to login_url
  end

  test 'should show user' do
    sign_in_as(@user)
    get user_url(@user)
    assert_response :success
  end

  test 'should get edit' do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  test 'should update user' do
    sign_in_as(@user)
    @update_user = users(:user1)
    patch user_url(@update_user),
          params: { user: { email: @update_user.email, first_name: @update_user.first_name, last_name: @update_user.last_name,
                            password: 'VMware1!', username: @update_user.username } }
    assert_redirected_to '/users'
  end

  test 'should destroy user' do
    sign_in_as(@user)
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
