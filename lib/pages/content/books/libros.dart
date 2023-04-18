import 'package:bibliobook/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:provider/provider.dart';

import 'item_book.dart';

class Libros extends StatelessWidget {
  const Libros({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return _showLoadingWidget();
      } else {
        return _showContentWidget(context);
      }
    });
  }

  Widget _showContentWidget(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<SearchProvider>().fetchBooks();
      },
      child: GridView.count(
        // 2 columnas
        crossAxisCount: 2,
        // si no tiene childAspectRatio: (itemWidth / itemHeight) por default es 1/1 o sea cuadrado
        childAspectRatio: (3 / 4),
        children: List.generate(
          context.watch<SearchProvider>().bookList.length,
          (index) =>
              ItemBook(book: context.watch<SearchProvider>().bookList[index]),
        ),
      ),
    );
  }

  Widget _showErrorLoadingWidget() {
    return Center(
      child: Text("Ha ocurrido un error."),
    );
  }

  Widget _showLoadingWidget() {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
        return PlayStoreShimmer();
      },
    );
  }
}
