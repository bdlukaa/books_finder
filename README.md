<div>
  <h1 align="center">books_finder</h1>
  <p align="center" >
    <a title="Discord" href="https://discord.gg/674gpDQUVq">
      <img src="https://img.shields.io/discord/809528329337962516?label=discord&logo=discord" />
    </a>
    <a title="Pub" href="https://pub.dartlang.org/packages/books_finder" >
      <img src="https://img.shields.io/pub/v/books_finder.svg?style=popout&include_prereleases" />
    </a>
    <a title="Github License">
      <img src="https://img.shields.io/github/license/bdlukaa/books_finder" />
    </a>
    <a title="PRs are welcome">
      <img src="https://img.shields.io/badge/PRs-welcome-brightgreen.svg" />
    </a>
  <div>
  <p align="center">
    <a title="Buy me a coffee" href="https://www.buymeacoffee.com/bdlukaa">
      <img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=bdlukaa&button_colour=FF5F5F&font_colour=ffffff&font_family=Lato&outline_colour=000000&coffee_colour=FFDD00">
    </a>
  </p>
</div>

A library to help on the search for books on the [Google Books Api](https://developers.google.com/books/docs/v1/using).

## Usage

First of all, import the library:

```dart
import 'package:books_finder/books_finder.dart';
```

### Querying books

To query books, just call the function `queryBooks`:

```dart
final List<Book> books = await queryBooks(
 'twilight',
 maxResults: 3,
 printType: PrintType.books,
 orderBy: OrderBy.relevance,
);
```

You can change a few parameters to make your query more specific:

| Parameter    | Description                              | Nullable |
| ------------ | ---------------------------------------- | -------- |
| maxResults   | Set the max amount of results            | No       |
| startIndex   | for pagination                           | No       |
| langRestrict | Retrict the query to a specific language | Yes      |
| orderBy      | Order the query by newest or relevance   | Yes      |
| printType    | Filter by books, magazines or both       | Yes      |

### Books

If you already have a `Book` object, you can call `book.info` to get all the book infos:

```dart
final info = book.info;
```

| Parameter                             | Description                                 |
| ------------------------------------- | ------------------------------------------- |
| title (`String`)                      | Title of the book                           |
| authors (`List<String>`)              | All the authors names                       |
| publisher (`String`)                  | The publisher name                          |
| publishedDate (`DateTime`)            | The date it was published                   |
| description (`String`)                | Description of the book                     |
| pageCount (`int`)                     | The amount of pages                         |
| categories (`List<String>`)           | The categories the book is in               |
| averageRating (`double`)              | The average rating of the book              |
| ratingsCount (`int`)                  | The amount of people that rated it          |
| maturityRating (`String`)             | The maturity rating                         |
| contentVersion (`String`)             | The version of the content                  |
| imageLinks (`List<Map<String, Uri>>`) | The links with the avaiable image resources |
| language (`String`)                   | The language code of the book               |

## Issues and feedback

Please file issues, bugs, or feature requests in our [issue tracker](https://github.com/bdlukaa/books_finder/issues/new).

To contribute a change to this plugin open a [pull request](https://github.com/bdlukaa/books_finder/pulls).
