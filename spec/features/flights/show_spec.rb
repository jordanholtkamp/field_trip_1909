require 'rails_helper'

describe 'As a user', type: :feature do
  describe 'When i visit a flight show page' do
    it 'shows all flight info including airline and all passengers' do
      southwest = Airline.create(name: "Southwest")

      flight_1 = southwest.flights.create(number: '227', 
                                          date: '1/20/20',
                                          time: '12:00 PM',
                                          departure_city: 'Cleveland',
                                          arrival_city: 'Denver')

      flight_2 = southwest.flights.create(number: '1704', 
                                          date: '1/21/20',
                                          time: '1:00 PM',
                                          departure_city: 'Denver',
                                          arrival_city: 'San Antonio')

      dave = Passenger.create(name: 'Dave', age: 18)
      steve = Passenger.create(name: 'Steve', age: 20)
      mike = Passenger.create(name: 'Mike', age: 85)

      flight_1.passengers << [dave, steve]
      flight_2.passengers << mike

      visit "/flights/#{flight_1.id}"

      expect(page).to have_content(flight_1.number)
      expect(page).to have_content(flight_1.date)
      expect(page).to have_content(flight_1.time)
      expect(page).to have_content(flight_1.departure_city)
      expect(page).to have_content(flight_1.arrival_city)

      expect(page).to have_content("Airline for this flight: #{flight_1.airline.name}")

      within "#passenger-#{dave.id}" do
        expect(page).to have_content(dave.name)
      end

      within "#passenger-#{steve.id}" do
        expect(page).to have_content(steve.name)
      end

      expect(page).to_not have_css("#passenger-#{mike.id}")
    end
  end
end