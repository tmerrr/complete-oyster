class Oystercard
  attr_reader :balance, :maximum_amount, :in_journey
  attr_writer :in_journey

  MAXIMUM_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise "Sorry, the balance on your Oyster card cannot exceed #{MAXIMUM_AMOUNT}." if exceed?(amount)
    @balance += amount
  end

  def touch_in
    raise "Insufficient funds" if overdrawn?
    @in_journey = true
  end

  def touch_out(cost)
    deduct(MINIMUM_FARE)
    @in_journey = false
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
