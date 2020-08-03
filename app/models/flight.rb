class Flight <ApplicationRecord
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights

  def all_passenger_names
    all = self.passengers.map { |passenger| passenger.name}
    all.join(", ")
  end
end
