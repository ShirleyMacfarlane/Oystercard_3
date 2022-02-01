require_relative '../lib/oystercard'

describe Oystercard do
  
  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to eq 0
  end
  describe "#top_up" do 
    
    it { is_expected.to respond_to(:top_up).with(1).argument }
  
    it "tops up the balance with the argument balance provided" do
      min_journey_balance = Oystercard::MIN_JOURNEY_BALANCE

      expect {subject.top_up min_journey_balance}.to change {subject.balance}.by(min_journey_balance)
    end

    it 'does not allow a total balance of more than max_limit' do
      max_limit = Oystercard::MAX_CARD_BALANCE
      subject.top_up(max_limit)

      expect {subject.top_up 1}.to raise_error "You can not have more than #{max_limit} in your balance"
    end
  end


  describe "#deduct" do
    
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "should deduct value from our balance" do
      min_journey_balance = Oystercard::MIN_JOURNEY_BALANCE
      subject.top_up(min_journey_balance)
      expect { subject.deduct min_journey_balance}.to change {subject.balance}.by(-min_journey_balance)
    end

  end

  describe "#in_journey?" do
    it 'should return false' do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it 'should allow oyster to touch in' do
      subject.top_up(Oystercard::MIN_JOURNEY_BALANCE)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'should not allow touch in if balance is below minimum' do
      expect {subject.touch_in}.to raise_error "Insufficent funds"
    end
  end

  describe "#touch_out" do
    it 'should allow oyster to touch out' do
      subject.top_up(Oystercard::MAX_CARD_BALANCE)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end
