class PassengerFlightsController < ApplicationController

  def create
    flight = Flight.where(number: params[:number]).first
    passenger_flight = PassengerFlight.where(flight: flight, passenger_id: params[:passenger_id]).first
  if passenger_flight.nil? && Flight.exists?(flight.id)
    PassengerFlight.create(flight: flight, passenger_id: params[:passenger_id])
  else PassengerFlight.exists?(passenger_flight.id)
  end
    redirect_to "/passengers/#{params[:passenger_id]}"
  end
end
