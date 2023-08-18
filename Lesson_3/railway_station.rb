# Presenting 'Railway station management service'.
# Here you can manage stations, add and send trains, display information about them, etc.

# 1
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def train_type(type)
    quantity = @trains.count { |train| train.type == type }
    puts "On station #{@name} there are #{quantity} trains of type #{type}."
  end

  def send_train(train)
    @trains.delete(train)
  end
end

# route.stations

# 2
class Route
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

  def stations_list
    [start_station, mid_stations, end_station].flatten!.compact
  end
end

# 3
class Train
  attr_accessor :speed, :current_station, :route
  attr_reader :vagons_count, :type

  def initialize(number, type, vagons_count)
    @number = number
    @type = type
    @vagons_count = vagons_count
    @speed = 0
  end

  def set_speed(boost)
    @speed += boost
  end

  def stop
    @speed = 0
  end

  def add_vagon
    @vagons_count += 1 if @speed == 0
  end

  def remove_vagon
    @vagons_count -= 1 if @speed == 0 && @vagons_count > 0
  end

  def set_route(route)
    @route = route
    @current_station_index = 0
    current_station.add_train(self)
  end

  def current_station
    route.stations[@current_station_index]
  end

  def next_station
    route.stations[@current_station_index + 1]
  end

  def previous_station
    route.stations[@current_station_index - 1]
  end
    
  def move_forward
    return unless next_station
    current_station.send_train(self)
    @current_station_index += 1
    current_station.add_train(self)
  end

  def move_back
    return unless previous_station
    current_station.send_train(self)
    @current_station_index -= 1
    current_station.add_train(self)
  end
end

=begin
# 4
station_ekb = Station.new('Ekaterinburg')
station_tyu = Station.new('Tyumen')
station_oms = Station.new('Omsk')
station_mos = Station.new('Moscow')

route_ekb_mos = Route.new(station_ekb, station_mos)
# route_ekb_mos.route.stations
puts
route_ekb_mos.add_station(station_tyu, 2)
route_ekb_mos.add_station(station_oms, 3)
# route_ekb_mos.route.stations
puts
route_ekb_mos.delete_station(station_oms)
# route_ekb_mos.route.stations

train11 = Train.new('11', 'cargo', 40)
train22 = Train.new('22', 'cargo', 30)
train33 = Train.new('33', 'pass', 20)
train44 = Train.new('44', 'pass', 10)

train11.set_speed(20)
puts train11.speed
train11.stop
puts train11.speed
puts
train11.add_vagon
puts train11.vagons_count
train11.remove_vagon
puts train11.vagons_count
puts
train11.set_route(route_ekb_mos)
train11.route.stations
puts
train11.current_station.train_type('cargo')
p train11.next_station.name
train11.move_forward
print train11.current_station
p train11.next_station
train11.move_forward
p train11.current_station.name
train11.current_station.train_type('cargo')
train11.move_back
p train11.current_station.name
train11.current_station.train_type('cargo')
train11.next_station.train_type('cargo')

station_tyu.add_train(train33)
station_tyu.add_train(train44)
station_tyu.train_type('cargo')
station_tyu.send_train(train22)
station_tyu.train_type('pass')
=end