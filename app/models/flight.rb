class Flight <ApplicationRecord

  belongs_to :airline
  has_many :passenger_flights
  has_many :passengers, through: :passenger_flights

  def all_passenger_names #there is a better way to do this 
    all = self.passengers.map { |passenger| passenger.name}
    all.join(", ")
  end
end
