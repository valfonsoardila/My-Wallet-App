import 'package:my_wallet_app/data/services/peticionesPerfil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControlUserPerfil extends GetxController {
  final _response = Rxn();
  final _Datos = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _perfil = Rxn<UserCredential>();

  Future<void> crearPerfil(Map<String, dynamic> Perfil, foto) async {
    try {
      _response.value = await Peticiones.crearPerfil(Perfil, foto);
      await controlPerfil(_response.value);
    } catch (error) {
      print('Error en la operación de registro: $error');
      await Future.delayed(Duration(seconds: 2)); // Esperar 2 segundos
      await crearPerfil(Perfil, foto); // Reintentar el registro
    }
  }

  Future<void> actualizarPerfil(Map<String, dynamic> Perfil, foto) async {
    _response.value = await Peticiones.actualizarPerfil(Perfil, foto);
    await controlPerfil(_response.value);
  }

  Future<void> eliminarPerfil(Map<String, dynamic> Perfil) async {
    _response.value = await Peticiones.eliminarPerfil(Perfil);
    await controlPerfil(_response.value);
  }

  Future<Map<String, dynamic>> obtenerPerfil(String id) async {
    print("llego al controlador");
    _response.value = await Peticiones.obtenerPerfil(id);
    await controlPerfil(_response.value);
    print('esto fue lo que llego al controlador: ${_response.value}');
    return _response.value;
  }

  Future<void> controlPerfil(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    } else {
      _mensaje.value = "Proceso exitoso";
      if (respuesta is UserCredential) {
        _perfil.value = respuesta;
      } else {
        _Datos.value = respuesta;
      }
    }
  }

  Map<String, dynamic> get datosPerfil => _Datos.value;
  dynamic get estadoPerfil => _response.value;
  String get mensajesPerfil => _mensaje.value;
  UserCredential? get perfilValido => _perfil.value;
}
