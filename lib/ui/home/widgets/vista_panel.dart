import 'package:flutter/material.dart';

class VistaPanel extends StatelessWidget {
  final String titulo;
  const VistaPanel({this.titulo = "Comming son", super.key});

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