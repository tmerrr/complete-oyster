require_relative 'journey'

class JourneyLog
  attr_reader :history, :journey

  def initialize(journey_class = Journey)
    @history = []
    @journey_class = journey_class
    create_new_journey
  end

  def start(entry_station)
    complete_journey if in_journey?
    @journey.set_entry_station(entry_station)
  end

  def finish(exit_station)
    @journey.set_exit_station(exit_station)
  end

  def in_journey?
    @journey.in_journey?
  end

  def complete_journey
    add_journey_to_history
    create_new_journey
  end

  def charge
    @journey.fare
  end

  def view_history
    @history.each { |journey| puts journey.get_string }
  end

  private
  def add_journey_to_history
    @history << @journey
  end

  def create_new_journey
    @journey = @journey_class.new
  end

end
