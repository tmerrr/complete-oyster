require 'station'

describe Station do
  subject { described_class.new('Camden', 1) }

  context 'when initializing a station' do
    it 'should be an instance of station' do
      expect(subject).to be_a(Station)
    end

    it 'should expose the name variable' do
      expect(subject.name).to eq('Camden')
    end

    it 'should expose the zone variable' do
      expect(subject.zone).to eq(1)
    end
  end

  context 'when initializing a Station with invalid values' do
    it 'raises an error if zone is not between 1 and 6' do
      expect{ described_class.new('name', 7) }.to raise_error 'InvalidZone'
    end

    it 'raises an error if zone is not between 1 and 6' do
      expect{ described_class.new('name', 0) }.to raise_error 'InvalidZone'
    end
  end

end
