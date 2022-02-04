class Oystercard
  # hello SHirley
  attr_reader :balance, :entry_station, :exit_station, :journey
  MAX_CARD_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
    @journey = nil
  end

  def top_up(value)
    fail "You can not have more than #{MAX_CARD_BALANCE} in your balance" if (balance + value) > MAX_CARD_BALANCE
    @balance += value
  end

  def in_journey?
    #@entry_station != nil
    !!entry_station
    #@journey[:entry_station] != nil

  end

  def touch_in(station)
    fail "Insufficent funds" if balance < MIN_JOURNEY_BALANCE
     @journey = Journey.new(station, nil)
     @in_journey = true
     @entry_station = station
    # @journey[:entry_station] = station
     

  end

  def touch_out(station)
    deduct(MIN_JOURNEY_BALANCE)
    @journey(@entry_station, station)
    #@journey[:exit_station] = station
    @entry_station = nil
  end


  private

  def deduct(value)
    @balance -= value
  end


end
