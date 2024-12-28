# frozen_string_literal: true

# TLD
class Library
  attr_reader :name, :authors

  def initialize(name)
    @name = name
    @authors = []
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
end
