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
end
