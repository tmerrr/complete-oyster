require 'journeylog'

describe JourneyLog do
  let(:journey_class) { double(:journey_class) }
  subject { described_class.new(journey_class)}

  describe "#initialize" do
    it "should return an instance of JourneyLog" do
      expect(subject).to be_an_instance_of(JourneyLog)
    end
    it "creates an empty journey_history" do
      expect(subject.journey_history).to be_a(Array)
        .and be_empty
    end
    context "when creating new journey_log" do
      subject { described_class }

      it "takes one arg upon instantiation" do
        is_expected.to respond_to(:new).with(1).arguments
      end
    end
  end

end
