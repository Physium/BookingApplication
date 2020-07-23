require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save without title" do
    booking = Booking.new(start_time:"2020-07-20 19:00:00", end_time:"2020-07-20 20:00:00", room_id:1, user_id:1)
    assert_not booking.save, "Saved the booking without a title"
  end

  test "should not overlap with other bookings" do
    print @bookings['booking1']['start_time']
    booking = Booking.new(bookings[:one].start_time, bookings[:one].end_time, bookings[:one].room_id, bookings[:one].user_id,bookings[:one].title)
    assert_not booking.save, "Create the booking with overlap bookings"
  end
end
