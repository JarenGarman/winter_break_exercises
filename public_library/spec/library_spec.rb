# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Library do
  subject(:library) { described_class.new('Denver Public Library') }

  let(:charlotte_bronte) { Author.new({ first_name: 'Charlotte', last_name: 'Bronte' }) }
  let(:harper_lee) { Author.new({ first_name: 'Harper', last_name: 'Lee' }) }
  let(:jane_eyre) { charlotte_bronte.write('Jane Eyre', 'October 16, 1847') }

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

    it 'has no checked out books' do
      expect(library.checked_out_books).to eq([])
    end
  end

  describe '#add_author' do
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

  describe '#publication_time_frame' do
    subject(:time_frame) { library.publication_time_frame(charlotte_bronte) }

    before do
      charlotte_bronte.write('Jane Eyre', 'October 16, 1847')
      charlotte_bronte.write('The Professor', '1857')
      charlotte_bronte.write('Villette', '1853')
    end

    it { is_expected.to eq({ start: '1847', end: '1857' }) }
  end

  describe '#checkout' do
    subject(:checkout) { library.checkout(jane_eyre) }

    context 'when the book does not exist in the library' do
      it { is_expected.to be_nil }
    end

    context 'when the book does exist in the library' do
      before do
        library.add_author(charlotte_bronte)
      end

      context 'when the book is checked out' do
        before do
          library.checkout(jane_eyre)
        end

        it { is_expected.to be_nil }
      end

      context 'when the book is not checked out' do
        it { is_expected.to eq(jane_eyre) }

        it 'can check out book' do
          library.checkout(jane_eyre)

          expect(library.checked_out_books).to eq([jane_eyre])
        end

        it 'can increase books checked out amount' do
          library.checkout(jane_eyre)

          expect(jane_eyre.checked_out_amount).to eq(1)
        end
      end
    end
  end

  describe '#return' do
    subject(:return_book) { library.return(jane_eyre) }

    context 'when the book is not checked out' do
      it { is_expected.to be_nil }
    end

    context 'when the book is checked out' do
      before do
        library.add_author(charlotte_bronte)
        library.checkout(jane_eyre)
      end

      it { is_expected.to eq(jane_eyre) }

      it 'removes book from checked_out_books' do
        library.return(jane_eyre)

        expect(library.checked_out_books).to eq([])
      end
    end
  end

  describe '#inventory' do
    subject(:inventory) { library.inventory }

    before do
      library.add_author(charlotte_bronte)
      library.add_author(harper_lee)
    end

    it 'returns correct hash' do
      jane_eyre = charlotte_bronte.write('Jane Eyre', 'October 16, 1847')
      professor = charlotte_bronte.write('The Professor', '1857')
      villette = charlotte_bronte.write('Villette', '1853')
      mockingbird = harper_lee.write('To Kill a Mockingbird', 'July 11, 1960')

      expect(inventory).to eq({ charlotte_bronte => [jane_eyre, professor, villette], harper_lee => [mockingbird] })
    end
  end

  describe '#most_popular_book' do
    subject(:popular) { library.most_popular_book }

    before do
      library.add_author(charlotte_bronte)
    end

    it 'can identify most popular book' do
      jane_eyre = charlotte_bronte.write('Jane Eyre', 'October 16, 1847')
      charlotte_bronte.write('The Professor', '1857')

      library.checkout(jane_eyre)

      expect(popular).to eq(jane_eyre)
    end
  end
end
