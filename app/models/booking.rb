class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :title, presence: true
  validate :check_time_slot, :check_time, :check_date

  # check for booking overlaps
  def check_time_slot
    overlap_meetings = Booking.all.where("room_id = ? AND start_time <= ? AND end_time >= ?",room_id, end_time, start_time).count

    if overlap_meetings > 0
      errors.add(:start_time, "Selected time has other booking in place")
      errors.add(:end_time, "Selected time has other booking in place")
    end
  end

  def check_time
    if start_time >= end_time
      errors.add(:start_time, "Start time is greater than or equal to end time")
    end
  end

  def check_date
    if start_time.to_date != end_time.to_date
      errors.add(:start_time, "Keep bookings to a day only!")
      errors.add(:end_time, "Keep bookings to a day only!")
    end
  end

end
