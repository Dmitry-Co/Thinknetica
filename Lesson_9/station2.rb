# frozen_string_literal: true

class Station
  extend Accessors
  include Validation
  include InstanceCounter

  STATION_FORMAT = /^[a-zA-Z]+$/

  attr_reader :title

  attr_accessor_with_history :trains

  validate :title, :presence
  validate :title, :format, STATION_FORMAT

  @@all = []

  def self.all
    @@all
  end

  def initialize(title)
    @title = title
    @trains = []
    validate!
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

  def each_train(&block)
    trains.each(&block)
  end
end
