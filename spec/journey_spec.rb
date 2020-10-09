require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:journey) { described_class.new }
  let(:new_journey) {described_class.new(station)}

  describe '#initialize' do
    it "knows if a journey is complete or not" do
      expect(journey).not_to be_complete
    end
  end

  context "given entry station" do
    it 'has entry station' do
      expect(new_journey.entry_station).to eq(station)
    end

    it "returns minimum fare when exit present" do 
      new_journey.finish(station)
      expect(new_journey.fare).to eq(Journey::FARE)
    end

    it "returns penalty when no exit given" do
      expect(new_journey.fare).to eq(Journey::PENALTY)
    end
  end

  context "given no entry station" do
    it 'returns penalty even with exit station' do
      journey.finish(station)
      expect(journey.fare).to eq(Journey::PENALTY)
    end

    it 'returns penalty with no exit given' do
      expect(journey.fare).to eq(Journey::PENALTY)
    end
  end
  
end