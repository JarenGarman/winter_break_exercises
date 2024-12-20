# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Car do
  subject(:car) { described_class.new('Ford Mustang', 1500, 36) }

  describe '#initialize' do
    it { is_expected.to be_an_instance_of(described_class) }

    it 'has a make' do
      expect(car.make).to eq('Ford')
    end

    it 'has a model' do
      expect(car.model).to eq('Mustang')
    end

    it 'has a monthly payment' do
      expect(car.monthly_payment).to eq(1500)
    end

    it 'has a loan length' do
      expect(car.loan_length).to eq(36)
    end

    it 'has a total cost' do
      expect(car.total_cost).to eq(54_000)
    end
  end
end
