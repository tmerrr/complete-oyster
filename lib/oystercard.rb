class Oystercard
  attr_reader :balance, :maximum_amount, :in_journey
  MAXIMUM_AMOUNT = 90

  def initialize
    @balance = 0
    @maximum_amount = MAXIMUM_AMOUNT
    @in_journey = self.in_journey?
  end

  def top_up(amount)
    if exceed?(amount)
      raise "Sorry, the balance on your Oyster card can not exceed #{MAXIMUM_AMOUNT}."
    end
    @balance += amount
  end

  def deduct(cost)
    @balance -= cost
  end

  def in_journey?(journey = false)
    @in_journey = journey
  end

  def touch_in
    self.in_journey?(true)
  end

  private

  def exceed?(amount)
    @balance + amount > MAXIMUM_AMOUNT ? true : false
  end
end
