require_relative 'instance_counter2'
require_relative 'manufacturer2'
require_relative 'validation2'
require_relative 'train2'
require_relative 'station2'
require_relative 'route2'
require_relative 'cargo_train2'
require_relative 'passenger_train2'
require_relative 'wagon2'
require_relative 'passenger_wagon2'
require_relative 'cargo_wagon2'

class Main

  ACTIONS = [
    { id: '1',  title: 'Создать станцию', action: :create_station },
    { id: '2',  title: 'Создать поезд', action: :create_train },
    { id: '3',  title: 'Создать маршрут', action: :create_route },
    { id: '4',  title: 'Управлять станциями(добавлять и удалять)', action: :station_action },
    { id: '5',  title: 'Назначить маршрут поезду', action: :add_train_route },
    { id: '6',  title: 'Добавить или удалить вагон у поезда', action: :wagon_actions },
    { id: '7',  title: 'Перемещать поезд по маршруту(вперед и назад)', action: :move_train },
    { id: '8',  title: 'Показать список станций', action: :check_stations },
    { id: '9',  title: 'Показать список поездов на станции', action: :check_trains },
    { id: '10', title: 'Показать список вагонов у поездов', action: :check_wagons },
    { id: '11', title: 'Занять места или объем в вагоне', action: :take_in_wagon },
    { id: '0',  title: 'Выход', action: :exit }
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
    puts "Нажмите 1  для создания станции"
    puts "Нажмите 2  для создания поезда"
    puts "Нажмите 3  для создания маршрута"
    puts "Нажмите 4  для удаления или добавления станции" 
    puts "Нажмите 5  для назначения маршрута поезду" 
    puts "Нажмите 6  для добавления или удаления вагона у поезда" 
    puts "Нажмите 7  для перемещения поезда по маршруту" 
    puts "Нажмите 8  для показа списка станций" 
    puts "Нажмите 9  для показа списка поездов на станции"
    puts "Нажмите 10 показать список вагонов у поездов"
    puts "Нажмите 11 чтобы занять место или объем в вагоне"
    puts "Нажмите 0 для выхода"
  end

  def gets_choice
    input = gets.chomp
    hash_of_action = ACTIONS.find { |action| action[:id] == input }
    if hash_of_action
      method_name = hash_of_action[:action] 
    else
      puts "Действие не найдено"
    end
  end
  
  def call_action(choice)
    send(choice) if choice
  end
  
# RouteActions
  def find_route 
    puts "В какой маршрут?"

    count = 0
    @routes.each do |route| 
      p "#{count} - #{route}" 
      count += 1
    end
    
    @routes[gets.chomp.to_i] 
  end

  def new_route
    @stations.each { |station| puts station.title }

    puts 'Выберите начальную станцию: '
    input = gets.chomp
    start_station = @stations.select { |station| station.title == input }

    puts 'Выберите конечную станцию: '
    input = gets.chomp
    end_station = @stations.select { |station| station.title == input }

    @routes << Route.new(start_station[0], end_station[0])
    puts 'Маршрут успешно создан!'
  end

  def create_route 
    if @stations.size < 2 
      puts "Вы ввели недостаточно станций!"
    else
      begin
       new_route
      rescue StandardError => e
        puts "Ввод не верен: #{e}, повторите еще раз!"
        retry
      end
    end
  end

# StationActions
def find_station 
  puts "Какую станцию?"
  @stations.each { |station| puts station.title }

  gets.chomp
end

def create_station
  puts "Введите название для станции по условию:
   1) Не менне 5 символов
   2) Формат строки и на английском языке"
  begin
    title = gets.chomp
    @stations << Station.new(title)
    puts "Станция успешно создана!"
  rescue StandardError => e
    puts "Ввод не верен:\n#{e}, повторите еще раз!"
    retry
  end
end

def station_action
  puts "Чтобы добавить станцию нажмите 1, чтобы удалить станцию нажмите 2"
  input = gets.chomp

  case input 
  when "1"  
    find_route.add_station(get_station(find_station)[0])
  when "2"  
    find_route.delete_station(get_station(find_station)[0])
  end
end

