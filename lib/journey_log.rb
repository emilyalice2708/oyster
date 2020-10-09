require_relative 'journey'

class JourneyLog
  def initialize(journey_class=Journey, journeys=[])
    @journey_class = journey_class
    @journeys = journeys
    @current_journey = nil
  end

  def journeys 
    @journeys.dup
  end

  def start_journey(station)
    @current_journey = @journey_class.new(station)
    add_journey(@current_journey)
  end

  def finish_journey(station)
    current_journey.finish(station)
    add_journey(@current_journey)
    @current_journey = nil
  end

  private

  def add_journey(current_journey)
    @journeys << current_journey 
  end
  
  def current_journey
    @current_journey ||= @journey_class.new
  end
end