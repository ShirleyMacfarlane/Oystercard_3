class Journey
attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def calc_fare

  end

  def complete?
    !!entry_station && !!exit_station
e  nd

end
