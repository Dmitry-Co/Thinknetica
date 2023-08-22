require_relative 'lib/station'
require_relative 'lib/route'
require_relative 'lib/train'
require_relative 'lib/passenger_train'
require_relative 'lib/passenger_vagon'
require_relative 'lib/cargo_train'

class Main
  ACTIONS = [
    { id: '1', title: 'Создать станцию', action: :create_station },
    { id: '2', title: 'Создать поезд', action: :create_train },
    { id: '3', title: 'Создать маршрут', action: :create_route },
    { id: '4', title: 'Управлять станциями(добавлять и удалять)', action: :station_action },
    { id: '5', title: 'Назначить маршрут поезду', action: :add_train_route },
    { id: '6', title: 'Добавить или удалить вагон у поезда', action: :wagon_actions },
    { id: '7', title: 'Перемещать поезд по маршруту(вперед и назад)', action: :move_train },
    { id: '8', title: 'Показать список станций', action: :check_stations },
    { id: '9', title: 'Показать список поездов на станции', action: :check_trains },
     {id: '0', title: 'Выход', action: :exit }
  ]

  def initialize
    @trains = []
    @stations = []
    @routes = []
  end

  def start
    loop do
      show_menu
      choice = gets_choice
      break if call_action(choice) == "0"
    end
  end

  private

  def show_menu
    puts "Нажмите 1 для создания станции"
    puts "Нажмите 2 для создания поезда"
    puts "Нажмите 3 для создания маршрута"
    puts "Нажмите 4 для удаления или добавления станции" 
    puts "Нажмите 5 для назначения маршрута поезду" 
    puts "Нажмите 6 для добавления или удаления вагона у поезда" 
    puts "Нажмите 7 для перемещения поезда по маршруту" 
    puts "Нажмите 8 для показа списка станций" 
    puts "Нажмите 9 для показа списка поездов на станции" 
    puts "Нажмите 0, для выхода"
  end

  def gets_choice
    input = gets.chomp
    hash_of_action = ACTIONS.find { |action| action[:id] == input }
    if hash_of_action
      method_name = hash_of_action[:action] 
    else
      puts "Данные введены некоректно!"
    end
  end
  
  def call_action(choice)
    send(choice) if choice
  end
  
  def create_station
    puts "Введите название для станции: "
    begin
      title = gets.chomp
      @stations << Station.new(title)
      puts "Станция создана!"
    rescue => error
      p error
      puts "Данные введены некоректно, попробуйте еще раз!"
      retry
    end
  end

  def create_train
    puts "Какой тип поезда вы хотите создать:
    Нажмите 1 для создания грузового поезда,
    Нажмите 2 для создания пассажирского поезда"
    type = gets.chomp
    loop do 
      break if type == "1" || type == "2"
      puts "Пожалуйста, выберайте только 1 или 2"
      type = gets.chomp
    end
    puts "Какой номер у поезда?"

    begin
      number = gets.chomp
      case type 
      when "1"
        puts "Поезд #{@trains << CargoTrain.new(number)} создан!"
      when "2"
        puts "Поезд #{@trains << PassengerTrain.new(number)} создан!"
      end
    rescue => error
      p error
      puts "Данные введены некоректно, попробуйте еще раз!"
      retry
    end
  end

Main.new.start

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