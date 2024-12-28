# frozen_string_literal: true

require_relative 'book'

# TLD
class Author
  attr_reader :name, :books

  def initialize(author_details)
    @name = [author_details[:first_name], author_details[:last_name]].join(' ')
    @books = []
  end

  def write(title, publication_date)
    Book.new({
               author_first_name: @name.split[0],
               author_last_name: @name.split[1],
               title: title,
               publication_date: publication_date
             })
  end
end
