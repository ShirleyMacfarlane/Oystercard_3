require_relative '../lib/journey'
#require_relative '../lib/oystercard'

describe Journey do 
    subject(:journey) { described_class.new }

    
    it 'has an entry_station' do
         journey = Journey.new("Victoria", "Green Park")
        expect(journey.entry_station).to eq "Victoria"
    end  
    it 'has an exit_station' do
        journey = Journey.new("Victoria", "Green Park")
        expect(journey.exit_station).to eq "Green Park"
    end   
    it 'has a method to calculate the fare' do
        journey = Journey.new("Victoria", "Green Park")
        expect(journey).to respond_to(:calc_fare)
    end    
    it 'has a method of setting whether the journey is complete or not' do
        journey = Journey.new("Victoria", "Green Park")
        expect(journey).to respond_to(:complete?)
    end
    it 'should check whether the journey complete' do
        journey = Journey.new("Victoria", "Green Park")
        expect(journey.complete?).to eq true
    end

    it 'should check whether the journey incomplete' do
        journey = Journey.new("Victoria", nil)
        expect(journey.complete?).to eq false
    end

end