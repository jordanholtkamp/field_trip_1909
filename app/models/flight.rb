class Flight <ApplicationRecord
  validates_presence_of :number, :date, :time, :departure_city, :arrival_city
  belongs_to :airline

  has_many :flight_passengers
  has_many :passengers, through: :flight_passengers
end
