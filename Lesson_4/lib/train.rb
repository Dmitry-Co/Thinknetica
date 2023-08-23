require_relative 'main'
# 3
class Train
  attr_accessor :speed, :current_station, :route
  attr_reader :vagons_count, :type, :number

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
    stop!
  end

  # Добавил stop! в protected, чтобы пользователь не мог вызвать его вне класса, 
  # но остальным подклассам видно, что произведена остановка.
  protected
  attr_writer :speed

  def speed_zero  # Скорость сброшена до нуля!
    0
  end

  def stop!
    self.speed = speed_zero
  end
  
  public
  
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