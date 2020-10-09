require 'journey_log'
describe JourneyLog do

  let(:journey){ double :journey, start: station, finish: station } 
  let(:station){ double :station }
  let(:journey_class){double :journey_class, new: journey}
  let(:array){double :array}
  let(:new_log){described_class.new(journey_class, array)}
  subject {described_class.new(journey_class)}

  describe '#start' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new)
      subject.start_journey(station)
    end

    it 'records a journey' do
      subject.start_journey(station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#finish' do
    it 'finishes a journey without an entry station' do
      expect(journey_class).to receive(:new)
      expect(journey).to receive(:finish)
      subject.finish_journey(station)
    end

    it 'records a journey without an entry station' do
      subject.finish_journey(station)
      expect(subject.journeys).to include journey
    end

    it 'records a journey with both an entry and exit station' do
      subject.start_journey(station)
      subject.finish_journey(station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#journeys' do
    it 'returns a duplicate array' do
      allow(array).to receive(:dup)
      expect(array).to receive(:dup)
      new_log.journeys
    end

    it 'returns an array containing recorded journeys' do
      subject.start_journey(station)
      subject.finish_journey(station)
      expect(subject.journeys).to be_a Array
    end
  end

end
