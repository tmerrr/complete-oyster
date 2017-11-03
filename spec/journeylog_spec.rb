require 'journeylog'

describe JourneyLog do
  let(:journey)         { double(:journey) }
  let(:journey_class)   { double(:journey_class, :new => journey) }
  let(:station)         { double(:station) }
  subject(:journeylog)  { described_class.new(journey_class) }

  describe "#initialize" do
    it "creates an empty history" do
      expect(subject.history).to be_a(Array).and be_empty
    end

    it "takes one arg upon instantiation" do
      expect(described_class).to respond_to(:new).with(1).arguments
    end
  end

  describe '#journey' do
    context 'when the journey log has been created with no arguments' do
      it 'creates a new Journey instance' do
        expect(journeylog.journey).to eq journey
      end
    end
  end

  describe '#start' do
    it 'creates a new Journey and sets the entry station' do
      allow(journey).to receive_messages(in_journey?: false,
        set_entry_station: station)
      expect(journeylog.start(station)).to eq(journey.set_entry_station)
    end

    context 'when starting a new journey wiihout touching out' do
      it 'adds last journey to journey history' do
        allow(journey)
        .to receive_messages(in_journey?: true, set_entry_station: station)

        expect { journeylog.start(station) }
        .to change { journeylog.history }.to include(journey)
      end
    end
  end

  describe '#finish' do
    it 'sets the current Journey\'s exit station' do
      allow(journey).to receive_messages(set_exit_station: station)
      expect(journeylog.finish(station)).to eq (journey.set_exit_station)
    end
  end

  describe '#complete_journey' do
    it 'adds Journey to history' do
      expect { journeylog.complete_journey }
      .to change { journeylog.history }.to include(journey)
    end

    it 'creates a new journey class' do
      expect(journeylog.complete_journey).to eq(journey)
    end
  end

end
