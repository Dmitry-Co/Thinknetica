# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(volume_total)
    @type = :cargo
    super
  end

  def take_place(volume)
    @used_place += volume
  end
end
