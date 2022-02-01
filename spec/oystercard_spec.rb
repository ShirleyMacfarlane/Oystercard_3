require_relative '../lib/oystercard'

describe Oystercard do
  
  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to eq 0
  end
  describe "#top_up" do 
    
    it { is_expected.to respond_to(:top_up).with(1).argument }
  
    it "tops up the balance with the argument balance provided" do
      expect {subject.top_up 500}.to change {subject.balance}.by(500)
    end
  end
end