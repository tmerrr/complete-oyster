class JourneyLog
  attr_reader :journey_history

  def initialize(journey_class)
    @journey_history = []
    # @journey_class = journey_class
    # @journey = @journey_class.new
  end
end
