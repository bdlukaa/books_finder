A library to help on the search for books on [google books api](https://developers.google.com/books/docs/v1/using).

# Querying books

First of all, import the library:
``` dart
import 'package:books_finder/books_finder.dart';
```

To query a book, just call the function `queryBooks`:

``` dart
final books = await queryBooks(
 'twilight',
 maxResults: 3,
 printType: PrintType.books,
 orderBy: OrderBy.relevance,
);
```

You can change a few parameters to make your query more specific:

1. Set `langRestrict` to restrict the query to a
specific language
2. Set `orderBy` to order the query by newest or relevance
and `printType` to filter in books or magazines
3. Set `maxResults` to set the max amount of results.
4. Set `startIndex` for pagination

# Specific books
First of all, to get a specific book, you need its id. You can get the book id by querying the name of it and calling `book.id`.

Next step is to get the book. To get it, just call the function `getSpecificBook`. For example:

``` dart
final specificBook = await getSpecificBook(book.id);
```

But if you already have a `book` object, you can just call:
``` dart
final completeInfo = await book.completeInfoBook;
```

# Books
If you already have a `Book` object, you can call `book.info` to get all the book infos.

- title: returns a `String` with the title of the book
- authors: returns a `list of strings` with all the authors names
- publisher: returns a `String` with the publisher name
- publishedDate: returns a `DateTime` with the published date
- description: returns a `String` with the description of the book
- pageCount: returns a `int` with the amount of pages the book has
- categories: returns a `list of strings` with the categories the book is in
- averageRating: returns a `double` with the average rating of the book
- ratingsCount: returns a `int` with the amount of people that rated the book
- maturityRating: returns a `String` with the maturity rating of the book
- contentVersion: returns a `String` with the content version
- imageLinks: returns a `List<Map<String, Uri>>` with all the avaiable image resources urls
- language: returns a `String` with the language code of the book

### Open source
This project is open source and is under BSD LICENCE. Feel free to [open an issue](https://github.com/bdlukaa/books_finder/issues) or [make a pull request](https://github.com/bdlukaa/books_finder/pulls) to the project.