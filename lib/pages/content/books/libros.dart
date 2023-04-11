import 'package:bibliobook/providers/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'item_book.dart';

class Libros extends StatelessWidget {
  const Libros({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implementar el Consumer
    return Container();
  }

  Widget _showContentWidget(BuildContext context) {
    // TODO: analice este metodo para ver que hace
    // TODO: poner el refresh indicator para hacer swipe to refresh
    return GridView.count(
      // 2 columnas
      crossAxisCount: 2,
      // si no tiene childAspectRatio: (itemWidth / itemHeight) por default es 1/1 o sea cuadrado
      childAspectRatio: (3 / 4),
      children: List.generate(
        context.watch<SearchProvider>().bookList.length,
        (index) =>
            ItemBook(book: context.watch<SearchProvider>().bookList[index]),
      ),
    );
  }

  Widget _showErrorLoadingWidget() {
    return Center(
      child: Text("Ha ocurrido un error."),
    );
  }

  Widget _showLoadingWidget() {
    // TODO: retornar un list view con items del shimmer
    return Container();
  }
}
