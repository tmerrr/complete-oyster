class Journey
  attr_reader :entry_station, :exit_station

  PENALTY = 6

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

  def get_string
    "Start: #{@entry_station.name}, Zone #{@entry_station.zone}.  Exit: #{@exit_station.name}, Zone #{@exit_station.zone}."
  end

  def fare
    return PENALTY if penalty_due?
    return 0 if starting_journey?
    calculate_fare
  end

  private
  def penalty_due?
    (@entry_station != nil && @exit_station == nil) ||
      (@entry_station == nil && @exit_station != nil)
  end

  def starting_journey?
    @entry_station == nil && @exit_station == nil
  end

  def calculate_fare
    case (@exit_station.zone - @entry_station.zone).abs
    when 0 then 1
    when 1 then 2
    when 2 then 3
    when 3 then 4
    when 4 then 5
    else
      6
    end
  end
end
