import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  Login({Key? key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ControlUserAuth controlua = Get.find();
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool _isDarkMode = false;
  void guardarDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', user.text);
    prefs.setString('pass', pass.text);
    await prefs.remove('userLoggedIn');
  }

  void cargarDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user.text = prefs.getString('user') ?? '';
    pass.text = prefs.getString('pass') ?? '';
  }

  @override
  void initState() {
    super.initState();
    cargarDatos();
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
      body: SingleChildScrollView(
        child: Container(
          color: _isDarkMode ? Colors.white : Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/images/my_wallet.png',
                      width:
                          100, // Ajusta el ancho de la imagen según tus necesidades
                      height:
                          100, // Ajusta la altura de la imagen según tus necesidades
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'My Wallet',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: _isDarkMode ? Colors.black : Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40.0),
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
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: pass,
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
                      obscureText: true,
                    ),
                    SizedBox(height: 40.0),
                    ElevatedButton(
                      onPressed: () {
                        //Proceso de validación de usuario
                        controlua.estadoUser == null;
                        controlua.userValido == null;
                        if (user.text == "" && pass.text == "") {
                          Get.snackbar(
                              "No ha ingresado su correo electronico, ni su contraseña",
                              "Por favor ingrese su correo y contraseña");
                        } else if (user.text == "") {
                          Get.snackbar("No ha ingresado su correo electronico",
                              "Por favor ingrese su correo");
                        } else if (pass.text == "") {
                          Get.snackbar("No ha ingreado su contraseña",
                              "por favor ingrese una contraseña");
                        } else {
                          controlua
                              .ingresarUser(user.text, pass.text)
                              .then((value) {
                            if (controlua.userValido == null) {
                              Get.snackbar(
                                  "El usuario o contraseña no son correctos",
                                  controlua.mensajesUser,
                                  duration: Duration(seconds: 4),
                                  backgroundColor:
                                      Color.fromARGB(255, 73, 73, 73));
                            } else {
                              if (controlua.estadoUser == null) {
                                Get.snackbar(
                                    "El usuario o contraseña no son correctos",
                                    controlua.mensajesUser,
                                    duration: Duration(seconds: 4),
                                    backgroundColor:
                                        Color.fromARGB(255, 73, 73, 73));
                              } else {
                                if (controlua.estadoUser != null) {
                                  // Get.snackbar("Ha iniciado sesión correctamente",
                                  //     controlua.mensajesUser,
                                  //     duration:  Duration(seconds: 4),
                                  //     backgroundColor:
                                  //          Color.fromARGB(255, 73, 73, 73));
                                  // controlua.userValido!.user?.uid;
                                  String uid = controlua.userValido!.user!.uid;
                                  Get.toNamed("/principal", arguments: uid);
                                  guardarDatos();
                                  // Get.to(Home(uid: uid));
                                }
                              }
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        textStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Get.toNamed("/register");
                            },
                            child: Text(
                              'Registrarse',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: _isDarkMode
                                    ? Colors.black
                                    : Colors.lightGreen,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.toNamed("/restaurar");
                            },
                            child: Text(
                              'Restaurar contraseña',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: _isDarkMode
                                    ? Colors.black
                                    : Colors.lightGreen,
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
