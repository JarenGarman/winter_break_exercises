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
end
