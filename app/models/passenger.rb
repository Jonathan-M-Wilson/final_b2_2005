class Passenger <ApplicationRecord
  has_many :passenger_flights
  has_many :flights, through: :passenger_flights

  def self.minors_on_flight
    Passenger.where('age < ?', 18).count
  end
  
  def self.adults_on_flight
    Passenger.where('age >= ?', 18).count
  end
end
