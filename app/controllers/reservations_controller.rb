class ReservationsController < ApplicationController
  before_action :require_login

  def index
    @reservations = Reservation.all
  end

  def new
    @reservation = Reservation.new

  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      redirect_to user_reservations_path
    else
      render template: "/reservations/new"
    end

  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:user_id, :listing_id, :start_date, :end_date, :price)
  end
end
