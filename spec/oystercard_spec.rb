require_relative '../lib/oystercard'

describe Oystercard do
  
  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to eq 0
  end
  describe "#top_up" do 
    
    it { is_expected.to respond_to(:top_up).with(1).argument }
  
    it "tops up the balance with the argument balance provided" do
      expect {subject.top_up 5}.to change {subject.balance}.by(5)
    end

    it 'does not allow a total balance of more than 90' do
      max_limit = Oystercard::MAX_LIMIT
      subject.top_up(max_limit)
      expect {subject.top_up 1}.to raise_error "You can not have more than 90 in your balance"
    end
  end

  describe "#deduct" do
    
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "should deduct value from our balance" do
      subject.top_up(10)
      expect { subject.deduct 10}.to change {subject.balance}.by(-10)
    end

  end
end
