class Train
  include Manufacturer
  include InstanceCounter

  TRAIN_FORMAT = /^[a-zA-Z\d]{3}-?[a-zA-Z\d]{2}$/

  attr_reader :route, :current_station_index, :wagons, :speed, :number, :type 


  @@all = []

  def initialize(number)
    @number = number
    validate!
    @wagons = []
    @speed = 0
    @@all.push(self)
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def self.find(num)
    @@all.select { |train| train.number == num ? train : nil } 
  end

  def self.all
    @@all
  end

  def assign_route(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  def current_station
    route.stations[current_station_index]
  end

  def next_station
    route.stations[current_station_index + 1]
  end

  def previous_station
    route.stations[current_station_index - 1]
  end

  def go_next_station
    return unless next_station
    current_station.remove_train(self) if current_station
    @current_station_index += 1
    current_station.add_train(self)
  end

  def go_previous_station
    return unless previous_station
    current_station.remove_train(self) if current_station
    @current_station_index -= 1
    current_station.add_train(self)
  end

  def pick_up_speed(value)
    self.speed += value
  end

  def stop
    self.speed = 0
  end

  def unhook_the_wagon
    self.wagons.pop
  end

  def attach_a_wagon(wagon)
    self.wagons << wagon if wagon.type == type
  end

  protected

  def validate!
    raise "Номер поезда не может быть пустым!" if number.nil?
    raise "Формат номера поезда необходимо вводить по типу: комбинация 3х английских букв или чисел, дефис(необязателен), комбинация 2х английских букв или чисел." if number !~ TRAIN_FORMAT
    true
  end
end