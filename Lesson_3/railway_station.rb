# Presenting 'Railway station management service'.
# Here you can manage stations, add and send trains, display information about them, etc.

# 1
class Station
    attr_reader :name_station, :trains

    def initialize(name_station)
        @name_station = name_station
        @trains = []
    end

    def add_train(train)
        @trains << train
    end

    def train_type(type)
        quantity = @trains.count{|train| train.type == type}
        puts "On station #{@name_station} there are #{quantity} trains of type #{type}."
    end

    def send_train(train)
        @trains.delete(train)
    end
end


# 2
class Route
    
    attr_reader :start_station, :end_station, :mid_stations

    def initialize(start_station, end_station, mid_stations = [])
        @start_station = start_station
        @end_station = end_station
        @mid_stations = mid_stations
    end

    def add_mid_station(station, index)
        return if @mid_stations.include?(station) || 
        station == @start_station || 
        station == @end_station
        @mid_stations.insert(index, station)
    end

    def delete_mid_station(station)
        @mid_stations.delete(station)
    end

    def stations_list
        [start_station, mid_stations, end_station].flatten!.compact
    end

    def show_route
        stations_list.each {|station| puts "#{station.name_station}"}
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
        @current_station = route.start_station
        @station_index = 0
        @current_station.add_train(self)
    end

    def move_forward
        return unless @route || @current_station == @route.stations_list.last
        @station_index += 1
        @current_station = @route.stations_list[@station_index]
        @current_station.add_train(self)
        previous_station.send_train(self)
      end
    
      def move_back
        return unless @route || @current_station == @route.stations_list.first
        @station_index -= 1
        @current_station = @route.stations_list[@station_index]
        @current_station.add_train(self)
        next_station.send_train(self)
      end

    def next_station
        return unless @route || current_station == @route.stations_list.last
        @route.stations_list[@station_index + 1]
    end
    
    def previous_station
        return unless @route || current_station == @route.stations_list.first
        @route.stations_list[@station_index - 1]
     end
end


# 4
station_ekb = Station.new("Ekaterinburg")
station_tyu = Station.new("Tyumen")
station_oms = Station.new("Omsk")
station_mos = Station.new("Moscow")

route_ekb_mos = Route.new(station_ekb, station_mos, [station_tyu, station_oms] )
route_ekb_mos.show_route
puts
route_ekb_mos.add_mid_station(station_tyu, 2)
route_ekb_mos.add_mid_station(station_oms, 3)
route_ekb_mos.show_route
puts
route_ekb_mos.delete_mid_station(station_oms)
route_ekb_mos.show_route

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
train11.route.show_route
puts
train11.current_station.train_type('cargo')
p train11.next_station.name_station
train11.move_forward
print train11.current_station
p train11.next_station
train11.move_forward
p train11.current_station.name_station
train11.current_station.train_type('cargo')
train11.move_back
p train11.current_station.name_station
train11.current_station.train_type('cargo')
train11.next_station.train_type('cargo')

station_tyu.add_train(train33)
station_tyu.add_train(train44)
station_tyu.train_type('cargo')
station_tyu.send_train(train22)
station_tyu.train_type('pass')
