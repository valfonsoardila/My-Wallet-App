import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class Peticiones {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<dynamic> crearmonto(Map<String, dynamic> dinero) async {
    try {
      await _db
          .collection('dinero')
          .doc(dinero['id'])
          .set(dinero)
          .catchError((e) {
        print(e);
        throw e; // Lanzar la excepción para que sea capturada en el controlador
      });
      return true;
    } catch (error) {
      print('Error en la operación de creación de dinero: $error');
      throw error; // Lanzar la excepción para que sea capturada en el controlador
    }
  }

  static Future<dynamic> obtenerMonto(String idUser) async {
    List<Map<String, dynamic>> lista = [];
    try {
      final QuerySnapshot result =
          await _db.collection('dinero').where('id', isEqualTo: idUser).get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        return null;
      } else {
        documents.forEach((element) {
          lista.add(element.data() as Map<String, dynamic>);
        });
        return lista;
      }
    } catch (error) {
      print('Error en la operación de obtener dinero: $error');
      throw error; // Lanzar la excepción para que sea capturada en el controlador
    }
  }

  static Future<dynamic> actualizarmonto(Map<String, dynamic> dinero) async {
    try {
      await _db
          .collection('dinero')
          .doc(dinero['id'])
          .update(dinero)
          .catchError((e) {
        print(e);
        throw e; // Lanzar la excepción para que sea capturada en el controlador
      });
      return true;
    } catch (error) {
      print('Error en la operación de actualización de dinero: $error');
      throw error; // Lanzar la excepción para que sea capturada en el controlador
    }
  }

  static Future<dynamic> eliminarmonto(Map<String, dynamic> dinero) async {
    try {
      await _db.collection('dinero').doc(dinero['id']).delete().catchError((e) {
        print(e);
        throw e; // Lanzar la excepción para que sea capturada en el controlador
      });
      return true;
    } catch (error) {
      print('Error en la operación de eliminación de dinero: $error');
      throw error; // Lanzar la excepción para que sea capturada en el controlador
    }
  }
}
