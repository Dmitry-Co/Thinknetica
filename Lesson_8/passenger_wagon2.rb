# frozen_string_literal: true

class PassengerWagon < Wagon
  def initialize(seats_total)
    @type = :passenger
    super
  end

  def take_place
    @used_place += 1
  end
end
