//  Copyright 2020 Bruno D'Luka

import 'package:books_finder/books_finder.dart';

void main(List<String> args) async {
  final books = await queryBooks(
    'twilight',
    maxResults: 3,
    printType: PrintType.books,
    orderBy: OrderBy.relevance,
  );
  books.forEach((book) {
    final info = book.info;
    print('$info\n');
  });
}
