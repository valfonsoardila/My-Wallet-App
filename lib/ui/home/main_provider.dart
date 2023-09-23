import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet_app/domain/controller/controllerDineroUser.dart';
import 'package:my_wallet_app/domain/controller/controllerGastosUser.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/ui/home/drawer_screen.dart';
import 'package:my_wallet_app/ui/home/navegation_screen.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:provider/provider.dart';

class MainProvider extends StatefulWidget {
  const MainProvider({super.key});

  @override
  State<MainProvider> createState() => _MainProviderState();
}

class _MainProviderState extends State<MainProvider> {
  //CONTROLADORES
  ControlUserAuth controlua = Get.put(ControlUserAuth());
  ControlUserPerfil controlpu = Get.put(ControlUserPerfil());
  ControlGastoUser controgu = Get.put(ControlGastoUser());
  ControlDineroUser controdu = Get.put(ControlDineroUser());
  //MAPAS
  Map<String, dynamic> perfil = {};
  //LISTAS
  List<Map<String, dynamic>> consultaGastos = [];
  List<Map<String, dynamic>> consultaDinero = [];
  //VARIABLES
  String? uid;
  String msg = "";
  String idUsuario = "";
  bool _isDarkMode = false;

  @override
  void initState() {
    controlua.consultarUser().then((value) {
      if (controlua.estadoUser != null) {
        uid = controlua.estadoUser!.uid;
        idUsuario = uid!;
        cargarDatos();
      }
    });
    super.initState();
  }

  void cargarDatos() {
    if (uid != null) {
      //Consult datos de usuario logueado
      controlpu.obtenerPerfil(idUsuario).then((value) => {
            setState(() {
              msg = controlpu.mensajesPerfil;
            }),
            if (msg == "Proceso exitoso")
              {
                perfil = controlpu.datosPerfil,
              }
          });
      //Consulto dinero de usuario logueado
      controdu.obtenerDinero(idUsuario).then((value) => {
            setState(() {
              msg = controdu.mensajesDinero;
            }),
            if (msg == "Proceso exitoso")
              {
                consultaDinero = controdu.datosDinero,
              }
          });
      //Consulto gastos de usuario logueado
      controgu.obtenerGastos(idUsuario).then((value) => {
            setState(() {
              msg = controgu.mensajesPorGastos;
            }),
            if (msg == "Proceso exitoso")
              {
                consultaGastos = controgu.datosGastos,
              }
          });
    }
  }

  void obtenerDineroGestionado(double dinero) {
    this.consultaDinero[0]['dineroInicial'] = dinero;
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
    return Scaffold(
      backgroundColor: _isDarkMode != false ? Colors.black : Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: Future.delayed(
              Duration(seconds: 3)), //Establece el tiempo de carga
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: _isDarkMode ? Colors.white : Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.lightGreen,
                      backgroundColor: const Color.fromARGB(255, 108, 153, 58),
                    ),
                    Text(
                      "Cargando...",
                      style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.lightGreen,
                        fontSize: 20,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              if (snapshot.hasError) {
                print("Error de conexion: ${snapshot.error}");
                final theme = Provider.of<ThemeChanger>(context);
                var temaActual = theme.getTheme();
                if (temaActual == ThemeData.dark()) {
                  _isDarkMode = true;
                } else {
                  _isDarkMode = false;
                }
                return Container(
                  width: MediaQuery.of(context).size.width,
                  color: _isDarkMode ? Colors.white : Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.network_check,
                            color: _isDarkMode != false
                                ? _isDarkMode != false
                                    ? Colors.red
                                    : Color.fromARGB(255, 231, 30, 15)
                                : Color.fromARGB(255, 231, 30, 15),
                          ),
                          Icon(
                            Icons.error,
                            color: _isDarkMode != false
                                ? _isDarkMode != false
                                    ? Colors.red
                                    : Color.fromARGB(255, 231, 30, 15)
                                : Color.fromARGB(255, 231, 30, 15),
                          ),
                        ],
                      ),
                      Text(
                        "Error: ${snapshot.error}",
                        style: TextStyle(
                          color: _isDarkMode != false
                              ? _isDarkMode != false
                                  ? Colors.red
                                  : Color.fromARGB(255, 231, 30, 15)
                              : Color.fromARGB(255, 231, 30, 15),
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        "Verifique su conexión a internet",
                        style: TextStyle(
                          color: _isDarkMode != false
                              ? _isDarkMode != false
                                  ? Colors.red
                                  : Color.fromARGB(255, 231, 30, 15)
                              : Color.fromARGB(255, 231, 30, 15),
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        color: Colors.lightGreen,
                        backgroundColor:
                            const Color.fromARGB(255, 108, 153, 58),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => MainProvider());
                        },
                        child: Text(
                          "Intentar de nuevo",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                print("Perfil: $perfil");
                print("Consulta dinero: $consultaDinero");
                print("Consulta gastos: $consultaGastos");
                if (perfil.isNotEmpty) {
                  return Scaffold(
                    body: Stack(
                      children: [
                        DrawerScreen(
                          uid: perfil['id'],
                          correo: perfil['correo'],
                          nombre: perfil['nombre'],
                          profesion: perfil['profesion'],
                          ciudad: perfil['ciudad'],
                          direccion: perfil['direccion'],
                          celular: perfil['celular'],
                          foto: perfil['foto'],
                        ),
                        NavegationScreen(
                          uid: perfil['id'],
                          foto: perfil['foto'],
                          dinero: consultaDinero.isNotEmpty
                              ? consultaDinero[0]['dineroInicial']
                              : 0,
                          mapDinero: consultaDinero.isNotEmpty
                              ? consultaDinero[0]
                              : {},
                          gastos:
                              consultaGastos.isNotEmpty ? consultaGastos : [],
                          dineroGestionado: obtenerDineroGestionado,
                        ),
                      ],
                    ),
                  );
                } else {
                  print("Error desconocido");
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    color: _isDarkMode ? Colors.white : Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help_outline,
                          color: _isDarkMode != false
                              ? Colors.red
                              : Color.fromARGB(255, 231, 30, 15),
                        ),
                        Text(
                          "Error desconocido",
                          style: TextStyle(
                            color: _isDarkMode != false
                                ? Colors.red
                                : Color.fromARGB(255, 231, 30, 15),
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          "Por favor vuelva a ingresar",
                          style: TextStyle(
                            color: _isDarkMode != false
                                ? Colors.red
                                : Color.fromARGB(255, 231, 30, 15),
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed("/login");
                          },
                          child: Text(
                            "Volver",
                            style: TextStyle(
                              color: _isDarkMode != false
                                  ? Colors.red
                                  : Color.fromARGB(255, 231, 30, 15),
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
            }
          },
        ),
      ),
    );
  }
}
