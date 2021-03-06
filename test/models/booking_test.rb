require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @booking = Booking.new(start_time: "2020-07-22 19:00:00", end_time: '2020-07-22 20:00:00', room_id: bookings(:booking1).room_id, user_id: bookings(:booking1).user_id, title: "Meeting with Hello World", description: 'Hello World')
  end

  test "booking should be valid" do
    assert @booking.valid?
  end

  test "booking title should be present" do
    @booking.title = " "
    assert_not @booking.valid?, "Saved the booking without a title"
  end

  test "booking should not overlap with other bookings" do
    booking = Booking.new(start_time: bookings(:booking1).start_time, end_time: bookings(:booking1).end_time, room_id: bookings(:booking1).room_id, user_id: bookings(:booking1).user_id,title: bookings(:booking1).title)
    assert_not booking.save, "Create booking that overlap with otherbookings"
  end

  test "booking date to only be within a day" do
    booking = Booking.new(start_time: "2020-07-20 19:00:00", end_time: "2020-07-21 20:00:00", room_id: bookings(:booking1).room_id, user_id: bookings(:booking1).user_id,title: bookings(:booking1).title)
    assert_not booking.save, "Create booking across multiple days"
  end

  test "booking end datetime should not be lesser than start datetime" do
    booking = Booking.new(start_time: "2020-07-20 19:00:00", end_time: "2020-07-21 20:00:00", room_id: bookings(:booking1).room_id, user_id: bookings(:booking1).user_id,title: bookings(:booking1).title)
    assert_not booking.save, "Create booking with end datetime higher than start datetime"
  end

end
