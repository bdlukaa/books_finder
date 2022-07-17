//  Copyright 2020 Bruno D'Luka

import 'dart:convert';

import 'scripts/books.dart';
import 'package:http/http.dart' as http;

export 'scripts/books.dart';

/// Query a list of books
///
/// `query` parameter must not be null and must not be empty.
/// Spaces characters are allowed
///
/// Set `queryType` to specify the search by a specific keyword
///
/// Set `langRestrict` to restrict the query to a
/// specific language
///
/// Set `orderBy` to order the query by newest or relevance
/// and `printType` to filter in books or magazines
///
/// Set `maxResults` to set the max amount of results.
/// Set `startIndex` for pagination
///
/// Example of querying:
/// ```
/// void main(List<String> args) async {
///   final books = await queryBooks(
///     'twilight',
///     maxResults: 3,
///     printType: PrintType.books,
///     orderBy: OrderBy.relevance,
///   );
///   books.forEach((Book book) {
///     print(book);
///   });
/// }
/// ```
///
Future<List<Book>> queryBooks(
  String query, {
  QueryType? queryType,
  String? langRestrict,
  int maxResults = 10,
  OrderBy? orderBy,
  PrintType? printType = PrintType.all,
  int startIndex = 0,
  bool reschemeImageLinks = false,
}) async {
  assert(query.isNotEmpty);

  // assert(startIndex <= maxResults);

  var url = 'https://www.googleapis.com/books/v1/volumes?q=';

  if (queryType != null) url += queryType.name + ':';

  var q = '$url'
      '${query.trim().replaceAll(' ', '+')}'
      '&maxResults=$maxResults'
      '&startIndex=$startIndex';

  if (langRestrict != null) q += '&langRestrict=$langRestrict';
  if (orderBy != null) {
    q += '&orderBy=${orderBy.toString().replaceAll('OrderBy.', '')}';
  }
  if (printType != null) {
    q += '&printType=${printType.toString().replaceAll('PrintType.', '')}';
  }
  final result = await http.get(Uri.parse(q));
  if (result.statusCode == 200) {
    final books = <Book>[];
    final list = (jsonDecode(result.body))['items'] as List<dynamic>?;
    if (list == null) return [];
    for (final e in list) {
      books.add(Book.fromJson(e, reschemeImageLinks: reschemeImageLinks));
    }
    return books;
  } else {
    throw (result.body);
  }
}

/// Special keywords you can specify in the search terms to search by particular fields
enum QueryType {
  /// Returns results where the text following this keyword is found in the title.
  intitle,

  /// Returns results where the text following this keyword is found in the author.
  inauthor,

  /// Returns results where the text following this keyword is found in the publisher.
  inpublisher,

  /// Returns results where the text following this keyword is listed in the category list of the volume.
  subject,

  /// Returns results where the text following this keyword is the ISBN number.
  isbn,

  /// Returns results where the text following this keyword is the Library of Congress Control Number.
  lccn,

  /// Returns results where the text following this keyword is the Online Computer Library Center number.
  oclc,
}

/// Order the query by `newest` or `relevance`
enum OrderBy {
  /// Returns search results in order of the newest published date
  /// to the oldest.
  newest,

  /// Returns search results in order of the most relevant to least
  /// (this is the default).
  relevance,
}

enum PrintType {
  /// Return all volume content types (no restriction). This is the default.
  all,

  /// Return only books.
  books,

  /// Return only magazines.
  magazines,
}

/// Get an specific book with its `id`.
/// You can not add specific parameters to this.
Future<Book> getSpecificBook(
  String id, {
  bool reschemeImageLinks = false,
}) async {
  assert(id.isNotEmpty, 'You must provide a valid id');
  final q = 'https://www.googleapis.com/books/v1/volumes/${id.trim()}';
  final result = await http.get(Uri.parse(q));
  if (result.statusCode == 200) {
    return Book.fromJson(
      jsonDecode(result.body) as Map<String, dynamic>,
      reschemeImageLinks: reschemeImageLinks,
    );
  } else {
    throw (result.body);
  }
}
