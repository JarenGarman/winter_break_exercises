# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Dealership do
  subject(:dealership) { described_class.new('Acme Auto', '123 Main Street') }

  let(:first_car) { Car.new('Ford Mustang', 1500, 36) }
  let(:second_car) { Car.new('Toyota Prius', 1000, 48) }
  let(:third_car) { Car.new('Toyota Tercel', 500, 48) }
  let(:fourth_car) { Car.new('Chevrolet Bronco', 1250, 24) }

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
      before do
        dealership.add_car(first_car)
      end

      it { is_expected.to be true }
    end
  end

  describe '#cars_by_make' do
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

  describe '#details' do
    before do
      dealership.add_car(first_car)
      dealership.add_car(second_car)
      dealership.add_car(third_car)
      dealership.add_car(fourth_car)
    end

    it 'can return details' do
      expect(dealership.details).to eq({ 'total_value' => 156_000, 'address' => '123 Main Street' })
    end
  end

  describe '#average_price_of_car' do
    before do
      dealership.add_car(first_car)
      dealership.add_car(second_car)
      dealership.add_car(third_car)
      dealership.add_car(fourth_car)
    end

    it 'can calculate average price of car' do
      expect(dealership.average_price_of_car).to eq('39,000')
    end
  end

  describe '#cars_sorted_by_price' do
    before do
      dealership.add_car(first_car)
      dealership.add_car(second_car)
      dealership.add_car(third_car)
      dealership.add_car(fourth_car)
    end

    it 'can grab cars sorted by price' do
      expect(dealership.cars_sorted_by_price).to eq([third_car, fourth_car, second_car, first_car])
    end
  end

  describe '#dealership.inventory_hash' do
    before do
      dealership.add_car(first_car)
      dealership.add_car(second_car)
      dealership.add_car(third_car)
      dealership.add_car(fourth_car)
    end

    it 'can create inventory hash' do
      expect(dealership.dealership.inventory_hash).to eq({
                                                           'Ford' => [first_car],
                                                           'Toyota' => [second_car, third_car],
                                                           'Chevrolet' => [fourth_car]
                                                         })
    end
  end
end
