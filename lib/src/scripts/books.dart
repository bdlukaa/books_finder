//  Copyright 2020 Bruno D'Luka

import 'extensions.dart';

class Book {
  /// The id of the book
  final String id;
  final String? etag;

  /// A self link containing more especific information
  final Uri? selfLink;

  /// The information about the book
  final BookInfo info;

  /// The information about the book's sale info
  final SaleInfo saleInfo;

  const Book({
    required this.id,
    this.etag,
    required this.info,
    this.selfLink,
    required this.saleInfo,
  });

  @override
  String toString() => '$id:${info.title}';

  static Book fromJson(
    Map<String, dynamic> json, {
    bool reschemeImageLinks = false,
  }) {
    return Book(
      id: json['id'],
      etag: json['etag'],
      info: BookInfo.fromJson(
        json['volumeInfo'],
        reschemeImageLinks: reschemeImageLinks,
      ),
      selfLink: Uri.parse(json['selfLink']),
      saleInfo: SaleInfo.fromJson(json['saleInfo']),
    );
  }
}

class IndustryIdentifier {
  final String type;
  final String identifier;

  const IndustryIdentifier({
    required this.type,
    required this.identifier,
  });

  static IndustryIdentifier fromJson(Map<String, dynamic> json) {
    return IndustryIdentifier(
      type: json['type'] ?? '',
      identifier: json['identifier'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'identifier': identifier,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IndustryIdentifier &&
        other.type == type &&
        other.identifier == identifier;
  }

  @override
  int get hashCode => type.hashCode ^ identifier.hashCode;

  @override
  String toString() => '$type:$identifier';
}

class SaleInfo {
  final String country;
  final String saleability;
  final bool isEbook;

  const SaleInfo({
    required this.country,
    required this.saleability,
    required this.isEbook,
  });

  @override
  String toString() =>
      'SaleInfo(country: $country, saleability: $saleability, isEbook: $isEbook)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SaleInfo &&
        other.country == country &&
        other.saleability == saleability &&
        other.isEbook == isEbook;
  }

  @override
  int get hashCode =>
      country.hashCode ^ saleability.hashCode ^ isEbook.hashCode;

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'saleability': saleability,
      'isEbook': isEbook,
    };
  }

  factory SaleInfo.fromJson(Map<String, dynamic> map) {
    return SaleInfo(
      country: map['country'] ?? '',
      saleability: map['saleability'] ?? '',
      isEbook: map['isEbook'] ?? false,
    );
  }
}

class BookInfo {
  /// The book title
  final String title;

  /// The book subtitle
  final String subtitle;

  /// A list with the name of all the authors of the book
  final List<String> authors;

  /// The publisher name
  final String publisher;

  /// The date the book was published
  final DateTime? publishedDate;

  /// The date the book was published in raw string format
  final String rawPublishedDate;

  /// The description of the book
  final String description;

  /// The industryIdentifiers of the book (ISBN)
  final List<IndustryIdentifier> industryIdentifiers;

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

  /// The volume preview link
  final Uri previewLink;

  /// The volume info link
  final Uri infoLink;

  /// The canonical volume link
  final Uri canonicalVolumeLink;

  const BookInfo({
    required this.title,
    required this.subtitle,
    required this.authors,
    required this.publisher,
    required this.averageRating,
    required this.categories,
    required this.contentVersion,
    required this.description,
    required this.industryIdentifiers,
    required this.imageLinks,
    required this.language,
    required this.maturityRating,
    required this.pageCount,
    required this.publishedDate,
    required this.rawPublishedDate,
    required this.ratingsCount,
    required this.previewLink,
    required this.infoLink,
    required this.canonicalVolumeLink,
  });

