import 'dart:io';

import 'package:http/http.dart';
import '../models/book_case/book_case.dart';

class BooksRepository {
  // TODO: investigue para que es un singleton
  static final BooksRepository _booksRepository = BooksRepository._internal();
  factory BooksRepository() {
    return _booksRepository;
  }

  BooksRepository._internal();

  Future<BookCase> getAvailableBooks(String query) async {
    // https://www.googleapis.com/books/v1/volumes?q=query
    final _uri = Uri(
      scheme: "https",
      host: "www.googleapis.com",
      path: "books/v1/volumes",
      queryParameters: {"q": query},
    );

    try {
      final response = await get(_uri);
      if (response.statusCode == HttpStatus.ok) {
        // TODO: implemente serializacion y sustituya la sig linea
        return BookCase(totalItems: 0);
      } else {
        return BookCase(totalItems: 0);
      }
    } catch (e) {
      // arroje un error
      throw "Ha ocurrido un error: $e";
    }
  }
}
