require_relative '../lib/oystercard'

describe Oystercard do
  let(:min_journey_balance) {Oystercard::MIN_JOURNEY_BALANCE}
  let(:max_card_balance) {Oystercard::MAX_CARD_BALANCE}
  
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
      expect { subject.touch_out }.to change {subject.balance}.by(-min_journey_balance)
    end

  end

  describe "#in_journey?" do
    it 'should return false' do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it 'should allow oyster to touch in' do
      subject.top_up(min_journey_balance)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it 'should not allow touch in if balance is below minimum' do
      expect {subject.touch_in}.to raise_error "Insufficent funds"
    end
  end

  describe "#touch_out" do
    it 'should allow oyster to touch out' do
      subject.top_up(max_card_balance)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'reduces balance by journey fare' do
      subject.top_up(max_card_balance)
      subject.touch_in
      subject.touch_out
      expect { subject.touch_out }.to change{ subject.balance }.by (-min_journey_balance)
    end
  end
end
