# frozen_string_literal: true

# TLD
class Book
  attr_reader :title, :author, :publication_year, :checked_out_amount

  def initialize(book_details)
    @title = book_details[:title]
    @author = [book_details[:author_first_name], book_details[:author_last_name]].join(' ')
    @publication_year = book_details[:publication_date][-4..]
    @checked_out_amount = 0
  end

  def checkout
    @checked_out_amount += 1
  end
end
