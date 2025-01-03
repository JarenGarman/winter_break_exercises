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

  describe '#write' do
    subject(:write) { author.write('Jane Eyre', 'October 16, 1847') }

    it { is_expected.to be_instance_of Book }

    it 'has a title' do
      expect(write.title).to eq('Jane Eyre')
    end

    it 'has a publication year' do
      expect(write.publication_year).to eq('1847')
    end

    it 'has an author' do
      expect(write.author).to eq('Charlotte Bronte')
    end

    it 'can write multiple books' do
      villette = author.write('Villette', '1853')

      expect(author.books).to eq([villette, write])
    end
  end
end
