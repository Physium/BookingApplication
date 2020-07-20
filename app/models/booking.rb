class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  validate :check_time_slot, :check_time, :check_date

  # check for booking overlaps
  def check_time_slot
    overlap_meetings = Booking.all.where("room_id = ? AND start_time <= ? AND end_time >= ?",room_id, start_time, end_time).count

    if overlap_meetings > 0
      errors[:base] << "Current Booking Overlap with Other Bookings"
    end
  end

  def check_time
    if start_time > end_time
      errors.add(:start_time, "is Greater Than or Equal to End Time")
    end
  end

  def check_date
    if start_time.to_date != end_time.to_date
      errors[:base] <<  "Keep Bookings to a Day Only!"
    end
  end

end
