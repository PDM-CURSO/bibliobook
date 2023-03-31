import 'package:bibliobook/content/buscar.dart';
import 'package:bibliobook/content/libros.dart';
import 'package:bibliobook/content/notas.dart';
import 'package:bibliobook/content/perfil.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pagesList = [Libros(), Buscar(), Perfil(), Notas()];
  final _pagesName = ["Libros", "Buscar", "Perfil", "Notas"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_pagesName[_currentIndex]}'),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pagesList,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.book),
            label: '${_pagesName[0]}',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: '${_pagesName[1]}',
          ),
          NavigationDestination(
            icon: Icon(Icons.verified_user),
            label: '${_pagesName[2]}',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: '${_pagesName[3]}',
          ),
        ],
      ),
    );
  }
}
