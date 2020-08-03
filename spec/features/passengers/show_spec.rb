require "rails_helper"
RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @airline = Airline.create(name: "Southwest")

    @flight = Flight.create(number: 1260, date: "08/13/2020", time: "12:30 AM", departure_city: "Denver", arrival_city: "Vernal", airline_id: @airline.id)
    @flight_2 = Flight.create(number: 1280, date: "09/18/2020", time: "6:30 AM", departure_city: "SLC", arrival_city: "Portland", airline_id: @airline.id)


    @passenger_1 = Passenger.create(name: "Bob", age: 14)
    @passenger_2 = Passenger.create(name: "Eric", age: 44)

    @passenger_flight_1 = PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight.id)
    @passenger_flight_2 = PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight.id)
    @passenger_flight_3 = PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight_2.id)
  end

  describe 'When I visit a passengers show page' do
    it 'I see that passengers name' do
      visit "/passengers/#{@passenger_2.id}"

      expect(page).to have_content(@passenger_2.name)
    end

    it "And I see a section of the page that displays all flight numbers as links to that flight's show page, for every flight for that passenger" do
      visit "/passengers/#{@passenger_2.id}"

      expect(page).to have_link(@flight.number)
      expect(page).to have_link(@flight_2.number)
    end
  end
end
