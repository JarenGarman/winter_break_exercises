# frozen_string_literal: true

# TLD
class Library
  attr_reader :name, :authors, :checked_out_books

  def initialize(name)
    @name = name
    @authors = []
    @checked_out_books = []
  end

  def books
    @authors.map(&:books).flatten
  end

  def add_author(author)
    @authors << author
  end

  def publication_time_frame(author)
    years = author.books.map(&:publication_year).sort
    { start: years[0], end: years[-1] }
  end

  def checkout(book)
    return unless books.include?(book) && !checked_out_books.include?(book)

    @checked_out_books << book
    book.checkout
    book
  end

  def return(book)
    return unless checked_out_books.include?(book)

    @checked_out_books.delete(book)
  end

  def inventory
    inventory = {}
    @authors.each { |author| inventory[author] = author.books }
    inventory
  end
end
