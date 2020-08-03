require "rails_helper"
RSpec.describe 'As a visitor', type: :feature do
  before(:each) do
    @airline = Airline.create(name: "Southwest")

    @flight = @airline.flights.create(number: 1260, date: "08/13/2020", time: "12:30 AM", departure_city: "Denver", arrival_city: "Vernal", airline_id: @airline.id)
    @flight_2 = @airline.flights.create(number: 1280, date: "09/18/2020", time: "6:30 AM", departure_city: "SLC", arrival_city: "Portland", airline_id: @airline.id)


    @passenger_1 = Passenger.create(name: "Bob", age: 14)
    @passenger_2 = Passenger.create(name: "Eric", age: 44)

    PassengerFlight.create(passenger_id: @passenger_1.id, flight_id: @flight.id)
    PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight.id)
    PassengerFlight.create(passenger_id: @passenger_2.id, flight_id: @flight_2.id)
  end

  describe 'When I visit a passengers show page' do
    it 'I see a form to add a flight' do
      visit "/passengers/#{@passenger_1.id}"

      expect(page).to have_field(:number)
    end

    it "When I fill in the form with a flight number, and click submit, I'm takedn to the passengers show page where I see the flight I just added" do
      visit "/passengers/#{@passenger_1.id}"

      fill_in :number, with: "#{@flight_2.number}"
      click_on "Submit"

      expect(current_path).to eq("/passengers/#{@passenger_1.id}")

      expect(page).to have_link(@flight_2.number)
    end
  end
end
