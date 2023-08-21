# 1
class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end
  
  def train_type(type)
    quantity = @trains.count { |train| train.type == type }
    puts "On station #{@name} there are #{quantity} trains of type #{type}."
  end
end