import 'package:bibliobook/auth/bloc/auth_bloc.dart';
import 'package:bibliobook/pages/content/books/libros.dart';
import 'package:bibliobook/pages/create_notes/notes_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../content/buscar.dart';
import '../content/notas.dart';
import '../content/perfil.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
            },
          ),
        ],
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
        destinations: _bottomDestinations,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Crear nueva nota",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NotesForm()));
        },
      ),
    );
  }

  List<Widget> get _bottomDestinations {
    return [
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
    ];
  }
}
