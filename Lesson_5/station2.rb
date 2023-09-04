# 1
class Station
  include InstanceCounter

  attr_reader :title      
  attr_accessor :trains   
 
  @@all = []              

  def self.all            
    @@all
  end

  def initialize(title)   
    @title = title        
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
end