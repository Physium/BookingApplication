class WelcomeController < ApplicationController

  skip_before_action :authorized, only: [:index]
  
  def index
    @bookings = Booking.all
  end
end
