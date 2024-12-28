# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Library do
  subject(:library) { described_class.new('Denver Public Library') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(library.name).to eq('Denver Public Library')
    end

    it 'has no books' do
      expect(library.books).to eq([])
    end

    it 'has no authors' do
      expect(library.authors).to eq([])
    end
  end
end
