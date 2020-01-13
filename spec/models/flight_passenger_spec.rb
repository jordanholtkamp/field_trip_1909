require 'rails_helper'

describe FlightPassenger, type: :model do 
  describe 'relationships' do 
    it { should belong_to :flight }
    it { should belong_to :passenger }
  end 
end 