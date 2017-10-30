require 'oystercard'

describe Oystercard do
  it 'Initialise a new Oystercard with a balance of 0' do
    expect(subject.balance).to eq 0
  end
  describe '#top_up' do
    it 'tops up oyster card balance with £20' do
      subject.top_up(20)
      expect(subject.balance).to eq(20)
    end
    it 'Will not allow a card\'s balance to exceed the given maximum' do
      expect { subject.top_up(100) }.to raise_error('Sorry, the balance on'\
      " your Oyster card can not exceed #{subject.maximum_amount}.")
    end
  end
  describe '#deduct' do
    it "Deducts the a given amount from the card's balance" do
      expect(subject.deduct(20)).to eq -20
    end
  end
end
