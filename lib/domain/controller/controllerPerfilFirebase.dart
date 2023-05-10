import 'package:my_wallet/data/services/peticionesPerfilFirebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ControlUserPerfil extends GetxController {
  final _response = Rxn();
  final _mensaje = "".obs;
  final Rxn<UserCredential> _perfil = Rxn<UserCredential>();
  
  Future<void> crearcatalogo(Map<String, dynamic> catalogo, foto) async {
    _response.value = await Peticiones.crearcatalogo(catalogo, foto);
    await controlPerfil(_response.value);
  }
  Future<void> controlPerfil(dynamic respuesta) async {
    if (respuesta == null) {
      _mensaje.value = "Por favor intente de nuevo";
    } else if (respuesta == "1" || respuesta == "2") {
      _mensaje.value = "Por favor intente de nuevo";
    } else {
      _mensaje.value = "Proceso exitoso";
      _perfil.value = respuesta;
    }
  }

  dynamic get estadoPerfil => _response.value;
  String get mensajesPerfil => _mensaje.value;
  UserCredential? get perfilValido => _perfil.value;
}

