require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @room = Room.new(name: 'Random Room', capacity: 10)
  end

  test 'room should be valid' do
    assert @room.valid?
  end

  test 'room name should be present' do
    @room.name = ' '
    assert_not @room.valid?
  end

  test 'room capacity should be present' do
    @room.capacity = nil
    assert_not @room.valid?
  end
  test 'room capcity should be integer' do
    @room.capacity = 1.123
    assert_not @room.valid?
  end

  test 'room capacity should be a positive integer only' do
    @room.capacity = -10
    assert_not @room.valid?
  end
end
