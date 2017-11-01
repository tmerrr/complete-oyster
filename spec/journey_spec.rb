require 'journey'

describe Journey do
  context "When instantiating a journey it" do
    it "should be an instance of Journey" do
      expect(subject).to be_an_instance_of(Journey)
    end
  end
end
