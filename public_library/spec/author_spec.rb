# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Author do
  subject(:author) { described_class.new({ first_name: 'Charlotte', last_name: 'Bronte' }) }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a name' do
      expect(author.name).to eq('Charlotte Bronte')
    end

    it 'has no books' do
      expect(author.books).to eq([])
    end
  end
end