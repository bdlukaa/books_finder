import 'package:books_finder/src/books_finder_base.dart';
import 'package:test/test.dart';

void main() {
  test('Get books', () async {
    final List<Book> books = await queryBooks(
      'twilight',
      maxResults: 3,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
    );
    expect(books.length, 3);
  });

  test('Get book with special id', () async {
    final Book book = await getSpecificBook('eI0TEAAAQBAJ');
    expect(book.info.title, 'Twilight, Say Cheese!');
    expect(book.info.publisher, 'Simon and Schuster');
    expect(book.info.publishedDate, DateTime(2021, 02, 09));
    expect(book.info.rawPublishedDate, '2021-02-09');
    expect(book.info.authors.length, 1);
    expect(book.info.authors.first, 'Daisy Sunshine');
    expect(book.info.categories.length, 4);
    expect(book.info.categories.first,
        'Juvenile Fiction / Animals / Dragons, Unicorns & Mythical');
    expect(book.info.pageCount, 112);
    expect(book.info.language, 'en');
    expect(book.info.description.isNotEmpty, true);
    expect(book.info.maturityRating, 'NOT_MATURE');
    expect(book.info.contentVersion, 'preview-1.0.0');
    expect(book.info.industryIdentifiers.first.type, 'ISBN_10');
    expect(book.info.industryIdentifiers.first.identifier, '1534461655');
  });

  test('Get magazines', () async {
    final List<Book> magazines = await queryBooks(
      'New York Magazine',
      maxResults: 3,
      printType: PrintType.magazines,
      orderBy: OrderBy.relevance,
    );
    expect(magazines.length, 3);
    expect(magazines.first.info.industryIdentifiers.length, 0);
  });

  test('Get magazine with special id', () async {
    final Book book = await getSpecificBook('OugCAAAAMBAJ');
    expect(book.info.title, 'New York Magazine');
    expect(book.info.publisher, 'New York Media, LLC');
    expect(book.info.publishedDate, DateTime(1997, 06, 02));
    expect(book.info.rawPublishedDate, '1997-06-02');
    expect(book.info.authors.length, 1);
    expect(book.info.authors.first, 'New York Media, LLC');
    expect(book.info.categories.length, 0);
    expect(book.info.pageCount, 142);
    expect(book.info.language, 'en');
    expect(book.info.description.isNotEmpty, true);
    expect(book.info.maturityRating, 'NOT_MATURE');
    expect(book.info.contentVersion, '0.0.2.0.preview.1');
    expect(book.info.industryIdentifiers.length, 1);
    expect(book.info.industryIdentifiers.first.type, 'ISSN');
    expect(book.info.industryIdentifiers.first.identifier, '00287369');
  });

  test('Get toJson', () async {
    final Book book = await getSpecificBook('OugCAAAAMBAJ');
    Map<String, dynamic> json = book.info.toJson();

    expect(json['title'], 'New York Magazine');
    expect(json['publisher'], 'New York Media, LLC');
    expect(json['publishedDate'], DateTime(1997, 06, 02));
    expect(json['rawPublishedDate'], '1997-06-02');
    expect(json['authors'].length, 1);
    expect(json['authors'].first, 'New York Media, LLC');

    // Cast List<T> to List<String>
    List<String> categories = json['categories'];
    expect(json['categories'], []);
    expect(categories.length, 0);

    expect(json['pageCount'], 142);
    expect(json['language'], 'en');
    expect(json['description'].isNotEmpty, true);
    expect(json['maturityRating'], 'NOT_MATURE');
    expect(json['contentVersion'], '0.0.2.0.preview.1');

    List<Map<String, dynamic>> industryIdentifiers =
        json['industryIdentifiers'];
    expect(industryIdentifiers.length, 1);
    expect(industryIdentifiers.first['type'], 'ISSN');
    expect(industryIdentifiers.first['identifier'], '00287369');
  });

  test('Get book with subtitle', () async {
    final Book book = await getSpecificBook('aieWBrFeRtUC');

    expect(book.info.title, 'Prototyping');
    expect(book.info.subtitle, 'A Practitioner\'s Guide');
    expect(book.info.publisher, 'Rosenfeld Media');
    expect(book.info.publishedDate, DateTime(2009));
    expect(book.info.rawPublishedDate, '2009');
    expect(book.info.authors.length, 1);
    expect(book.info.authors.first, 'Todd Zaki Warfel');
    expect(book.info.categories.length, 3);
    expect(book.info.categories.first, 'Computers / User Interfaces');
    expect(book.info.pageCount, 197);
    expect(book.info.language, 'en');
    expect(book.info.description.isNotEmpty, true);
    expect(book.info.maturityRating, 'NOT_MATURE');
    expect(book.info.contentVersion, '0.1.5.0.preview.3');
    expect(book.info.industryIdentifiers.first.type, 'ISBN_10');
    expect(book.info.industryIdentifiers.first.identifier, '1933820217');
  });

  test('Test QueryTypes', () async {
    ///  .intitle
    List<Book> books = await queryBooks(
      'harry potter and the philosopher\'s stone',
      queryType: QueryType.intitle,
      maxResults: 1,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
    );

    expect(books.first.info.title.toLowerCase(),
        "harry potter and the philosopher's stone");

    /// .inauthor
    books = await queryBooks(
      'J. K. Rowling',
      queryType: QueryType.inauthor,
      maxResults: 1,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
    );

    if (books.isNotEmpty && books.first.info.authors.isNotEmpty) {
      expect(books.first.info.authors.first.toLowerCase(), "j. k. rowling");
    }

    /// .inpublisher
    books = await queryBooks(
      'Scholastic inc',
      queryType: QueryType.inauthor,
      maxResults: 1,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
    );

    if (books.isNotEmpty) {
      expect(books.first.info.publisher.toLowerCase(),
          "scholastic early learners");
    }

    /// .isbn
    books = await queryBooks(
      '9781408855959',
      queryType: QueryType.isbn,
      maxResults: 1,
      printType: PrintType.books,
      orderBy: OrderBy.relevance,
    );

    if (books.isNotEmpty) {
      for (IndustryIdentifier id in books.first.info.industryIdentifiers) {
        if (id.type == 'ISBN_13') {
          assert(id.identifier == '9781408855959');
        }
      }
    }
  });
}
