# 2
class Route
  attr_reader :first_station, :last_station, :stations
  include InstanceCounter

  @@all = [] 

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    validate!
    register_instance
  end

  def valid?
    validate!
  rescue
    false
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

  protected

  def validate!
    raise "Станция должна быть объектом класса станций (Station)!" if stations.any? { |station| !station.is_a?(Station) }
    true
  end
end