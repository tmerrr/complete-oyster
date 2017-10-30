class Oystercard
  attr_reader :balance, :maximum_amount
  MAXIMUM_AMOUNT = 90

  def initialize
    @balance = 0
    @maximum_amount = MAXIMUM_AMOUNT
  end

  def top_up(amount)
    if (@balance + amount) > MAXIMUM_AMOUNT
      raise "Sorry, the balance on your Oyster card can not exceed #{MAXIMUM_AMOUNT}."
    end
    @balance += amount
  end

  def deduct(cost)
    @balance -= cost
  end
end
