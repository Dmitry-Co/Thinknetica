# frozen_string_literal: true

class Wagon
  include Manufacturer
  attr_reader :type, :total_place, :used_place

  def initialize(total_place)
    @total_place = total_place
    @used_place = 0
  end

  def free_place
    total_place - used_place
  end
end
