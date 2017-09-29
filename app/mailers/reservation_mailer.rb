class ReservationMailer < ApplicationMailer
  default from: 'reservations@pairbnb.com'

  def booking_email(customer, host, reservation_id)
    @reservation.id = reservation_id
    
    @url = '/reservations'
    mail(to: @reservation.user.email, subject: 'You\'ve Got a New Booking!')
  end

end
