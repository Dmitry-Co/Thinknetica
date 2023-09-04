# 2
class Route
  attr_reader :first_station, :last_station, :stations
  include InstanceCounter

  @@all = [] 

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    register_instance
  end

  def self.all
    @@all
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end
end