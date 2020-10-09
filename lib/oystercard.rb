require_relative 'journey'
require_relative 'journey_log'

class Oystercard
  CARD_LIMIT = 90
  attr_reader :balance, :entry_station, :journeys

  def initialize(journeys = JourneyLog.new)
    @balance = 0
    @journeys = journeys
  end

  def view_journeys
    @journeys.journeys
  end

  def top_up(money)
    exceeded?(money) ? exceeded_error : @balance += money
  end

  def touch_in(station)
    raise "Balance too low." if @balance < Journey::FARE
    
    @journeys.start_journey(station)
  end

  def touch_out(exit_station)
    deduct(Journey::FARE)
    @journeys.finish_journey(exit_station)
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
