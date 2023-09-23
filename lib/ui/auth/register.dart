import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  Register({super.key});

  @override
  Widget build(BuildContext context) {
    //ControlUser controlu = Get.find();
    //ControlUserFirebase controlfb = Get.find();
    ControlUserAuth controlua = Get.find();
    TextEditingController nombre = TextEditingController();
    TextEditingController user = TextEditingController();
    TextEditingController pass = TextEditingController();
    bool _isDarkMode = false;
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return Container(
      color: _isDarkMode ? Colors.white : Colors.black,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: _isDarkMode ? Colors.black : Colors.white,
            onPressed: () {
              Get.toNamed('/login');
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            color: _isDarkMode ? Colors.white : Colors.black,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(children: [
              Container(
                padding: EdgeInsets.only(left: 80, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.person, color: Colors.lightGreen, size: 40),
                    SizedBox(height: 10),
                    Text(
                      "Crear una Cuenta",
                      style: TextStyle(color: Colors.lightGreen, fontSize: 33),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: 35,
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.27),
                child: Column(children: [
                  TextFormField(
                    controller: nombre,
                    style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.lightGreen),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: _isDarkMode ? Colors.black : Colors.white),
                      ),
                      labelText: 'Nombre completo',
                      labelStyle: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white),
                      prefixIcon: Icon(Icons.supervised_user_circle,
                          color: _isDarkMode ? Colors.black : Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: user,
                    style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.lightGreen),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: _isDarkMode ? Colors.black : Colors.white),
                      ),
                      labelText: 'Correo electrónico',
                      labelStyle: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white),
                      prefixIcon: Icon(Icons.email,
                          color: _isDarkMode ? Colors.black : Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: pass,
                    obscureText: true,
                    style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.lightGreen),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: _isDarkMode ? Colors.black : Colors.white),
                      ),
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white),
                      prefixIcon: Icon(Icons.lock,
                          color: _isDarkMode ? Colors.black : Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Registrarse',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.lightGreen,
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () {
                              if (nombre.text.isEmpty &&
                                  user.text.isEmpty &&
                                  pass.text.isEmpty) {
                                Get.snackbar("Por favor llene todos los campos",
                                    controlua.mensajesUser,
                                    duration: Duration(seconds: 4),
                                    backgroundColor:
                                        Color.fromARGB(255, 73, 73, 73));
                              } else if (nombre.text.isEmpty) {
                                Get.snackbar(
                                    "Por favor llene el campo de nombre",
                                    controlua.mensajesUser,
                                    duration: Duration(seconds: 4),
                                    backgroundColor:
                                        Color.fromARGB(255, 73, 73, 73));
                              } else if (user.text.isEmpty) {
                                Get.snackbar(
                                    "Por favor llene el campo de correo",
                                    controlua.mensajesUser,
                                    duration: Duration(seconds: 4),
                                    backgroundColor:
                                        Color.fromARGB(255, 73, 73, 73));
                              } else if (pass.text.isEmpty) {
                                Get.snackbar(
                                    "Por favor llene el campo de contraseña",
                                    controlua.mensajesUser,
                                    duration: Duration(seconds: 4),
                                    backgroundColor:
                                        Color.fromARGB(255, 73, 73, 73));
                              } else {
                                controlua
                                    .crearUser(user.text, pass.text)
                                    .then((value) {
                                  if (controlua.userValido == null) {
                                    Get.snackbar(
                                        "Error al registrar, Asegurate de que tu contraseña es mayor a 6 caracteres",
                                        controlua.mensajesUser,
                                        duration: Duration(seconds: 4),
                                        backgroundColor:
                                            Color.fromARGB(255, 73, 73, 73));
                                  } else {
                                    Get.snackbar("¡Registrado Correctamente!",
                                        controlua.mensajesUser,
                                        duration: Duration(seconds: 4),
                                        backgroundColor:
                                            Color.fromARGB(255, 73, 73, 73));
                                    String password = pass.text;
                                    Get.toNamed("/perfil", arguments: [
                                      nombre.text,
                                      user.text,
                                      password
                                    ]);
                                  }
                                });
                              }
                            },
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ]),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.toNamed('/login');
                          },
                          child: Text(
                            'Inicio',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
