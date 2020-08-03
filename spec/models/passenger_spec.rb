require 'rails_helper'

RSpec.describe Passenger, type: :model do
  describe "relationships" do
    it {should have_many :passenger_flights}
    it {should have_many(:flights).through :passenger_flights}
  end

  describe "methods" do
    before :each do
      @airline = Airline.create(name: "Southwest")

      @flight = @airline.flights.create(number: 1260, date: "08/13/2020", time: "12:30 AM", departure_city: "Denver", arrival_city: "Vernal", airline_id: @airline.id)
      @flight_2 = @airline.flights.create(number: 1280, date: "09/18/2020", time: "6:30 AM", departure_city: "SLC", arrival_city: "Portland", airline_id: @airline.id)


      @passenger_1 = Passenger.create(name: "Bob", age: 14)
      @passenger_2 = Passenger.create(name: "Eric", age: 44)

      PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight.id)
      PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight.id)
      PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight_2.id)
    end
    it "#adults_on_flight" do
      expect(@flight.passengers.adults_on_flight).to eq(1)
    end

    it "#minors_on_flight" do
      expect(@flight.passengers.minors_on_flight).to eq(1)
    end
  end
end
