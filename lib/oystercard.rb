class Oystercard
  attr_reader :balance
  MAX_CARD_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "You can not have more than #{MAX_CARD_BALANCE} in your balance" if (balance + value) > MAX_CARD_BALANCE
    @balance += value
  end

  def in_journey?
    return @in_journey
  end

  def touch_in
    fail "Insufficent funds" if balance < MIN_JOURNEY_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_JOURNEY_BALANCE)
    @in_journey = false
  end

  private


  def deduct(value)
    @balance -= value
  end

end