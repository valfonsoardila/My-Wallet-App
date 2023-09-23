import 'package:my_wallet_app/data/services/peticionesGastos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControlGastoUser extends GetxController {
  final _response = Rxn();
  final _Datos = Rxn();
  final _mensaje = "".obs;

  Future<void> agregarGastos(gastosPorFecha) async {
    try {
      _response.value = await Peticiones.creargasto(gastosPorFecha);
      await controlGastos(_response.value);
    } catch (error) {
      print('Error en la operación de registro: $error');
      await Future.delayed(Duration(seconds: 2)); // Esperar 2 segundos
      await controlGastos(_response.value); // Reintentar el registro
    }
  }

  Future<void> obtenerGastos(uid) async {
    try {
      _Datos.value = await Peticiones.obtenergastos(uid);
      await controlGastos(_Datos.value);
    } catch (error) {
      print('Error en la operación de registro: $error');
      await Future.delayed(Duration(seconds: 2)); // Esperar 2 segundos
      await controlGastos(_Datos.value); // Reintentar el registro
    }
  }

  Future<void> actualizarGasto(id, expense, fecha, hora) async {
    _response.value =
        await Peticiones.actualizarGasto(id, expense, fecha, hora);
    await controlGastos(_response.value);
  }

  Future<void> eliminarGasto(String id) async {
    _response.value = await Peticiones.eliminarGasto(id);
    await controlGastos(_response.value);
  }

  Future<void> eliminarGastos(uid) async {
    print("entro");
    _response.value = await Peticiones.eliminarGastos(uid);
    await controlGastos(_response.value);
  }

  Future<void> controlGastos(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Por favor intente de nuevo";
      print(_mensaje.value);
    } else {
      _mensaje.value = "Proceso exitoso";
      _Datos.value = respuesta;
    }
  }

  List<Map<String, dynamic>> get datosGastos => _Datos.value;
  dynamic get estadoGasto => _response.value;
  String get mensajesPorGastos => _mensaje.value;
}
