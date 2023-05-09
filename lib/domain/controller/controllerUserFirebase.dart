import 'package:my_wallet/data/services/peticionesUserFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControlUserAuth extends GetxController {
  final _response = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _usuario = Rxn<UserCredential>();

  Future<void> crearUser(String email, String pass) async {
    _response.value = await Peticioneslogin.crearRegistroEmail(email, pass);
    print(_response.value);
    await controlUser(_response.value);
  }

  Future<void> ingresarUser(String email, String pass) async {
    _response.value = await Peticioneslogin.ingresarEmail(email, pass);
    print(_response.value);
    await controlUser(_response.value);
  }
  Future<void> recuperarPass(String email) async {
    _response.value = await Peticioneslogin.recuperarContrasena(email);
    print(_response.value);
    await controlUser(_response.value);
  }
  Future<void> cerrarSesion() async {
    _response.value = await Peticioneslogin.abandonarSesion();
    print(_response.value);
    await controlUser(_response.value);
  }
  Future<void> controlUser(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "Error de Conexion";
    } else if (respuesta == "Error de Conexion" || respuesta == "Usuario o Contraseña Incorrecta") {
      _mensaje.value = "Usuario o Contraseña Incorrecta";
    } else {
      _mensaje.value = "Proceso Realizado Correctamente";
      _usuario.value = respuesta;
    }
  }

  dynamic get estadoUser => _response.value;
  String get mensajesUser => _mensaje.value;
  UserCredential? get userValido => _usuario.value;
}
