class CargoWagon < Wagon        # CargoWagon наследует свойства и методы класса Wagon.
  def initialize(number)        # Конструктор класса CargoWagon принимает один аргумент (volume_total).
    @type = :cargo              # Для инстансной переменной @type класса Wagon присваиваем значение грузового типа - :cargo уже для класса CargoWagon.
    super                       # super используется для вызова конструктора родительского класса Wagon, для передачи аргумента volume_total родительскому конструктору.
  end
end