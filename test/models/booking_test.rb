require 'test_helper'

class BookingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save without title" do
    booking = Booking.new
    assert_not booking.save, "Saved the booking without a title"
  end
end
