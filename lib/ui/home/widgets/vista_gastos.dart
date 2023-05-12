import 'package:flutter/material.dart';

//Vistas de la aplicacion en la vista principal
class VistaGastos extends StatelessWidget {
  final String titulo;
  const VistaGastos({this.titulo = "Comming son", super.key});

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