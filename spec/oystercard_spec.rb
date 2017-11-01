require 'oystercard'

describe Oystercard do

  let(:card) { Oystercard.new(10) }
  let(:station) { double(:aldgate) }

  describe '#initialize' do
    context 'When intializing a new oystercard' do
      it 'it should return a balance of 0' do
        expect(subject.balance).to eq 0
      end
    end
    context 'travel history empty on initialise' do
      it 'returns 0 for travel history' do
        expect(card.travel_history).to eq []
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

  describe '#in_journey?' do
    context 'when oystercard is in journey' do
      it 'returns true' do
        card.touch_in('Aldgate')
        expect(card.in_journey?).to eq true
      end
    end
  end

  describe '#touch_in' do
    context 'when touching in' do
      it 'should raise an error when insufficient funds' do
        expect { subject.touch_in('') }.to raise_error 'Insufficient funds'
      end
      it 'should return user start point' do
        expect { card.touch_in(station) }.to change { card.entry_station }
      end
    end
  end

  describe '#touch_out' do
    context 'when touching out' do
      it 'changes in journey on touch out' do
        card.touch_in('')
        expect { card.touch_out(station) }.to change { card.in_journey? }
      end
      it 'it should reduce balance by minimum fare' do
        expect { subject.touch_out(station) }.to change { subject.balance }.by -Oystercard::MINIMUM_FARE
      end
      it 'it accepts exit station' do
        expect(subject).to respond_to(:touch_out).with(1).argument
      end
    end
  end
  # describe '@travel_history' do
  #   it 'should return travel history' do
  #
  #   end
  # end
end
