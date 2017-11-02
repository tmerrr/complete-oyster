require_relative 'journey'
require_relative 'station'

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
    raise "MaxLimit of #{MAXIMUM_AMOUNT}." if exceed?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if overdrawn?
    touch_in_checks
    @journey.set_entry_station(station)
  end

  def touch_out(exit_station)
    @journey.set_exit_station(exit_station)
    touch_out_process
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

  def set_new_journey
    @journey = Journey.new
  end

  def touch_in_checks
    charge_fare
    if in_journey?
      add_journey_to_history
      set_new_journey
    end
  end

  def touch_out_process
    charge_fare
    add_journey_to_history
    set_new_journey
  end

  def charge_fare
    deduct(@journey.fare)
  end

end
