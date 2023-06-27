import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class Peticiones {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<dynamic> creargasto(Map<String, dynamic> gastosPorFecha) async {
    try {
      await _db.collection('gastos').add(gastosPorFecha);
      return "Proceso exitoso";
    } catch (e) {
      print(e);
      return "1";
    }
  }

  static Future<dynamic> obtenergastos(String uid) async {
    try {
      Map<String, dynamic> datos = {};
      List<Map<String, dynamic>> listaDatos = [];
      final gastos = await FirebaseFirestore.instance
          .collection('gastos')
          .where('uid', isEqualTo: uid)
          .get();
      //Comprueba si el documento existe
      if (gastos.docs.isNotEmpty) {
        gastos.docs.forEach((doc) {
          datos = doc.data();
          listaDatos.add(datos);
        });
      } else {
        datos = {};
      }
      return listaDatos;
    } catch (e) {
      print(e);
      return "1";
    }
  }

  static Future<dynamic> actualizarGasto(
      String id, double expense, String fecha, String hora) async {
    try {
      await _db.collection('gastos').doc(id).update({
        'expense': expense,
        'fecha': fecha,
        'hora': hora,
      });
      return "Proceso exitoso";
    } catch (e) {
      print(e);
      return "1";
    }
  }

  static Future<dynamic> eliminarGasto(String id) async {
    try {
      await _db.collection('gastos').doc(id).delete();
      return "Proceso exitoso";
    } catch (e) {
      print(e);
      return "1";
    }
  }
}