  static BookInfo fromJson(
    Map<String, dynamic> json, {
    bool reschemeImageLinks = false,
  }) {
    final publishedDateArray =
        ((json['publishedDate'] as String?) ?? '0000-00-00').split('-');

    // initialize datetime variable
    DateTime? publishedDate;
    if (publishedDateArray.isNotEmpty) {
      // initialize date
      int year = int.parse(publishedDateArray[0]);
      int month = 1;
      int day = 1;

      // now test the date string
      if (publishedDateArray.length == 1) {
        // assume we have only the year
        year = int.parse(publishedDateArray[0]);
      }
      if (publishedDateArray.length == 2) {
        // assume we have the year and maybe the month (this could be just a speculative case)
        year = int.parse(publishedDateArray[0]);
        month = int.parse(publishedDateArray[1]);
      }
      if (publishedDateArray.length == 3) {
        // assume we have year-month-day
        year = int.parse(publishedDateArray[0]);
        month = int.parse(publishedDateArray[1]);
        day = int.parse(publishedDateArray[2]);
      }
      publishedDate = DateTime(year, month, day);
    }

    final imageLinks = <String, Uri>{};
    (json['imageLinks'] as Map<String, dynamic>?)?.forEach((key, value) {
      Uri uri = Uri.parse(value.toString());
      if (reschemeImageLinks) {
        if (uri.isScheme('HTTP')) {
          uri = Uri.parse(value.toString().replaceAll('http://', 'https://'));
        }
      }
      imageLinks.addAll({key: uri});
    });

    return BookInfo(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      authors: ((json['authors'] as List<dynamic>?) ?? []).toStringList(),
      publisher: json['publisher'] ?? '',
      averageRating: ((json['averageRating'] ?? 0) as num).toDouble(),
      categories: ((json['categories'] as List<dynamic>?) ?? []).toStringList(),
      contentVersion: json['contentVersion'] ?? '',
      description: json['description'] ?? '',
      language: json['language'] ?? '',
      maturityRating: json['maturityRating'] ?? '',
      pageCount: json['pageCount'] ?? 0,
      ratingsCount: json['ratingsCount'] ?? 0,
      publishedDate: publishedDate,
      rawPublishedDate: (json['publishedDate'] as String?) ?? '',
      imageLinks: imageLinks,
      industryIdentifiers: ((json['industryIdentifiers'] ?? []) as List)
          .map((i) => IndustryIdentifier.fromJson(i))
          .toList(),
      previewLink: Uri.parse(json['previewLink']),
      infoLink: Uri.parse(json['infoLink']),
      canonicalVolumeLink: Uri.parse(json['canonicalVolumeLink']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'publisher': publisher,
      'publishedDate': publishedDate,
      'rawPublishedDate': rawPublishedDate,
      'averageRating': averageRating,
      'categories': categories,
      'contentVersion': contentVersion,
      'description': description,
      'language': language,
      'maturityRating': maturityRating,
      'pageCount': pageCount,
      'ratingsCount': ratingsCount,
      'imageLinks': imageLinks,
      'industryIdentifiers':
          industryIdentifiers.map((identifier) => identifier.toJson()).toList(),
      'previewLink': previewLink,
      'infoLink': infoLink,
      'canonicalVolumeLink': canonicalVolumeLink,
    };
  }

  @override
  String toString() {
    return 'BookInfo(title: $title, subtitle: $subtitle authors: $authors, publisher: $publisher, publishedDate: $publishedDate, rawPublishedDate: $rawPublishedDate, description: $description, industryIdentifiers: $industryIdentifiers, pageCount: $pageCount, categories: $categories, averageRating: $averageRating, ratingsCount: $ratingsCount, maturityRating: $maturityRating, contentVersion: $contentVersion, imageLinks: $imageLinks, language: $language, previewLink: $previewLink, infoLink: $infoLink, canonicalVolumeLink: $canonicalVolumeLink)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookInfo &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.authors == authors &&
        other.publisher == publisher &&
        other.publishedDate == publishedDate &&
        other.rawPublishedDate == rawPublishedDate &&
        other.description == description &&
        other.industryIdentifiers == industryIdentifiers &&
        other.pageCount == pageCount &&
        other.categories == categories &&
        other.averageRating == averageRating &&
        other.ratingsCount == ratingsCount &&
        other.maturityRating == maturityRating &&
        other.contentVersion == contentVersion &&
        other.imageLinks == imageLinks &&
        other.language == language &&
        other.previewLink == previewLink &&
        other.infoLink == infoLink &&
        other.canonicalVolumeLink == canonicalVolumeLink;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        subtitle.hashCode ^
        authors.hashCode ^
        publisher.hashCode ^
        publishedDate.hashCode ^
        rawPublishedDate.hashCode ^
        description.hashCode ^
        industryIdentifiers.hashCode ^
        pageCount.hashCode ^
        categories.hashCode ^
        averageRating.hashCode ^
        ratingsCount.hashCode ^
        maturityRating.hashCode ^
        contentVersion.hashCode ^
        imageLinks.hashCode ^
        language.hashCode ^
        previewLink.hashCode ^
        infoLink.hashCode ^
        canonicalVolumeLink.hashCode;
  }
}
