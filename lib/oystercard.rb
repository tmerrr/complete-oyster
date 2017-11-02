require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey, :journey_history

  INITIAL_BALANCE = 0
  MAXIMUM_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize(balance: INITIAL_BALANCE, journey: Journey.new)
    @balance          = balance
    @journey_history  = []
    @journey          = journey
  end

  def top_up(amount)
    raise "Sorry, the balance on your Oyster card cannot exceed #{MAXIMUM_AMOUNT}." if exceed?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if overdrawn?
    deduct(@journey.fare)
    # if penalty is charged, push journey to history
    # then start a new journey
    if in_journey? 
      add_journey_to_history
      @journey = Journey.new
    end
    @journey.set_entry_station(station)
  end

  def touch_out(exit_station)
    # deduct(MINIMUM_FARE)
    @journey.set_exit_station(exit_station)
    deduct(@journey.fare)
    add_journey_to_history
    @journey = Journey.new
  end

  def in_journey?
    @journey.in_journey?
  end

  private

  def exceed?(amount)
    @balance + amount > MAXIMUM_AMOUNT ? true : false
  end

  def overdrawn?
    @balance < MINIMUM_FARE
  end

  def deduct(cost)
    @balance -= cost
  end

  def add_journey_to_history
    @journey_history << @journey
  end

end
