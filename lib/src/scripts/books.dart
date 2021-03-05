//  Copyright 2020 Bruno D'Luka
import 'extensions.dart';

class Book {
  /// The id of the book
  final String id;
  final String? etag;

  /// A self link containing more especific information
  final Uri? selfLink;

  /// The informations about the book
  final BookInfo info;

  const Book({
    required this.id,
    this.etag,
    required this.info,
    this.selfLink,
  });

  @override
  String toString() => '$id:${info.title}';

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
  final String title;

  /// A list with the name of all the authors of the book
  final List<String> authors;

  /// The publisher name
  final String publisher;

  /// The date the book was published
  final DateTime publishedDate;

  /// The description of the book
  final String description;

  /// The amount of pages the book has
  final int pageCount;

  /// The categories the book is in
  final List<String> categories;

  /// The average rating
  final double averageRating;

  /// How many people rated the book
  final int ratingsCount;

  /// Wether the book is mature or not
  final String maturityRating;

  /// The content version
  final String contentVersion;

  /// Some image links
  final Map<String, Uri> imageLinks;

  /// The original language of the book
  final String language;

  const BookInfo({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.averageRating,
    required this.categories,
    required this.contentVersion,
    required this.description,
    required this.imageLinks,
    required this.language,
    required this.maturityRating,
    required this.pageCount,
    required this.publishedDate,
    required this.ratingsCount,
  });

  static BookInfo fromJson(Map<String, dynamic> json) {
    final publisherDateArray =
        ((json['publisherDate'] as String?) ?? '0000-00-00').split('-');
    final year = int.parse(publisherDateArray[0]);
    final month = int.parse(publisherDateArray[1]);
    final day = int.parse(publisherDateArray[2]);
    final publisherDate = DateTime(year, month, day);

    final imageLinks = <String, Uri>{};
    final map = json['imageLinks'] as Map<String, dynamic>?;
    map?.forEach((key, value) {
      imageLinks.addAll({key: Uri.parse(value.toString())});
    });

    return BookInfo(
      title: json['title'],
      authors: ((json['authors'] as List<dynamic>?) ?? []).toStringList(),
      publisher: json['publisher'],
      averageRating: ((json['averageRating'] ?? 0) as num).toDouble(),
      categories: ((json['categories'] as List<dynamic>?) ?? []).toStringList(),
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

  @override
  String toString() {
    return '''
    title: $title
    authors: $authors
    publisher: $publisher
    publishedDate: $publishedDate
    averageRating: $averageRating
    categories: $categories
    contentVersion $contentVersion
    description: $description
    language: $language
    maturityRating: $maturityRating
    pageCount: $pageCount
    ratingsCount: $ratingsCount
    imageLinks: $imageLinks''';
  }
}
