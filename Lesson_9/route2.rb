# frozen_string_literal: true

class Route
  extend Accessors
  include InstanceCounter
  include Validation

  attr_reader :first_station, :last_station, :stations

  validate :first_station, :type, Station
  validate :last_station, :type, Station

  @@all = []

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    validate!
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
