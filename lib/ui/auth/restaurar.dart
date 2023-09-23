import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class Restaurar extends StatelessWidget {
  Restaurar({super.key});

  @override
  Widget build(BuildContext context) {
    ControlUserAuth controlua = Get.find();
    TextEditingController user = TextEditingController();
    bool _isDarkMode = false;
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: _isDarkMode ? Colors.black : Colors.white,
          onPressed: () {
            Get.toNamed('/login');
          },
        ),
        backgroundColor: _isDarkMode ? Colors.white : Colors.black,
        elevation: 0, // Eliminar la sombra del AppBar
      ),
      body: SingleChildScrollView(
        child: Container(
          color: _isDarkMode ? Colors.white : Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                color: _isDarkMode ? Colors.white : Colors.black,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 40.0),
                      child: Text(
                        '¿Has olvidado tu contraseña?',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: _isDarkMode ? Colors.black : Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'Introduce el correo electronico asociado\na tu cuenta y te enviaremos un codigo de verificacion',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                          color: _isDarkMode ? Colors.grey[700] : Colors.grey,
                        ),
                        textAlign: TextAlign.start,
                      ),
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
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (user.text.isNotEmpty) {
                          controlua.recuperarPass(user.text).then((value) {
                            if (controlua.mensajesUser == "Proceso exitoso") {
                              Get.snackbar("Correo enviado",
                                  "Por favor revise su bandeja de entrada",
                                  duration: Duration(seconds: 4),
                                  backgroundColor:
                                      Color.fromARGB(255, 73, 73, 73));
                            } else {
                              Get.snackbar("No se pudo enviar el correo",
                                  "Por favor intente de nuevo",
                                  duration: Duration(seconds: 4),
                                  backgroundColor:
                                      Color.fromARGB(255, 73, 73, 73));
                            }
                          });
                        } else {
                          Get.snackbar("No ha ingresado un correo",
                              "Por favor intente de nuevo",
                              duration: Duration(seconds: 4),
                              backgroundColor: Color.fromARGB(255, 73, 73, 73));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        textStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      child: Text(
                        'Enviar enlace',
                        style: TextStyle(
                            color: _isDarkMode ? Colors.white : Colors.black),
                      ),
                    ),
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
