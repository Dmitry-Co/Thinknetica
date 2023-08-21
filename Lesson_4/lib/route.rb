# 2
class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(index, station)
    @stations.insert(-1, station)
    # @stations << station
  end

  def delete_station(station)
    @stations.delete(station)
  end
end