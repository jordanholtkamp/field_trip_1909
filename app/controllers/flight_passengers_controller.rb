class FlightPassengersController < ApplicationController 
  def create
    passenger = Passenger.find(params[:id])
    flight = Flight.find_by(number: params[:new_flight_number])
    FlightPassenger.create(flight_id: flight.id, passenger_id: passenger.id)
    redirect_to "/passengers/#{passenger.id}"
  end
end 