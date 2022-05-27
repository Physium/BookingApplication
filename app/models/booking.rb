class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :title, presence: true
  validate :check_time_slot, :check_time, :check_date

  # check for booking overlaps
  def check_time_slot
    overlap_meetings = if id.nil?
                         Booking.where('room_id = ? AND start_time <= ? AND end_time >= ?', room_id, end_time,
                                       start_time).count
                       else
                         Booking.where('id != ? AND room_id = ? AND start_time <= ? AND end_time >= ?', id, room_id,
                                       end_time, start_time).count
                       end

    if overlap_meetings > 0
      errors.add(:start_time, 'Selected time has other bookings in place')
      errors.add(:end_time, 'Selected time has other bookings in place')
    end
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
