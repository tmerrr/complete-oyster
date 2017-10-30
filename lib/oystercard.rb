class Oystercard
  attr_reader :balance, :maximum_amount
  MAXIMUM_AMOUNT = 90

  def initialize
    @balance = 0
    @maximum_amount = MAXIMUM_AMOUNT
  end

  def top_up(amount)
    fail "Sorry, the balance on your Oyster card can not exceed #{MAXIMUM_AMOUNT}." if (@balance + amount) > MAXIMUM_AMOUNT
    @balance += amount
  end
end
