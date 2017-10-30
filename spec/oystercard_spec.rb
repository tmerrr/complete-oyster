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
  end
end
