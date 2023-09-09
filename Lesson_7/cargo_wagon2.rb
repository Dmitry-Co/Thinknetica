class CargoWagon < Wagon        
  def initialize(number)        
    @type = :cargo              
    super                       
  end

  def take_place(volume)
    @used_place += volume
  end
end
