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

import '../books_finder_base.dart';
import 'extensions.dart';

class Book {
  /// The id of the book
  String id;
  String etag;

  /// A self link containing more especific information
  Uri selfLink;

  /// The informations about the book
  BookInfo info;

  Book({
    this.id,
    this.etag,
    this.info,
    this.selfLink,
  })  : assert(id != null),
        assert(info != null);

  @override
  String toString() => '$id:${info.title}';

  Future<Book> get completeInfoBook async {
    return await getSpecificBook(id);
  }

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      etag: json['etag'],
      info: BookInfo.fromJson(json['volumeInfo']),
      selfLink: Uri.parse(json['selfLink']),
    );
  }
}

class BookInfo {
  /// The book title
  String title;

  /// A list with the name of all the authors of the book
  List<String> authors;

  /// The publisher name
  String publisher;

  /// The date the book was published
  DateTime publishedDate;

  /// The description of the book
  String description;

  /// The amount of pages the book has
  int pageCount;

  /// The categories the book is in
  List<String> categories;

  /// The average rating
  double averageRating;

  /// How many people rated the book
  int ratingsCount;

  /// Wether the book is mature or not
  String maturityRating;

  /// The content version
  String contentVersion;

  /// Some image links
  List<Map<String, Uri>> imageLinks;

  /// The original language of the book
  String language;

  BookInfo({
    this.title,
    this.authors,
    this.publisher,
    this.averageRating,
    this.categories,
    this.contentVersion,
    this.description,
    this.imageLinks,
    this.language,
    this.maturityRating,
    this.pageCount,
    this.publishedDate,
    this.ratingsCount,
  });

  static BookInfo fromJson(Map<String, dynamic> json) {
    final publisherDateArray =
        (json['publisherDate'] as String ?? '0000-00-00').split('-');
    final year = int.parse(publisherDateArray[0]);
    final month = int.parse(publisherDateArray[1]);
    final day = int.parse(publisherDateArray[2]);
    final publisherDate = DateTime(year, month, day);

    final imageLinks = <Map<String, Uri>>[];
    final map = json['imageLinks'] as Map<String, dynamic>;
    map?.forEach((key, value) {
      imageLinks.add({key: Uri.parse(value.toString())});
    });

    return BookInfo(
      title: json['title'],
      // ignore: unnecessary_cast
      authors: ((json['authors'] as List<dynamic>) ?? []).toStringList(),
      publisher: json['publisher'],
      // ignore: unnecessary_cast
      averageRating: (json['averageRating'] ?? 0 as num).toDouble(),
      // ignore: unnecessary_cast
      categories: ((json['categories'] as List<dynamic>) ?? []).toStringList(),
      contentVersion: json['contentVersion'],
      description: json['description'],
      language: json['language'],
      maturityRating: json['maturityRating'],
      pageCount: json['pageCount'] ?? 0,
      ratingsCount: json['ratingsCount'] ?? 0,
      publishedDate: publisherDate,
      imageLinks: imageLinks,
    );
  }
}
