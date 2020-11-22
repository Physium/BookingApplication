require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @room = rooms(:room1)
    #admin user
    @user = users(:user2)
  end

  test "should get index" do
    sign_in_as(@user)
    get rooms_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user)
    get new_room_url
    assert_response :success
  end

  test "should create room" do
    sign_in_as(@user)
    assert_difference('Room.count') do
      post rooms_url, params: { room: { capacity: 10, name: "Tester Room" } }
    end

    assert_redirected_to '/rooms'
  end

  test "should show room" do
    sign_in_as(@user)
    get room_url(@room)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_room_url(@room)
    assert_response :success
  end

  test "should update room" do
    sign_in_as(@user)
    patch room_url(@room), params: { room: { capacity: @room.capacity, name: @room.name } }
    assert_redirected_to rooms_url
  end

  test "should destroy room" do
    sign_in_as(@user)
    assert_difference('Room.count', -1) do
      delete room_url(@room)
    end

    assert_redirected_to rooms_url
  end
end
