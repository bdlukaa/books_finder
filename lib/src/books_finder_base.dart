// 
//  Copyright 2020 Bruno D'Luka
//  
//  Redistribution and use in source and binary forms, with or without modification, 
//  are permitted provided that the following conditions are met:
//  
//  1. Redistributions of source code must retain the above copyright notice, 
//  this list of conditions and the following disclaimer.
//  
//  2. Redistributions in binary form must reproduce the above copyright notice, 
//  this list of conditions and the following disclaimer in the documentation and/or 
//  other materials provided with the distribution.
//  
//  3. Neither the name of the copyright holder nor the names of its contributors 
//  may be used to endorse or promote products derived from this software without 
//  specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, 
//  OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
//  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// 

import 'dart:convert';

import 'scripts/books.dart';
import 'package:http/http.dart' as http;

export 'scripts/books.dart';

/// Query a list of books
///
/// `query` parameter must not be null and must not be empty.
/// Spaces characters are allowed
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
  String langRestrict,
  int maxResults = 10,
  OrderBy orderBy,
  PrintType printType = PrintType.all,
  int startIndex = 0,
}) async {
  assert(query != null);
  assert(query.isNotEmpty);

  maxResults ??= 10;
  assert(maxResults != 0);
  assert(maxResults > 0);
  assert(maxResults <= 40);

  startIndex ??= 0;
  assert(startIndex >= 0);
  assert(!startIndex.isNegative);
  assert(startIndex <= maxResults);

  // ignore: prefer_adjacent_string_concatenation
  var q = 'https://www.googleapis.com/books/v1/volumes?q=' +
      '${query.trim().replaceAll(' ', '+')}' +
      '&maxResults=$maxResults';

  if (langRestrict != null) q += '&langRestrict=$langRestrict';
  if (orderBy != null)
    // ignore: curly_braces_in_flow_control_structures
    q += '&orderBy=${orderBy.toString().replaceAll('OrderBy.', '')}';
  if (printType != null)
    // ignore: curly_braces_in_flow_control_structures
    q += '&printType=${printType.toString().replaceAll('PrintType.', '')}';

  final result = await http.get(q);
  if (result.statusCode == 200) {
    final books = <Book>[];
    final list = (jsonDecode(result.body))['items'] as List<dynamic>;
    if (list == null) return [];
    list.forEach((e) {
      books.add(Book.fromJson(e));
    });
    return books;
  } else {
    throw (result.body);
  }
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

  /// Return just books.
  books,

  /// Return just magazines.
  magazines,
}

/// Get an specific book with and book `id`.
/// You can not add specific parameters to this.
/// 
/// Set `id` as the id of the book you want. You can get the books and its ids
/// by querying:
/// 
/// ```
/// void main(List<String> args) async {
///   final books = await queryBooks(
///     'twilight',
///     maxResults: 3,
///     printType: PrintType.books,
///     orderBy: OrderBy.relevance,
///   );
///   books.forEach((Book book) {
///     final bookId = book.id;
///     print(bookId);
///   });
/// }
/// ```
Future<Book> getSpecificBook(String id) async {
  assert(id != null);
  assert(id.isNotEmpty);

  var q = 'https://www.googleapis.com/books/v1/volumes/${id.trim()}';

  final result = await http.get(q);
  if (result.statusCode == 200) {
    return Book.fromJson(jsonDecode(result.body) as Map<String, dynamic>);
  } else {
    throw (result.body);
  }
}
