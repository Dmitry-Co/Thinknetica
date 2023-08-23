require_relative 'lib/cargo_train'
require_relative 'lib/cargo_vagon'
require_relative 'lib/passenger_train'
require_relative 'lib/passenger_vagon'
require_relative 'lib/route'
require_relative 'lib/station'
require_relative 'lib/train'
require_relative 'lib/vagon'

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

  def create_route 
    if @stations.size < 2 
      puts "Для построения маршрута необходимо большее количество станций!"
    else
      begin
        @stations.each { |station| puts station.title }
        puts "Выберите начальную станцию: "
        input = gets.chomp
        start_station = @stations.select { |station| station.title == input }

        puts "Выберите конечную станцию: "
        input = gets.chomp
        end_station = @stations.select { |station| station.title == input }

        @routes << Route.new(start_station[0], end_station[0])
        puts "Маршрут создан!"
      rescue => error
        p error
        puts "Данные введены некоректно, попробуйте еще раз!"
        retry
      end
    end
  end

  def find_route 
    puts "Задайте маршрут?"

    count = 0
    @routes.each do |route| 
      p "#{count} - #{route}" 
      count += 1
    end
    
    @routes[gets.chomp.to_i] 
  end

  def find_station 
    puts "Задайте станцию?"
    @stations.each { |station| puts station.title }

    gets.chomp
  end

  def find_train
    count = 0
      @trains.each do |train| 
        puts "#{count} - #{train}"
        count += 1
      end

    @trains[gets.chomp.to_i]
  end

  def station_action
    puts "Для добавления станции нажмите 1, для удаления станции нажмите 2"
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

  def add_train_route 
    puts "Какому поезду хотите добавить маршрут?"
    find_train.assign_route(find_route)
  end

  def wagon_actions
    puts "В каком поезде хотите добавить или отцепить вагоны?"
    train_f = find_train 

    puts "Отцепить(1) или добавить(2)?"
    action = gets.chomp
    case action
    when "1"
      if train_f.wagons.size < 1
        puts "У поезда нет прицепленных вагонов!" 
      else
        train_f.unhook_the_wagon
        puts "Вагон отцеплен!"
      end
    when "2"
      wagon = create_wagon(train_f)
      train_f.attach_a_wagon(wagon)
      puts "Вагон добавлен!"
    end
  end

  def move_train
    puts "Какой поезд вы хотите передвигать?"
    find_train.go_next_station
  end

  def check_stations
    puts "Станции - #{@stations}"
  end

  def check_trains
    @stations.each do |station|
      station.each_train do |train|
      puts "Станция - #{station.title}"
      puts "Номер поезда - #{train.number}, тип - #{train.type}, кол-во вагонов - #{train.wagons.size}"
      end
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

  def exit 
    "0"
  end
end

Main.new.start