require 'rails_helper'

describe 'As a user' do
  before :each do
    southwest = Airline.create(name: "Southwest")

    @flight_1 = southwest.flights.create(number: '227', 
                                         date: '1/20/20',
                                         time: '12:00 PM',
                                         departure_city: 'Cleveland',
                                         arrival_city: 'Denver')

    @flight_2 = southwest.flights.create(number: '1704', 
                                         date: '1/21/20',
                                         time: '1:00 PM',
                                         departure_city: 'Denver',
                                         arrival_city: 'San Antonio')

    @flight_3 = southwest.flights.create(number: '1111',
                                         date: '1/1/20',
                                         time: '1:30 PM',
                                         departure_city: 'Houston',
                                         arrival_city: 'Boston')

    @dave = Passenger.create(name: 'Dave', age: 18)
    @steve = Passenger.create(name: 'Steve', age: 20)
    @mike = Passenger.create(name: 'Mike', age: 85)

    @flight_1.passengers << [@dave, @steve]
    @flight_2.passengers << @mike
    @flight_3.passengers << @dave
  end

  describe 'When I visit a passenger show page' do
    it 'shows passenger name and all flight numbers' do 
      visit "/passengers/#{@dave.id}"

      expect(page).to have_content(@dave.name)

      expect(page).to_not have_css("flight-#{@flight_2.id}")

      within "#flight-#{@flight_1.id}" do
        expect(page).to have_link(@flight_1.number)
      end

      within "#flight-#{@flight_3.id}" do
        click_link(@flight_3.number)
      end

      expect(current_path).to eq("/flights/#{@flight_3.id}")
    end 

    it 'allows me to add a flight' do
      visit "/passengers/#{@mike.id}"

      fill_in :new_flight_number, with: "#{@flight_1.number}"
      click_button 'Add Flight'

      expect(current_path).to eq("/passengers/#{@mike.id}")

      expect(page).to have_link("#{@flight_1.number}")
    end
  end 
end