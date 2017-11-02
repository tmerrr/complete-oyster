require 'oystercard'

describe Oystercard do

  let(:card) { described_class.new(balance: 10, journey: no_journey) }
  let(:station) { double(:aldgate) }
  let(:exit_station) { double(:camden) }
  let(:no_journey) { double(:journey, :in_journey? => false, :set_entry_station => station, :set_exit_station => station, :fare => 0) }
  let(:ongoing_journey) { double(:journey, :in_journey? => true, :set_entry_station => station, :set_exit_station => station, :fare => 0) }

  describe '#initialize' do
    context 'When intializing a new oystercard' do
      it 'it should return a balance of 10' do
        expect(card.balance).to eq 10
      end
    end
    context 'journey empty on initialise' do
      it 'returns {} for travel history' do
        expect(card.journey).to eq(no_journey)
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
      let(:card) { described_class.new(journey: ongoing_journey) }
      it 'returns true' do
        expect(card.in_journey?).to be(true)
      end
    end
    context "when oystercard is NOT in journey" do
      let(:card) { described_class.new(journey: no_journey) }
      it "returns false" do
        expect(card.in_journey?).to be(false)
      end
    end
  end

  describe '#touch_in' do
    context 'when touching in' do
      it 'should raise an error when insufficient funds' do
        expect { subject.touch_in('') }.to raise_error 'Insufficient funds'
      end
      it 'should set start point to station' do
        expect(card.touch_in(station)).to eq(station)
      end
    end
    context "on touch_in and penalty being charged" do
      let(:card) { described_class.new(balance: 50, journey: ongoing_journey) }
      it "pushed journey to journey_history" do
        expect { card.touch_in(station) }
          .to change { card.journey_history }.to include(ongoing_journey)
      end
    end
    context "when starting new journey" do
      it "doesnt push journey to journey_history" do
        expect { card.touch_in(station) }
          .not_to change { card.journey_history }
      end
    end
  end

  describe '#touch_out' do
      let(:card) { described_class.new(journey: ongoing_journey) }
      it 'adds Journey to travel_history' do
        expect { card.touch_out(exit_station) }
          .to change { card.journey_history }.to include(ongoing_journey)
      end

      it 'creates a new instance of Journey' do
        expect { card.touch_out(exit_station) }
          .to change { card.journey }.from(ongoing_journey)
      end

  end

  describe "#travel_history" do
    context "when completing journeys" do
      it "should return an empty array" do
        expect(card.journey_history).to eq([])
      end
      it "should return the journey history" do
        expect { card.touch_out(exit_station) }.to change { card.journey_history }.to include(no_journey)
      end
    end
  end
end
