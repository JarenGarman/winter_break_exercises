# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Book do
  subject(:book) do
    described_class.new({
                          author_first_name: 'Harper',
                          author_last_name: 'Lee',
                          title: 'To Kill a Mockingbird',
                          publication_date: 'July 11, 1960'
                        })
  end

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }

    it 'has a title' do
      expect(book.title).to eq('To Kill a Mockingbird')
    end

    it 'has an author' do
      expect(book.author).to eq('Harper Lee')
    end

    it 'has a publication year' do
      expect(book.publication_year).to eq('1960')
    end

    it 'has not been checked out' do
      expect(book.checked_out_amount).to eq(0)
    end
  end

  describe '#checkout' do
    subject(:checkout) { book.checkout }

    it { is_expected.to eq(1) }

    it 'increases checked out amount' do
      book.checkout

      expect(book.checked_out_amount).to eq(1)
    end
  end
end
