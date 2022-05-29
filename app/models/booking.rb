class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  scope :bookings_between, -> (start_time, end_time) do
    where('start_time <= ? AND end_time >= ?', end_time, start_time)
  end
  scope :room_bookings_between, ->(room_id, start_time, end_time) do
    where(room: room_id).bookings_between(start_time, end_time)
  end

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :title, presence: true
  validate :check_time_slot, :check_time, :check_date

  def check_time_slot
    return if no_overlap_bookings?

    errors.add(:start_time, 'Selected time has other bookings in place')
    errors.add(:end_time, 'Selected time has other bookings in place')
  end

  def no_overlap_bookings?
    return where.not(id: id).room_bookings_between(room_id, start_time, end_time).blank? if persisted?

    Booking.room_bookings_between(room_id, start_time, end_time).blank?
  end

  def check_time
    return if start_time <= end_time

    errors.add(:start_time, 'Start time is greater than or equal to end time')
  end

  def check_date
    return if start_time.to_date == end_time.to_date

    errors.add(:start_time, 'Keep bookings to a day only!')
    errors.add(:end_time, 'Keep bookings to a day only!')
  end
end
