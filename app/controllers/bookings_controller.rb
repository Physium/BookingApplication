class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    @booking = Booking.new(booking_params)
    session_id = current_user.id
    @booking.user_id = session_id

    #cur_starttime = DateTime.new(params[:booking]['start_time(1i)'].to_i,params[:booking]['start_time(2i)'].to_i,params[:booking]['start_time(3i)'].to_i,params[:booking]['start_time(4i)'].to_i,params[:booking]['start_time(5i)'].to_i)
    #cur_endtime = DateTime.new(params[:booking]['end_time(1i)'].to_i,params[:booking]['end_time(2i)'].to_i,params[:booking]['end_time(3i)'].to_i,params[:booking]['end_time(4i)'].to_i,params[:booking]['endtime(5i)'].to_i)
    
    #overlaps = Booking.all.where("room_id = ? AND start_time <= ? AND end_time >= ?", params[:booking][:room_id], cur_endtime, cur_starttime).count
    #print overlaps

    #if overlaps > 0
    #  @booking.errors.add(:start_time, "Selected time has other booking in place")
    #end
    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(update_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def update_params
      params.require(:booking).permit(:id, :start_time, :end_time, :room_id, :user_id, :title, :description)
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      params.require(:booking).permit(:start_time, :end_time, :room_id, :user_id, :title, :description)
    end
end
