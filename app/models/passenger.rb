class Passenger < ApplicationRecord
  validates_presence_of :name, :age

  has_many :flight_passengers
  has_many :flights, through: :flight_passengers
end 