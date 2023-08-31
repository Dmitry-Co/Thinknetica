# 1
class Station
  attr_reader :title      # Объявляем метод доступа - геттер для переменных экземпляра.
  attr_accessor :trains   # Для получения значения этих переменных из вне класса.
 
  @@all = []              # Переменная @@all используется для хранения всех созданных экземпляров класса Station.

  def self.all            # метод self.all возвращает массив всех созданных экземпляров класса Station.
    @@all
  end

  def initialize(title)   # Конструктор класса, который принимает один аргумент title при создании нового экземпляра класса.
    @title = title        # Внутри конструктора происходит инициализация атрибутов title и trains.
    @trains = []          # атрибут trains
    @@all.push(self)      # Добавление созданного экземпляра в массив @@all.
  end

  def add_train(train)    # Метод добвыляет объект train в trains.
    @trains.push(train)
  end
  
  def remove_train(train) # Метод удаляет объект train из @trains.
    @trains.delete(train)
  end

  def return_train_by_type(type)                 # Метод возвращает массив поездов типа (type) из списка поездов, находящихся на данной станции.
    trains.select { |train| train.type == type } # метод select для фильтрации поездов по типу.
  end
 
  def each_train           # Метод которым перебираем в trains каждый аргумент train в блоке.
    trains.each do |train|
      yield(train)         # Передаем параметр (train) в блок .each do |train|
    end
  end
end