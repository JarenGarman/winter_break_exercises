# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Dealership do
  subject(:dealership) { described_class.new('Acme Auto', '123 Main Street') }

  describe '#initialize' do
    it { is_expected.to be_an_instance_of(described_class) }

    it 'has a name' do
      expect(dealership.name).to eq('Acme Auto')
    end

    it 'has an address' do
      expect(dealership.address).to eq('123 Main Street')
    end

    it 'has empty inventory' do
      expect(dealership.inventory).to eq([])
    end

    it 'has zero inventory_count' do
      expect(dealership.inventory_count).to eq(0)
    end
  end

  describe '#add_car' do
    let(:first_car) { Car.new('Ford Mustang', 1500, 36) }
    let(:second_car) { Car.new('Toyota Prius', 1000, 48) }

    before do
      dealership.add_car(first_car)
      dealership.add_car(second_car)
    end

    it 'can add cars to inventory' do
      expect(dealership.inventory).to eq([first_car, second_car])
    end

    it 'can update inventory count' do
      expect(dealership.inventory_count).to eq(2)
    end
  end

  describe '#has_inventory?' do
    subject(:has_inventory) { dealership.has_inventory? }

    context 'without inventory' do
      it { is_expected.to be false }
    end

    context 'with inventory' do
      let(:car) { Car.new('Ford Mustang', 1500, 36) }

      before do
        dealership.add_car(car)
      end

      it { is_expected.to be true }
    end
  end

  describe '#cars_by_make' do
    let(:first_car) { Car.new('Ford Mustang', 1500, 36) }
    let(:second_car) { Car.new('Toyota Prius', 1000, 48) }
    let(:third_car) { Car.new('Toyota Tercel', 500, 48) }
    let(:fourth_car) { Car.new('Chevrolet Bronco', 1250, 24) }

    before do
      dealership.add_car(first_car)
      dealership.add_car(second_car)
      dealership.add_car(third_car)
      dealership.add_car(fourth_car)
    end

    it 'can grab a car by make' do
      expect(dealership.cars_by_make('Ford')).to eq([first_car])
    end

    it 'can grab multiple cars by make' do
      expect(dealership.cars_by_make('Toyota')).to eq([second_car, third_car])
    end
  end

  describe '#total_value' do
    let(:first_car) { Car.new('Ford Mustang', 1500, 36) }
    let(:second_car) { Car.new('Toyota Prius', 1000, 48) }
    let(:third_car) { Car.new('Toyota Tercel', 500, 48) }
    let(:fourth_car) { Car.new('Chevrolet Bronco', 1250, 24) }

    before do
      dealership.add_car(first_car)
      dealership.add_car(second_car)
      dealership.add_car(third_car)
      dealership.add_car(fourth_car)
    end

    it 'can calculate total value' do
      expect(dealership.total_value).to eq(156_000)
    end
  end
end
