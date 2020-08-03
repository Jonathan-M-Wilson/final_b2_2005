RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @airline = Airline.create(name: "Southwest")

    @flight = Flight.create(number: 1260, date: "08/13/2020", time: "12:30 AM", departure_city: "Denver", arrival_city: "Vernal", airline_id: @airline.id)

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
  end
end
