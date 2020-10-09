class Journey
  FARE = 1
  PENALTY = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @journey = {entry_station: @entry_station, exit_station: nil}
  end

  def finish(exit_station)
    @journey[:exit_station] = exit_station
  end

  def fare 
    complete? ? FARE : PENALTY
  end

  def complete?
    @journey[:entry_station] && @journey[:exit_station]
  end

end