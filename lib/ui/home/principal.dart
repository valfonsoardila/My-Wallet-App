import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'home.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});
  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final List<Widget> _widgetOptions = <Widget>[
    const Vista1(titulo: 'Home'),
    const Vista1(titulo: 'AddMonto'),
    const Vista1(titulo: 'Gastos'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const Drawer(child: Home()),
        appBar: AppBar(
            title: const Text('Gestión de Gastos'),
            backgroundColor: Colors.lightGreen,
            elevation: 0,
            bottom: const TabBar(tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.add),
              ),
              Tab(
                icon: Icon(Icons.settings),
              ),
            ])),
        body: TabBarView(children: _widgetOptions), // new
      ),
    );
  }
}

class Vista1 extends StatelessWidget {
  final String titulo;
  const Vista1({this.titulo = "Comming son", super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        titulo,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreen,
        ),
      ),
    );
  }
}
