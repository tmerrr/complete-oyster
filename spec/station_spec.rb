require 'station'

describe Station do
  context 'when instantiating a station it' do
    it 'should be an instance of station' do
      expect(subject).to be_an_instance_of(Station)
    end
    it 'should expose the name variable' do
      expect(subject.name).to eq('Camden')
    end
    it 'should expose the zone variable' do
      expect(subject.zone).to eq('Zone A')
    end
  end
end
