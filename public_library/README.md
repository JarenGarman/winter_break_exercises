# Public Library

## Instructions

* Compete the activity below
* Review your solution with a cohortmate!

## Iteration 1

Use TDD to create a `Book` class that responds to the following interaction pattern. For the `publication_year` method, assume that the year is always the last four characters of the publication date.

```ruby
pry(main)> require './lib/book'
#=> true

pry(main)> book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})
#=> #<Book:0x00007fcc021fad08...>

pry(main)> book.title
#=> "To Kill a Mockingbird"

pry(main)> book.author
#=> "Harper Lee"

pry(main)> book.publication_year
#=> "1960"
```

Use TDD to create an `Author` class that responds to the following interaction pattern.

The `write` method must take two Strings as arguments and return an instance of `Book`.

```ruby
pry(main)> require './lib/book'
#=> true

pry(main)> require './lib/author'
#=> true

pry(main)> charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
#=> #<Author:0x00007fb898081850...>

pry(main)> charlotte_bronte.name
#=> "Charlotte Bronte"

pry(main)> charlotte_bronte.books
#=> []

pry(main)> jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
#=> #<Book:0x00007fb896e22538...>

pry(main)> jane_eyre.class
#=> Book

pry(main)> jane_eyre.title
#=> "Jane Eyre"

pry(main)> villette = charlotte_bronte.write("Villette", "1853")
#=> #<Book:0x00007fb8980aaca0...>

pry(main)> charlotte_bronte.books
#=> [#<Book:0x00007fb896e22538...>, #<Book:0x00007fb8980aaca0...>]
```

## Iteration 2

Use TDD to create a `Library` class that responds to the following interaction pattern.

```ruby
pry(main)> require './lib/library'
#=> true

pry(main)> require './lib/author'
#=> true

pry(main)> dpl = Library.new("Denver Public Library")
#=> #<Library:0x00007fbeea3653c0...>

pry(main)> dpl.name
#=> "Denver Public Library"

pry(main)> dpl.books
#=> []

pry(main)> dpl.authors
#=> []

pry(main)> charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
#=> #<Author:0x00007fbeea2d78b8...>

pry(main)> jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")    
#=> #<Book:0x00007fbeeb3beca8...>

pry(main)> professor = charlotte_bronte.write("The Professor", "1857")
#=> #<Book:0x00007fbeea8efd90...>

pry(main)> villette = charlotte_bronte.write("Villette", "1853")
#=> #<Book:0x00007fbeea24fbe8...>

pry(main)> harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
#=> #<Author:0x00007fbeea112730...>

pry(main)> mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
#=> #<Book:0x00007fbeeb1089f0...>

pry(main)> dpl.add_author(charlotte_bronte)

pry(main)> dpl.add_author(harper_lee)

pry(main)> dpl.authors
=> [#<Author:0x00007fbeea2d78b8...>, #<Author:0x00007fbeea112730...>]

pry(main)> dpl.books
=> [#<Book:0x00007fbeeb3beca8...>, #<Book:0x00007fbeea8efd90...>, #<Book:0x00007fbeea24fbe8...>, #<Book:0x00007fbeeb1089f0...>]
```

## Iteration 3

Use TDD to implement the following methods on the `Library` class:

| Method Name              | Return Value        |
|--------------------      |-------------------- |
| publication_time_frame(author)   | Takes an `Author` object as an argument and returns a hash with two key/value pairs: `:start` which points to the publication year of the `Author`'s first book (string). `:end` which points to the publication year of the `Author`'s last book (string). `Example: {:start=>"1847", :end=>"1857"}` |
| checkout(book)           | Takes a `Book` as an argument. It should return `false` if a `Book` does not exist in the library or it is already checked out. Otherwise, it should return true indicating that the book has been checked out. |
| checked_out_books        | Return an array of `Book` objects that are currently checked out. |
| return(book)             | Takes a `Book` as an argument. Calling this method means that a book is no longer checked out. |

## Iteration 4

Use TDD to implement these methods to your Library class.

| Method Name              | Return Value        |
|--------------------      |-------------------- |
| most_popular_book        | Return the `Book` object that has been checked out the most. |
| inventory                | Returns a Hash where the keys are the `Author` objects and the value is an array that holds each author's `Book` objects. `Example: {charlotte_bronte(Author object) => [jane_eyre, professor, villette](Book objects)}` |
