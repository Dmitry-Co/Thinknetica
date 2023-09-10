# frozen_string_literal: true

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

  # def each_train
  #   trains.each do |train|
  #     yield(train)
  #   end
  # end

  # аналог закомментирован выше c блоком yield(train)
  def each_train(&block)
    trains.each(&block)
  end

  protected

  def validate!
    errors = []
    errors << 'Номер станции не может быть пустым' if title.empty?
    # errors << "Номер поезда не может быть пустым" if title.blank?
    # errors << "Номер поезда не может быть пустым" if title.nil? || title == ""
    errors << 'Номер станции не может быть менее 3х символов' if title.length < 3
    unless title.match?(STATION_FORMAT)
      errors << 'Номер станции не является объектом класса String и написан не на англиском языке'
    end
    raise errors.join(", \n") unless errors.empty?
  end
end
