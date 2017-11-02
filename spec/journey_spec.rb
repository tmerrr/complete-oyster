require 'journey'

describe Journey do
  let(:aldgate) { double(:station, :name => "Aldgate", :zone => 1) }
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
      let(:completed_journey) { described_class.new(entry_station: aldgate, exit_station: aldgate) }
      it "should return 1" do
        expect(completed_journey.fare).to eq(1)
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
