# 1
class Station
  include InstanceCounter
  include Validation

  STATION_FORMAT = /^[a-zA-Z]+$/

  attr_reader :title     
  attr_accessor :trains   
 
  @@all = []              

  def self.all            
    @@all
  end

  def initialize(title)   
    @title = title
    validate!
    @trains = []          
    @@all.push(self)
    register_instance
  end

  def add_train(train)    
    @trains.push(train)
  end
  
  def remove_train(train) 
    @trains.delete(train)
  end

  def return_train_by_type(type)                 
    trains.select { |train| train.type == type } 
  end
 
  def each_train           
    trains.each do |train|
      yield(train)         
    end
  end

  protected

  def validate!
    errors = []
    errors << "Номер станции не может быть пустым" if title.nil? || title == ""
    #errors << "Номер поезда не может быть пустым" if title.blank?
    #errors << "Номер поезда не может быть пустым" if title.empty?
    errors << "Номер станции не может быть менее 5ти символов" if title.length < 5
    errors << "Номер станции не является объектом класса String и написан не на англиском языке" unless title.match?(STATION_FORMAT)
    raise errors.join(", \n") unless errors.empty?
  end
end