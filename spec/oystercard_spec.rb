require 'oystercard'

describe Oystercard do
  let (:entry_station) { double :entry_station }
  let (:exit_station) { double :exit_station }
  let (:journey) {double :journey, entry_station: entry_station, exit_station: exit_station}

  describe '#initialize' do
    it 'should have balance of 0 on initialization' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'adds to the balance of the card' do
      expect { subject.top_up(5) }.to change{subject.balance}.by(5)
    end

    it 'raises an error if balance surpasses 90' do
      expect { subject.top_up(100) }.to raise_error "Card limit of #{Oystercard::CARD_LIMIT} exceeded."
    end
  end


  describe '#touch_in' do
    it "raises an error if card balance too low" do
      expect { subject.touch_in(entry_station) }.to raise_error("Balance too low.")
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(5)
      subject.touch_in(entry_station)
    end

    it 'reduces the @balance by minimum fare' do
      expect { subject.touch_out(exit_station) }.to change{subject.balance}.by(-Journey::FARE)
    end

  end
end
