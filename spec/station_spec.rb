require_relative '../lib/station'

describe Station do
    #station = Station.new("Victoria","1")
    subject { described_class.new("Victoria", 1)}
    
    it 'Creates an new instance with a name' do
        expect(subject.name).to eq("Victoria")
    end
    it 'Creates an new instance with a zone' do
        expect(subject.zone).to eq(1)
    end

end
