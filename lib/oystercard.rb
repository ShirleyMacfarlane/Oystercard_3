class Oystercard
  attr_reader :balance
  MAX_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "You can not have more than 90 in your balance" if (balance + value) > MAX_LIMIT
    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def in_journey?
    return @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end