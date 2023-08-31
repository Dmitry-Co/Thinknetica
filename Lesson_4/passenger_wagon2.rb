class PassengerWagon < Wagon   # assengerWagon наследует свойства и методы класса Wagon.
  def initialize(number)       # Конструктор класса PassengerWagon принимает один аргумент (seats_total).
    @type = :passenger         # Для инстансной переменной @type класса Wagon присваиваем значение грузового типа - :passenger уже для класса PassengerWagon.
    super                      # super используется для вызова конструктора родительского класса Wagon, для передачи аргумента seats_total родительскому конструктору.
  end
end