def get_station(input)
  @stations.select { |station| station.title == input }
end

def check_stations
  puts "Станции - #{@stations}"
end

# TrainActions
def find_train
  count = 0
    @trains.each do |train| 
      puts "#{count} - #{train}"
      count += 1
    end

  @trains[gets.chomp.to_i]
end

def create_train
  puts "Вы хотите создавть грузовой(нажмите 1) или поссажирский(нажмите 2) поезд?"
  type = gets.chomp
  loop do 
    break if type == "1" || type == "2"
    puts "Пожалуйста, выберайте только 1 или 2"
    type = gets.chomp
  end
  
  puts "Задайте номер поезда по типу: комбинация 3х английских букв или чисел, дефис(необязателен), комбинация 2х английских букв или чисел."
  begin
    number = gets.chomp
    case type 
    when "1"
      puts "Поезд #{@trains << CargoTrain.new(number)} был успешно создан!"
    when "2"
      puts "Поезд #{@trains << PassengerTrain.new(number)} был успешно создан!"
    end
  rescue StandardError => e
    puts "Ввод не верен:\n#{e}, повторите еще раз!"
    retry
  end
end

def add_train_route 
  puts "Какому поезду хотите добавить маршрут?"
  find_train.assign_route(find_route)
end

def move_train
  puts 'Какой поезд вы хотите передвигать?'
  find_train.go_next_station
end

def check_trains
  @stations.each do |station|
    station.each_train do |train|
    puts "Станция - #{station.title}"
    puts "Номер поезда - #{train.number}, тип - #{train.type}, кол-во вагонов - #{train.wagons.size}"
    end
  end
end

# WagonActions
def wagon_actions
  puts "К какомоу поезду хотите добавить или отцепить вагоны??"
  train_f = find_train 

  puts "Оцепить(1) или прицепить(2)?"
  action = gets.chomp
  case action
  when "1"
    if train_f.wagons.size < 1
      puts "У поезда нет прицепленных вагонов!" 
    else
      train_f.unhook_the_wagon
      puts "Вагон успешно отцеплен!"
    end
  when "2"
    wagon = create_wagon(train_f)
    train_f.attach_a_wagon(wagon)
    puts "Вагон успешно добавлен!"
  end
end

def create_wagon(train) 
  puts "На сколько расчитан вагон?"
  begin
    input = gets.chomp.to_i
    if train.type == :passenger 
      PassengerWagon.new(input)
    elsif train.type == :cargo
      CargoWagon.new(input)
    end
  rescue => e
    p "#{e}"
    puts "Попробуйте еще раз!"
    retry
  end
end

def take_in_wagon
  puts 'В каком поезде вы хотите занять место в вагоне?'
  train = find_train
  puts 'Вагон какого поезда хотите занять?'
  number = 0
  train.each_wagon do |wagon|
    puts "#{number} - #{wagon}"
    number += 1
  end
  choice = gets.chomp.to_i
  wagon = train.wagons[choice]
  if wagon.type == :cargo
    puts "В данном вагоне свободный объём для загрузки #{wagon.free_place} от общего объема #{wagon.total_place}"
    puts 'Какой объем хотите загрузить?'
    volume = gets.chomp.to_i
    if wagon.free_place >= volume
      wagon.take_place(volume)
      puts "Вы успешно заняли вагон на #{volume}!"
      puts "Загруженность вагона составляет #{wagon.used_place} из #{wagon.total_place}!"
    else
      puts 'Вы не можете занять больше объема чем столько, насколько расчитан вагон!'
    end
    puts 'Вагон уже полностью загружен!' if wagon.free_place.zero?
  elsif wagon.type == :passenger
    puts "В данном вагоне свободно #{wagon.free_place} мест"
    wagon.take_place
    puts "Вы успешно заняли место, в вагоне осталось #{wagon.free_place} свободных мест!"
  end
end

def check_wagons
  number = 0
  @trains.each do |train|
    train.each_wagon do |wagon|
      puts "Номер вагона - #{number}, тип - #{wagon.type}, свободно места- #{wagon.free_place}"
      number += 1
    end
  end
end

# exit
  def exit 
    "0"
  end
end

Main.new.start

