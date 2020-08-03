class FlightsController < ApplicationController

  def show
    @flight = Flight.find(params[:id])
    @airline = Airline.find(params[:id])
  end
end
