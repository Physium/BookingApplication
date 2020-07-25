class AdminController < ApplicationController
  before_action :admin_rights

  def index
    @bookings = Booking.all
    @upcoming_bookings = Booking.all.where('start_time >= ?', DateTime.now())
    @ongoing_bookings = Booking.all.where('start_time <= ? AND end_time >= ?', DateTime.now(),DateTime.now())
    @past_bookings = Booking.all.where('end_time <= ?', DateTime.now())
  end

  def admin_rights
    redirect_to '/' unless administrator?
  end

end
