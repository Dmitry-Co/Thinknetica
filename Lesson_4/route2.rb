# 2
class Route
  # Объявляем метод доступа - геттер для трех переменных экземпляра.
  # Для получения значения этих переменных из вне класса.
  attr_reader :first_station, :last_station, :stations


  # Переменная @@all используется для хранения всех созданных экземпляров класса Route.
  @@all = [] 

  # Конструктор класса, который принимает начальную и конечную станции маршрута и инициализирует переменные экземпляра @first_station и @last_station. 
  # Также создается массив @stations, включающий в себя начальную и конечную станции.
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
  end

  # Возвращаем массив всех маршрутов переменной @@all.
  def self.all
    @@all
  end

  # Этот метод добавляет станцию (представленную объектом) в массив @stations между начальной и конечной станциями. 
  # Он использует метод insert с параметром -2, чтобы вставить станцию перед последней станцией.
  def add_station(station)
    stations.insert(-2, station)
  end

  # Этот метод удаляет указанную станцию из массива @stations.
  def delete_station(station)
    stations.delete(station)
  end
end