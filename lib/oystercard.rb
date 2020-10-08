require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  CARD_LIMIT = 90
  attr_reader :balance, :entry_station, :journey_class

  def initialize(journeys = JourneyLog.new)
    @balance = 0
    @entry_station = nil
    @journeys = journeys
  end

  def top_up(money)
    exceeded?(money) ? exceeded_error : @balance += money
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    raise "Balance too low." if @balance < Journey::FARE
    @entry_station = station
    @journeys.start_journey(station)
  end

  def touch_out(exit_station)
    deduct(Journey::FARE)
    @journeys.finish_journey(exit_station)
    @entry_station = nil
  end

  private

  def exceeded?(money)
    ((@balance + money) >= CARD_LIMIT )
  end

  def exceeded_error
    raise "Card limit of #{CARD_LIMIT} exceeded."
  end

  def deduct(fare)
    @balance -= fare
  end
end
