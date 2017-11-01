class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :journey, :journey_history

  INITIAL_BALANCE = 0
  MAXIMUM_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize(balance = INITIAL_BALANCE)
    @balance = balance
    @journey_history = []
    @journey = {}
  end

  def top_up(amount)
    raise "Sorry, the balance on your Oyster card cannot exceed #{MAXIMUM_AMOUNT}." if exceed?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if overdrawn?
    add_station_to_journey(:entry_station, station)
    @entry_station = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    add_station_to_journey(:exit_station, exit_station)
    @entry_station = nil
    add_journey_to_history
  end

  def in_journey?
    @entry_station ? true : false
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

  def add_station_to_journey(key, station)
    @journey[key] = station
  end
end
