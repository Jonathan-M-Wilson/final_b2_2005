require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe "relationships" do
    it {should have_many :passenger_flights}
    it {should have_many(:passengers).through :passenger_flights}
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

    it "#all_passenger_names" do
      expect(@flight.all_passenger_names).to eq("Bob, Eric")
    end
  end
end
