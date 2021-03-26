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
    expect(book.info.authors[0], 'Daisy Sunshine');
    expect(book.info.categories.length, 4);
    expect(book.info.categories[0],
        'Juvenile Fiction / Animals / Dragons, Unicorns & Mythical');
    expect(book.info.pageCount, 112);
    expect(book.info.language, 'en');
    expect(book.info.description.isNotEmpty, true);
    expect(book.info.maturityRating, 'NOT_MATURE');
    expect(book.info.contentVersion, 'preview-1.0.0');
    expect(book.info.industryIdentifier[0].type, 'ISBN_10');
    expect(book.info.industryIdentifier[0].identifier, '1534461655');
  });

  test('Get magazines', () async {
    final List<Book> magazines = await queryBooks(
      'New York Magazine',
      maxResults: 3,
      printType: PrintType.magazines,
      orderBy: OrderBy.relevance,
    );
    expect(magazines.length, 3);
    expect(magazines[0].info.industryIdentifier.length, 0);
  });

  test('Get magazine with special id', () async {
    final Book book = await getSpecificBook('OugCAAAAMBAJ');
    expect(book.info.title, 'New York Magazine');
    expect(book.info.publisher, 'New York Media, LLC');
    expect(book.info.publishedDate, DateTime(1997, 06, 02));
    expect(book.info.rawPublishedDate, '1997-06-02');
    expect(book.info.authors.length, 1);
    expect(book.info.authors[0], 'New York Media, LLC');
    expect(book.info.categories.length, 0);
    expect(book.info.pageCount, 142);
    expect(book.info.language, 'en');
    expect(book.info.description.isNotEmpty, true);
    expect(book.info.maturityRating, 'NOT_MATURE');
    expect(book.info.contentVersion, '0.0.2.0.preview.1');
    expect(book.info.industryIdentifier.length, 1);
    expect(book.info.industryIdentifier[0].type, 'ISSN');
    expect(book.info.industryIdentifier[0].identifier, '00287369');
  });
}
