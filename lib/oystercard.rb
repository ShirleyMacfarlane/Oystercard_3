class Oystercard 
  attr_reader :balance, :journey, :journeys
  MAX_CARD_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
    @journey = nil
  end

  def top_up(value)
    fail "You can not have more than #{MAX_CARD_BALANCE} in your balance" if (balance + value) > MAX_CARD_BALANCE
    @balance += value
  end

  def in_journey?
    !!@journey && !!@journey.entry_station
  end

  def touch_in(station)
    fail "Insufficent funds" if balance < MIN_JOURNEY_BALANCE
     @journey = Journey.new(station, nil)
  end

  def touch_out(station)
    deduct(MIN_JOURNEY_BALANCE)
    @journey.exit_station =  station
    current_journey = {entry_station: @journey.entry_station, exit_station: @journey.exit_station}
    @journeys.push(current_journey)
    @journey = nil
  end

  private
  def deduct(value)
    @balance -= value
  end

end

