import 'package:my_wallet/data/services/peticionesPerfilFirebase.dart';
import 'package:get/get.dart';

class ControlUserPerfil extends GetxController {
  Future<void> crearcatalogo(Map<String, dynamic> catalogo, foto) async {
    await Peticiones.crearcatalogo(catalogo, foto);
  }
}
