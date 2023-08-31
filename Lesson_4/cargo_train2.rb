class CargoTrain < Train # CargoTrain наследует свойства и методы класса Train.
  def initialize(number) # Конструктор класса CargoTrain принимает один аргумент (number).
    super                # super используется для вызова конструктора родительского класса Train, для передачи аргумента number родительскому конструктору, для инициализации номера поезда.
    @type = :cargo       # Для инстансной переменной @type класса Train присваиваем значение грузового типа - :cargo уже для класса CargoTrain.
  end
end
