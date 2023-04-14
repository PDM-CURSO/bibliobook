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
      isLoading = true;
      notifyListeners();
      // si no le pasamos datos que tome un tema random
      if (query == "") query = _getRandomTopic();
      var bookCase = await _bookRepo.getAvailableBooks(query);
      bookList = bookCase.items ?? [];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      bookList = [];
      isLoading = false;
      notifyListeners();
    }
  }

  String _getRandomTopic() {
    List _topics = ["iteso", "nature", "animals", "food", "health", "money"];
    return _topics[(Random().nextInt(_topics.length))];
  }
}
