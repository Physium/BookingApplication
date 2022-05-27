class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  scope :room_bookings_between, ->(room_id, start_time, end_time) { where('room_id = ? AND start_time <= ? AND end_time >= ?', room_id, end_time, start_time) }

  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :title, presence: true
  validate :check_time_slot, :check_time, :check_date

  # check for booking overlaps
  def check_time_slot
    return if !overlap_meetings?

    errors.add(:start_time, 'Selected time has other bookings in place')
    errors.add(:end_time, 'Selected time has other bookings in place')
  end

  def overlap_meetings?
    return where.not(id: id).room_bookings_between(room_id, end_time, start_time).present? if persisted?

    room_bookings_between(room_id, end_time, start_time).present?
  end

  def check_time
    errors.add(:start_time, 'Start time is greater than or equal to end time') if start_time >= end_time
  end

  def check_date
    if start_time.to_date != end_time.to_date
      errors.add(:start_time, 'Keep bookings to a day only!')
      errors.add(:end_time, 'Keep bookings to a day only!')
    end
  end
end
