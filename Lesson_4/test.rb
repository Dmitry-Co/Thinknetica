require_relative 'lib/cargo_train'
require_relative 'lib/cargo_vagon'
require_relative 'lib/passenger_train'
require_relative 'lib/passenger_vagon'
require_relative 'lib/route'
require_relative 'lib/station'
require_relative 'lib/train'
require_relative 'lib/vagon'

# tests
station_ekb = Station.new('Ekaterinburg')
station_tyu = Station.new('Tyumen')
station_oms = Station.new('Omsk')
station_mos = Station.new('Moscow')

route_ekb_mos = Route.new(station_ekb, station_mos)
route_ekb_mos.add_station(1, station_tyu)
route_ekb_mos.add_station(2, station_oms)
route_ekb_mos.stations

route_ekb_mos.delete_station(station_oms)
route_ekb_mos.stations

train11 = Train.new('1CT', 'cargo', 13)
train44 = Train.new('4PT', 'pass', 10)

# cargo
train11.set_speed(30)
p train11.speed
train11.stop
p train11.speed

train11.add_vagon
p train11.vagons_count
train11.remove_vagon
p train11.vagons_count

p train11.route
 train11.set_route(route_ekb_mos)
 train11.route.stations

train11.move_forward
train11.route.stations
p train11.current_station.name
train11.move_forward
p train11.current_station.name
train11.move_back
p train11.current_station.name
p train11.current_station.train_type('cargo')
p train11.next_station.train_type('cargo')
p train11.previous_station.train_type('cargo')

# pass
train44.add_vagon
p train44.vagons_count
train44.route
train44.set_route(route_ekb_mos)
p train44.set_speed(30)
train44.move_forward

p train44.current_station.name
print train44.current_station.train_type('pass')