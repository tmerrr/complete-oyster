require 'oystercard'

describe Oystercard do

  let(:journeylog)    { double(:journeylog) }
  let(:journey_class) { double(:journey_class) }
  let(:card)          { described_class.new(balance: 10,
    journeylog: journeylog) }
  let(:station)       { double(:station) }
  let(:exit_station)  { double(:camden) }

  describe '#initialize' do
    context 'When intializing a new oystercard' do
      it 'it should return a balance of 10' do
        expect(card.balance).to eq 10
      end
    end
  end

  describe '#top_up' do
    context 'when topping up a valid amount' do
      it 'adds £20 to the cards balance' do
        expect { card.top_up(20) }.to change { card.balance }.by(20)
      end
    end

    context 'when exceeding the card limit' do
      it 'raises an error' do
        expect { card.top_up(100) }
          .to raise_error("MaxLimit of #{Oystercard::MAXIMUM_AMOUNT}.")
      end
    end

    context 'when topping up by a negative value' do
      it 'raises an error' do
        expect { card.top_up(-10) }.to raise_error 'InvalidValue'
      end
    end
  end

  describe '#in_journey?' do
    context 'when oystercard is in journey' do
      it 'returns true' do
        allow(journeylog).to receive(:in_journey?).and_return(true)
        expect(card.in_journey?).to be(true)
      end
    end

    context "when oystercard is NOT in journey" do
      it "returns false" do
        allow(journeylog).to receive(:in_journey?) { false }
        expect(card.in_journey?).to be(false)
      end
    end
  end

  describe '#touch_in' do
    it 'sets the entry station' do
      allow(journeylog).to receive_messages(charge: 0, start: station)
      expect(card.touch_in(station)).to eq(station)
    end

    context 'when touching in' do
      it 'should raise an error when insufficient funds' do
        expect { subject.touch_in('') }.to raise_error 'Insufficient funds'
      end

      it 'should set start point to station' do
        allow(journeylog).to receive_messages(start: station, charge: 0)
        expect(card.touch_in(station)).to eq(station)
      end
    end

    context "when penalty being charged" do
      it 'reduces balance by 6' do
        allow(journeylog).to receive_messages(charge: 6, start: station)
        expect { card.touch_in(station) }.to change { card.balance }.by(-6)
      end
    end

    context 'when penalty is NOT being charged' do
      it "doesn't change balance" do
        allow(journeylog).to receive_messages(charge: 0, start: station)
        expect { card.touch_in(station) }.not_to change { card.balance }
      end
    end
  end

  describe '#touch_out' do
    let(:journeylog) do
      double(:journeylog, finish: station, complete_journey: journey_class)
    end

    it 'reduces balance by charge' do
      allow(journeylog).to receive_messages(charge: 1)
      expect { card.touch_out(station) }.to change { card.balance }.by(-1)
    end
  end

end
