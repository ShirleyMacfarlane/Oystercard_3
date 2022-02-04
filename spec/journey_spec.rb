require_relative '../lib/journey'
#require_relative '../lib/oystercard'

describe Journey do 
    subject(:journey) { described_class.new }
   # let(:station) { double :station, zone: 1}
    
    it 'has an entry_station' do
        entry_station = Station.new("Bob")
        journey.entry_station = entry_station
        expect(journey.entry_station.name).to eq "Bob"
    end  
    it 'has an exit_station' do
        exit_station = Station.new("Fred")
        journey.exit_station = exit_station
        expect(journey.exit_station.name).to eq "Fred"
    end   
    it 'has a method to calculate the fare' do
         expect(journey).to respond_to(:calc_fare)
    end    
    it 'has a method of setting whether the journey is complete or not' do
        expect(journey).to respond_to(:complete?)
    end
    it 'should check whether the journey complete' do
        entry_station = Station.new("Ricky",)
        exit_station= Station.new("Victoia",)
        journey.entry_station = entry_station
        journey.exit_station = exit_station
        expect(journey.complete?).to eq true
    end

    it 'should check whether the journey incomplete' do
        exit_station= Station.new("Victoia", 1)
        journey.exit_station = exit_station
        expect(journey.complete?).to eq false
    end

    it 'craetes a new journey' do
        journey = Journey.new
        expect(journey.entry_station).to eq nil
    end
end