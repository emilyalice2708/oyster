require 'journey_log'
describe JourneyLog do

  let(:journey){ double :journey, start: station, entry_station: station, exit_station: station } #this may need to have some methods
  let(:station){ double :station }
  let(:journey_class){double :journey_class, new: journey}
  subject {described_class.new(journey_class)}

  describe '#start' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new)
      expect(journey).to receive(:start).with(station)
      subject.start_journey(station)
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start_journey(station)
      expect(subject.journeys).to include journey
    end
  end
end