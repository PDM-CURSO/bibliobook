import 'package:flutter/material.dart';

import '../../../models/book_case/book.dart';

class ItemBook extends StatelessWidget {
  final Book book;
  final _onlinePlaceHolder = "https://via.placeholder.com/150";

  ItemBook({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              child: Card(
                // alternative to clip rrect
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Hero(
                  tag: book.id!,
                  child: Image.network(
                    _imageUrl(),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              // onTap: () => Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => DetailsBook(
              //       bookDetails: book,
              //     ),
              //   ),
              // ),
            ),
          ),
          Text(
            book.volumeInfo!.title ?? "No title available",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  String _imageUrl() {
    try {
      return book.volumeInfo!.imageLinks!.thumbnail ?? _onlinePlaceHolder;
    } catch (e) {
      return _onlinePlaceHolder;
    }
  }
}
