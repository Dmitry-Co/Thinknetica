require_relative 'lib/station'
require_relative 'lib/route'
require_relative 'lib/train'
require_relative 'lib/passenger_train'
require_relative 'lib/passenger_vagon'
require_relative 'lib/cargo_train'



train11 = Train.new('11', 'cargo', 777)

train11.set_speed(30)
puts train11.speed
train11.stop
puts train11.speed
