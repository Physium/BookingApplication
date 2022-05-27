require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  setup do
    # admin user
    @user = users(:user2)
  end

  test 'should get index' do
    sign_in_as(@user)
    get '/admin'
    assert_response :success
  end
end
