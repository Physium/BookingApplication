require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking = bookings(:booking1)
    @user = User.create(first_name:"Valerie", last_name:"Lee", email: "valeriel@vmware.com", username: 'vlee', password: "VMware1!")
    @user1 = users(:user1)
  end

  test "should get index" do
    sign_in_as(@user)
    get bookings_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user)
    get new_booking_url
    assert_response :success
  end

  test "should create booking" do
    sign_in_as(@user)
    @booking = Booking.new(start_time:"2020-07-24 08:00:00", end_time: "2020-07-24 09:00:00", room_id: rooms(:room1).id, user_id: users(:user1).id, title: "test booking", description: "test")
    assert_difference('Booking.count') do
      post bookings_url, params: { booking: { end_time: @booking.end_time, room_id: @booking.room_id, start_time: @booking.start_time, user_id: @booking.user_id , title: @booking.title, description: @booking.description} }
    end

    assert_redirected_to booking_url(Booking.last)
  end

  test "should show booking" do
    sign_in_as(@user)
    get booking_url(@booking)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user1)
    get edit_booking_url(@booking)
    assert_response :success
  end

  test "should update booking" do
    sign_in_as(@user)
    patch booking_url(@booking), params: { booking: { end_time: @booking.end_time, room_id: @booking.room_id, start_time: @booking.start_time, user_id: @booking.user_id, title: "test edit"} }
    assert_redirected_to booking_url(@booking)
  end

  test "should destroy booking" do
    sign_in_as(@user)
    assert_difference('Booking.count', -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end
end
