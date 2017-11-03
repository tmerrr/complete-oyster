require 'journey'

describe Journey do
  let(:aldgate) { double(:station, name: "Aldgate", zone: 3) }
  let(:kingsx) { double(:station, name: "Kings Cross", zone: 1) }
  let(:ongoing_journey) { Journey.new(entry_station: aldgate) }

  context "When instantiating a journey it" do
    it "should be an instance of Journey" do
      expect(subject).to be_an_instance_of(Journey)
    end
  end

  describe "#entry_station" do
    context "when calling entry_station on a new journey" do
      it "will return nil" do
          expect(subject.entry_station).to be_nil
      end
    end

    context "when calling entry_station on an ongoing journey" do
      it "should return Aldgate" do
        expect(ongoing_journey.entry_station).to eq(aldgate)
      end
    end
  end

  describe "#exit_station" do
    context "when calling exit_station on a journey" do
      it "will return nil" do
        expect(subject.exit_station).to be_nil
      end
    end
  end

  describe "#set_entry_station" do
    it "changes the entry_station variable" do
      expect { subject.set_entry_station(aldgate) }
        .to change { subject.entry_station }.from(nil).to(aldgate)
    end
  end

  describe '#get_string' do
    it 'returns a readable string of the journey' do
      complete_journey = described_class.new(
        entry_station: kingsx, exit_station: aldgate
      )

      expect(complete_journey.get_string)
        .to eq('Start: Kings Cross, Zone 1.  Exit: Aldgate, Zone 3.')
    end
  end

  describe "#set_exit_station" do
    it "changes the exit station variable" do
      expect { subject.set_exit_station(aldgate) }
        .to change { subject.exit_station }.from(nil).to(aldgate)
    end
  end

  describe '#in_journey?' do
    context 'when not in a journey' do
      it 'returns false' do
        expect(subject.in_journey?).to be(false)
      end
    end

    context 'when in a journey' do
      it 'returns true' do
        expect(ongoing_journey.in_journey?).to be(true)
      end
    end
  end

  describe "#fare" do
    context "when completing full journey" do
      let(:station1) { double(:station, zone: 1) }
      let(:station2) { double(:station, zone: 2) }
      let(:station3) { double(:station, zone: 3) }
      let(:station4) { double(:station, zone: 4) }
      let(:station5) { double(:station, zone: 5) }
      let(:station6) { double(:station, zone: 6) }

      it "returns 1 for same zones" do
        journey = described_class.new(
          entry_station: station1, exit_station: station1
        )
        expect(journey.fare).to eq(1)
      end

      it 'returns 2 when crossing 1 zone boundary' do
        journey = described_class.new(
          entry_station: station1, exit_station: station2
        )
        expect(journey.fare).to eq(2)
      end

      it 'returns 3 when crossing 2 zone boundary' do
        journey = described_class.new(
          entry_station: station1, exit_station: station3
        )
        expect(journey.fare).to eq(3)
      end

      it 'returns 4 when crossing 3 zone boundary' do
        journey = described_class.new(
          entry_station: station1, exit_station: station4
        )
        expect(journey.fare).to eq(4)
      end

      it 'returns 5 when crossing 4 zone boundary' do
        journey = described_class.new(
          entry_station: station1, exit_station: station5
        )
        expect(journey.fare).to eq(5)
      end

      it 'returns 6 when crossing 5 zone boundary' do
        journey = described_class.new(
          entry_station: station1, exit_station: station6
        )
        expect(journey.fare).to eq(6)
      end

      it 'returns 6 when crossing 5 zone boundary' do
        journey = described_class.new(
          entry_station: station6, exit_station: station1
        )
        expect(journey.fare).to eq(6)
      end
    end

    context "when touching in, having failed to touch out" do
      it "should return 6" do
        expect(ongoing_journey.fare).to eq(6)
      end
    end

    context "when touching out, having failed to touch in" do
      let(:journey) { described_class.new(exit_station: aldgate) }
      it "should return 6" do
        expect(journey.fare).to eq(6)
      end
    end

    context "when touching in, when starting a new journey" do
      it "should return 0" do
        expect(subject.fare).to eq(0)
      end
    end
  end
end
