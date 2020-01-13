Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :airlines, only: [:index, :show]

  resources :flights, only: [:show]

  resources :passengers, only: [:show, :post] do
  end 

  post '/passengers/:id/flights', to: 'flight_passengers#create'
end
