require 'oystercard'

describe Oystercard do

  describe '#initialize' do
    context 'When intializing a new oystercard' do
      it 'it should return a balance of 0' do
        expect(subject.balance).to eq 0
      end
    end
  end

  describe '#top_up' do
    context 'when topping up card' do
      it 'should add balance with £20' do
        subject.top_up(20)
        expect(subject.balance).to eq(20)
      end
      it 'card balance will not exceed the given maximum' do
        expect { subject.top_up(100) }.to raise_error("Sorry, the balance on your Oyster card cannot exceed #{Oystercard::MAXIMUM_AMOUNT}.")
      end
    end
  end

  describe '#deduct' do
    context 'when deducting 20 from the card balance' do
      it "it should reduce balance by 20" do
        expect(subject.deduct(20)).to eq -20
      end
    end
  end

  describe '#in_journey?' do
    context 'when oystercard is not in journey' do
      it 'returns false' do
        expect(subject.in_journey).to eq(false)
      end
    end
  end

  describe '#touch_in' do
    context 'when touching in' do
      it "@in_journey attribute should return true" do
        expect(subject.touch_in).to eq(true)
      end
    end
  end

  describe '#touch_out' do
    context 'when touching out' do
      it '@in_journey attribute should return false' do
        subject.touch_in
        expect(subject.touch_out).to eq(false)
      end
    end
  end
end
