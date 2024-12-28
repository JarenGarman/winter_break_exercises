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

  describe '#add_author' do
    let(:charlotte_bronte) { Author.new({ first_name: 'Charlotte', last_name: 'Bronte' }) }
    let(:harper_lee) { Author.new({ first_name: 'Harper', last_name: 'Lee' }) }

    before do
      library.add_author(charlotte_bronte)
      library.add_author(harper_lee)
    end

    it 'can add authors' do
      expect(library.authors).to eq([charlotte_bronte, harper_lee])
    end

    it 'can access books' do
      jane_eyre = charlotte_bronte.write('Jane Eyre', 'October 16, 1847')
      professor = charlotte_bronte.write('The Professor', '1857')
      villette = charlotte_bronte.write('Villette', '1853')
      mockingbird = harper_lee.write('To Kill a Mockingbird', 'July 11, 1960')

      expect(library.books).to eq([jane_eyre, professor, villette, mockingbird])
    end
  end
end
