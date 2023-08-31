class PassengerTrain < Train  # PassengerTrain наследует свойства и методы класса Train.
  def initialize(number)      # Конструктор класса PassengerTrain принимает один аргумент (number).
    super                     # super используется для вызова конструктора родительского класса Train, для передачи аргумента number родительскому конструктору, для инициализации номера поезда.
    @type = :passenger        # Для инстансной переменной @type класса Train присваиваем значение грузового типа - :passenger уже для класса PassengerTrain.
  end
end