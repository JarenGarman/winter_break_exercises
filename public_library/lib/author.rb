# frozen_string_literal: true

require_relative 'book'

# TLD
class Author
  attr_reader :name, :books

  def initialize(author_details)
    @name = [author_details[:first_name], author_details[:last_name]].join(' ')
    @books = []
  end
end
