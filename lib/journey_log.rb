require_relative 'journey'

class JourneyLog
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def journeys 
    @journeys.dup
  end

  def start_journey(station)
    @current_journey = @journey_class.new
    @current_journey.start(station)
    @journeys << @current_journey
  end

  def finish_journey(station)
    @current_journey.finish(station)
    @journeys << @current_journey
    @current_journey = nil
  end

  private
  
  def current_journey
    @current_journey ||= @journey_class.new
  end
end