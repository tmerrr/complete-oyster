require_relative 'journey'
require_relative 'station'
require_relative 'journeylog'

class Oystercard
  attr_reader :balance

  INITIAL_BALANCE = 0
  MAXIMUM_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize(balance: INITIAL_BALANCE, journeylog: JourneyLog.new)
    @balance    = balance
    @journeylog = journeylog
  end

  def top_up(amount)
    raise "MaxLimit of #{MAXIMUM_AMOUNT}." if exceed?(amount)
    raise 'InvalidValue' if amount < 0
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if overdrawn?
    charge_fare
    @journeylog.start(station)
  end

  def touch_out(exit_station)
    @journeylog.finish(exit_station)
    charge_fare
    @journeylog.complete_journey
  end

  def in_journey?
    @journeylog.in_journey?
  end

  def view_history
    @journeylog.view_history
  end

  private

  def exceed?(amount)
    (@balance + amount) > MAXIMUM_AMOUNT
  end

  def overdrawn?
    @balance < MINIMUM_FARE
  end

  def deduct(cost)
    @balance -= cost
  end

  def charge_fare
    deduct(@journeylog.charge)
  end

end
