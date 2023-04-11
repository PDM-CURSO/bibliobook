import 'dart:math';

import 'package:bibliobook/models/book_case/book.dart';
import 'package:flutter/foundation.dart';

import '../repositories/books_repository.dart';

class SearchProvider with ChangeNotifier {
  BooksRepository _bookRepo = BooksRepository();
  List<Book> bookList = [];
  bool isLoading = false;
  bool isError = false;
  Future<void> fetchBooks({String query = ""}) async {
    try {
      // TODO: hacer request, como le hacemos?
    } catch (e) {
      // TODO: Error, que hacemos?
    }
  }

  String _getRandomTopic() {
    List _topics = ["iteso", "nature", "animals", "food", "health", "money"];
    return _topics[(Random().nextInt(_topics.length))];
  }
}
