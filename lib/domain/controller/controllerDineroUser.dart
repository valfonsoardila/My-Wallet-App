import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:my_wallet_app/data/services/peticionesDinero.dart';

class ControlDineroUser extends GetxController {
  final _response = Rxn();
  final _Datos = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _dinero = Rxn<UserCredential>();

  Future<void> crearDinero(Map<String, dynamic> dinero) async {
    try {
      _response.value = await Peticiones.crearmonto(dinero);
      await controlDinero(_response.value);
    } catch (e) {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    }
  }

  Future<void> actualizarDinero(Map<String, dynamic> dinero) async {
    try {
      _response.value = await Peticiones.actualizarmonto(dinero);
      await controlDinero(_response.value);
    } catch (e) {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    }
  }

  Future<void> eliminarDinero(Map<String, dynamic> dinero) async {
    try {
      _response.value = await Peticiones.eliminarmonto(dinero);
      await controlDinero(_response.value);
    } catch (e) {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    }
  }

  Future<Map<String, dynamic>> leerDinero(String id) async {
    _response.value = await Peticiones.obtenerMonto(id);
    await controlDinero(_response.value);
    return _response.value;
  }

  Future<void> controlDinero(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    } else {
      _mensaje.value = "Proceso exitoso";
      if (respuesta is UserCredential) {
        _dinero.value = respuesta;
      } else {
        _Datos.value = respuesta;
      }
    }
  }

  List<Map<String, dynamic>> get datosDinero => _Datos.value;
  dynamic get estadoDinero => _response.value;
  String get mensajesDinero => _mensaje.value;
  UserCredential? get dineroValido => _dinero.value;
}
