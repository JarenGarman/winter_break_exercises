# frozen_string_literal: true

# TLD
class Book
  attr_reader :title, :author

  def initialize(book_details)
    @title = book_details[:title]
    @author = [book_details[:author_first_name], book_details[:author_last_name]].join(' ')
  end
end
