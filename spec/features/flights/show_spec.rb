require "rails_helper"

RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @airline = Airline.create(name: "Southwest")

    @flight =  @airline.flights.create(number: 1260, date: "08/13/2020", time: "12:30 AM", departure_city: "Denver", arrival_city: "Vernal", airline_id: @airline.id)

    @passenger_1 = Passenger.create(name: "Bob", age: 14)
    @passenger_2 = Passenger.create(name: "Eric", age: 44)

    @passenger_flight_1 = PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight.id)
    @passenger_flight_2 = PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight.id)
  end

  describe 'When I visit a flights show page' do
    it 'I see all of that flights information' do
      visit "/flights/#{@flight.id}"

      expect(page).to have_content(@flight.number)
      expect(page).to have_content(@flight.date)
      expect(page).to have_content(@flight.date)
      expect(page).to have_content(@flight.time)
      expect(page).to have_content(@flight.departure_city)
      expect(page).to have_content(@flight.arrival_city)
    end

    it "I see the name of the airline this flight belongs" do
      visit "/flights/#{@flight.id}"

      expect(page).to have_content(@airline.name)
    end

    it " I see the names of all of the passengers on this flight" do
      visit "/flights/#{@flight.id}"

      expect(page).to have_content(@passenger_1.name)
      expect(page).to have_content(@passenger_2.name)
    end

    it "I see the number of minors on the flight (minors are any passengers that are under 18)" do
      visit "/flights/#{@flight.id}"
      save_and_open_page
      expect(page).to have_content("Number of Minors on this Flight: 1")
    end

    it "And I see the number of adults on the flight (adults are any passengers that are 18 or older)" do
      visit "/flights/#{@flight.id}"

      expect(page).to have_content("Number of Adults on this Flight: 1")
    end
  end
end
