class Journey
attr_accessor :entry_station, :exit_station

  def initialize(entry_station, exit_station)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def calc_fare

  end

  def complete?
    !!entry_station && !!exit_station
end

end
