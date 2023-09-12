import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet_app/domain/controller/controllerDineroUser.dart';
import 'package:my_wallet_app/ui/home/drawer_screen.dart';
//import 'package:my_wallet_app/ui/home/main_screen.dart';
import 'package:my_wallet_app/ui/home/navegation_screen.dart';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:provider/provider.dart';

class Principal extends StatefulWidget {
  final String uid;
  const Principal({super.key, this.uid = ''});
  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  //CONTROLADORES
  ControlUserAuth controlua = Get.find();
  ControlUserPerfil controlPerfil = Get.put(ControlUserPerfil());
  ControlDineroUser controlDinero = Get.put(ControlDineroUser());
  //VARIABLES
  var uid = ''; // Variable local para almacenar el ID del usuario
  var correo = "";
  var nombre = "";
  var profesion = "";
  var ciudad = "";
  var direccion = "";
  var celular = "";
  var foto = "";
  var dinero = "";

  bool _isDarkMode = false;
  //FUNCIONES
  @override
  void initState() {
    super.initState();
    final args =
        Get.arguments; // Obtener los argumentos pasados desde la vista anterior
    uid = args ?? ""; // Asignar el valor a una variable local
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return FutureBuilder<Map<String, dynamic>>(
      future: controlPerfil.obtenercatalogo(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se carga el perfil, puedes mostrar un indicador de carga, por ejemplo:
          return Container(
            alignment: Alignment.center,
            color: _isDarkMode ? Colors.white : Colors.black,
            child: CircularProgressIndicator(
              color: Colors.lightGreen,
            ),
          );
        } else if (snapshot.hasError) {
          // Si ocurre un error al obtener el perfil, puedes mostrar un mensaje de error
          return Text('Error al obtener el perfil');
        } else {
          final datosPerfil =
              snapshot.data ?? {}; // Obtener los datos del perfil del snapshot
          // Asignar los valores a las variables correspondientes
          correo = datosPerfil['correo'] ?? "";
          nombre = datosPerfil['nombre'] ?? "";
          profesion = datosPerfil['profesion'] ?? "";
          ciudad = datosPerfil['ciudad'] ?? "";
          direccion = datosPerfil['direccion'] ?? "";
          celular = datosPerfil['celular'] ?? "";
          foto = datosPerfil['foto'] ?? "";
          controlDinero.leerDinero(uid);
          final datosdinero = snapshot.data ?? {};
          dinero = datosdinero['dineroInicial'] ?? "";
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Stack(
                children: [
                  DrawerScreen(
                      uid: uid,
                      correo: correo,
                      nombre: nombre,
                      profesion: profesion,
                      ciudad: ciudad,
                      direccion: direccion,
                      celular: celular,
                      foto: foto),
                  //MainScreen(uid: uid, foto: foto), //Pantalla principal
                  NavegationScreen(uid: uid, foto: foto, dinero: dinero),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
