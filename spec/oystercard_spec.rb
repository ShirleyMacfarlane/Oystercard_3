require_relative '../lib/oystercard'
require_relative '../lib/journey'

describe Oystercard do
  let(:min_journey_balance) {Oystercard::MIN_JOURNEY_BALANCE}
  let(:max_card_balance) {Oystercard::MAX_CARD_BALANCE}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
  
  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to eq 0
  end


  describe "#top_up" do 
    
    it { is_expected.to respond_to(:top_up).with(1).argument }
  
    it "tops up the balance with the argument balance provided" do

      expect {subject.top_up min_journey_balance}.to change {subject.balance}.by(min_journey_balance)
    end

    it 'does not allow a total balance of more than max_card_balance' do
      subject.top_up(max_card_balance)

      expect {subject.top_up 1}.to raise_error "You can not have more than #{max_card_balance} in your balance"
    end
  end


  describe "#deduct" do
    
    it "should deduct value from our balance" do
      subject.top_up(min_journey_balance)
      subject.touch_in("Victoria")
      expect { subject.touch_out(exit_station) }.to change {subject.balance}.by(-min_journey_balance)
    end

  end

  describe "#in_journey?" do
    it 'should return false' do
      expect(subject).not_to be_in_journey
    end
    it 'should return true' do
      subject.top_up(min_journey_balance)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
      # expect(subject).not_to be_in_journey
    end
  end


  describe "#touch_in" do
    it 'should allow oyster to touch in' do
      subject.top_up(min_journey_balance)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'should not allow touch in if balance is below minimum' do
      expect {subject.touch_in(entry_station)}.to raise_error "Insufficent funds"
    end

    it 'should register an entry station' do
      subject.top_up(min_journey_balance)
      subject.touch_in(entry_station)
      # CORRECTION HERE BELOW
      expect(subject.journey.entry_station).to eq entry_station
    end

  end


  describe "#touch_out" do
    it 'should allow oyster to touch out' do
      subject.top_up(max_card_balance)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

    it 'forgets the entry station' do
      subject.top_up(max_card_balance)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      # expect(subject.entry_station).to eq nil
      # CHANGES HERE BELOW
      expect(subject.journey).to eq nil
    end

    it 'reduces balance by journey fare' do
      subject.top_up(max_card_balance)
      subject.touch_in(entry_station)
      # CHANGES HERE!! 
      #subject.touch_out(exit_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by (-min_journey_balance)
    end

    # CHANGES New tests here
    it 'stores the journey in the list of journey' do
      subject.top_up(max_card_balance)
      subject.touch_in(entry_station)
      expect(subject.journeys.length).to eq 0
      subject.touch_out(exit_station)
      expect(subject.journeys.length).to eq 1
    end
    it 'stores the journey in the list of journey' do
      subject.top_up(max_card_balance)
      subject.touch_in(entry_station)
      expect { subject.touch_out(exit_station) }.to change{ subject.journeys.length }.by (1)
    end

    # it 'should register an exit station' do
    #   subject.top_up(min_journey_balance)
    #   subject.touch_in(entry_station)
    #   subject.touch_out(exit_station)
    #   expect(subject.exit_station).to eq exit_station
    # end

  end


  # it 'should initialize an empty journey' do
  #   expect(subject.journey).to be_empty
  # end

  # it 'should store one journey' do
  #   subject.top_up(min_journey_balance)
  #   subject.touch_in(entry_station)
  #   subject.touch_out(exit_station)
  #   expect(subject.journey).to eq journey
  # end

end