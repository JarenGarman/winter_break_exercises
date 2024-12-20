# frozen_string_literal: true

# TLD
class Dealership
  attr_reader :name, :address, :inventory

  def initialize(name, address)
    @name = name
    @address = address
    @inventory = []
  end

  def inventory_count
    @inventory.length
  end

  def add_car(car)
    @inventory << car
  end

  def has_inventory? # rubocop:disable Naming/PredicateName
    !@inventory.empty?
  end

  def cars_by_make(make)
    @inventory.select { |car| car.make == make }
  end
end
