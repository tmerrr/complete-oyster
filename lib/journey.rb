class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station: nil, exit_station: nil)
    @entry_station  = entry_station
    @exit_station   = exit_station
  end

  def set_entry_station(station)
    @entry_station = station
  end

  def set_exit_station(station)
    @exit_station = station
  end

  def in_journey?
    !!@entry_station
  end

  def fare
    return 6 if penalty_due?
    return 0 if starting_journey?
    1
  end

  private
  def penalty_due?
    (@entry_station != nil && @exit_station == nil) ||
      (@entry_station == nil && @exit_station != nil)
  end

  def starting_journey?
    @entry_station == nil && @exit_station == nil
  end
end
