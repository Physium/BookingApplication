require 'test_helper'

class BookingFlowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  setup do
    test_password = BCrypt::Password.create('VMware1!')
    @user = User.create(first_name: 'Ah Kow', last_name: 'Tan', email: 'ahkow@vmware.com', username: 'ahkow',
                        password_digest: test_password)
    @valid_booking = Booking.new(start_time: '2020-08-24 08:00:00', end_time: '2020-08-24 09:00:00',
                                 room_id: rooms(:room1).id, user_id: @user.id, title: 'test booking', description: 'test')
    @invalid_booking = Booking.new(start_time: '2020-07-20 18:00:00', end_time: '2020-07-20 21:00:00',
                                   room_id: rooms(:room1).id, user_id: users(:user1).id, title: 'test booking', description: 'test')
  end

  test 'login and create new booking' do
    get login_path
    assert_response :success

    post login_path, params: { username: @user.username, password: 'VMware1!' }
    assert_redirected_to root_path

    get bookings_url
    assert_response :success

    get new_booking_path
    assert_response :success
    assert_match 'New Booking', response.body

    assert_difference('Booking.count') do
      post bookings_url,
           params: { booking: { end_time: @valid_booking.end_time, room_id: @valid_booking.room_id,
                                start_time: @valid_booking.start_time, user_id: @valid_booking.user_id, title: @valid_booking.title, description: @valid_booking.description } }
    end
    assert_redirected_to booking_url(Booking.last)
  end

  test 'login and create invalid booking' do
    get login_path
    assert_response :success

    post login_path, params: { username: @user.username, password: 'VMware1!' }
    assert_redirected_to root_path

    get bookings_url
    assert_response :success

    get new_booking_path
    assert_response :success
    assert_match 'New Booking', response.body

    assert_no_difference('Booking.count') do
      post bookings_url,
           params: { booking: { end_time: @invalid_booking.end_time, room_id: @invalid_booking.room_id,
                                start_time: @invalid_booking.start_time, user_id: @invalid_booking.user_id, title: @invalid_booking.title, description: @invalid_booking.description } }
    end
    assert_match 'Selected time has other bookings in place', response.body
  end

  test 'login and edit existing booking' do
    @valid_booking.save

    get login_path
    assert_response :success

    post login_path, params: { username: @user.username, password: 'VMware1!' }
    assert_redirected_to root_path

    get bookings_url
    assert_response :success
    assert_match 'Upcoming Bookings', response.body
    assert_match '2020-08-24', response.body

    get edit_booking_url(@valid_booking)
    patch booking_url(@valid_booking),
          params: { booking: { end_time: @valid_booking.end_time, room_id: @valid_booking.room_id,
                               start_time: @valid_booking.start_time, user_id: @valid_booking.user_id, title: 'MiniTest Check If Edit Works' } }
    follow_redirect!
    assert_response :success
    assert_match 'MiniTest Check If Edit Works', response.body
  end
end
