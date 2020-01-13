require 'rails_helper'

RSpec.describe Flight, type: :model do
  describe 'validations' do
    it {should validate_presence_of :number }
    it {should validate_presence_of :date }
    it {should validate_presence_of :time }
    it {should validate_presence_of :departure_city }
    it {should validate_presence_of :arrival_city }
    it { should validate_uniqueness_of :number }
  end
  describe 'relationships' do
    it {should belong_to :airline}
    it { should have_many :flight_passengers }
    it { should have_many(:passengers).through(:flight_passengers) }
  end

  describe 'model methods' do 
    it 'minors' do 
      southwest = Airline.create(name: "Southwest")

      flight_1 = southwest.flights.create(number: '227', 
                                          date: '1/20/20',
                                          time: '12:00 PM',
                                          departure_city: 'Cleveland',
                                          arrival_city: 'Denver')

      dave = Passenger.create(name: 'Dave', age: 17)
      steve = Passenger.create(name: 'Steve', age: 20)
      mike = Passenger.create(name: 'Mike', age: 85)

      flight_1.passengers << [dave, steve, mike]

      expect(flight_1.minors).to eq(1)
    end

    it 'adults' do 
      southwest = Airline.create(name: "Southwest")

      flight_1 = southwest.flights.create(number: '227', 
                                          date: '1/20/20',
                                          time: '12:00 PM',
                                          departure_city: 'Cleveland',
                                          arrival_city: 'Denver')

      dave = Passenger.create(name: 'Dave', age: 17)
      steve = Passenger.create(name: 'Steve', age: 20)
      mike = Passenger.create(name: 'Mike', age: 85)

      flight_1.passengers << [dave, steve, mike]

      expect(flight_1.adults).to eq(2)
    end 
  end
end
