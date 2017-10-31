class Oystercard
  attr_reader :balance, :in_journey, :entry_station

  MAXIMUM_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise "Sorry, the balance on your Oyster card cannot exceed #{MAXIMUM_AMOUNT}." if exceed?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if overdrawn?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
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
end
