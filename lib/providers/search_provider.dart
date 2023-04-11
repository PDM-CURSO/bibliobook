import 'dart:math';

import 'package:bibliobook/models/book_case/book.dart';
import 'package:flutter/foundation.dart';

import '../repositories/books_repository.dart';

class SearchProvider with ChangeNotifier {
  BooksRepository _bookRepo = BooksRepository();
  List<Book> bookList = [];
  bool isLoading = true;
  bool isError = false;
  Future<void> fetchBooks({String query = ""}) async {
    try {
      _resetErrorAndLoading();
      if (query == "") query = _getRandomTopic();
      var bookCase = await _bookRepo.getAvailableBooks(query);
      print("BookCase: ${bookCase}");
      bookList = bookCase.items ?? [];
      _resetErrorAndLoading();
      notifyListeners();
    } catch (e) {
      print("Hubo error en el request: ${e.toString()}");
      bookList = [];
      _onErrorResetErrorAndLoading();
      notifyListeners();
    }
  }

  void _resetErrorAndLoading() {
    isLoading = false;
    isError = false;
    notifyListeners();
  }

  void _onErrorResetErrorAndLoading() {
    isLoading = false;
    isError = true;
    notifyListeners();
  }

  String _getRandomTopic() {
    List _topics = ["iteso", "nature", "animals", "food", "health", "money"];
    return _topics[(Random().nextInt(_topics.length))];
  }
}
