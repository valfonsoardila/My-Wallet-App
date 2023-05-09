import 'package:my_wallet/domain/controller/controllerUserFirebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    bool isHovered = false;
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 0), // Ajusta el valor para mover el contenido más arriba
          child: Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                const SizedBox(height: 20.0),
                const Text(
                  'My Wallet',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.lightGreen,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Iniciar sesión',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.lightGreen),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'Correo electrónico',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.lightGreen),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'Contraseña',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 40.0),
                MouseRegion(
                  onHover: (event) {
                    setState(() {
                      isHovered = true;
                    });
                  },
                  onExit: (event) {
                    setState(() {
                      isHovered = false;
                    });
                  },
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isHovered ? Colors.lightGreen : Colors.lightGreen,
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    child: const Text(
                      'Iniciar sesión',
                      style: TextStyle(color:Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.toNamed("/register");
                        },
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed("/restaurar");
                        },
                        child: const Text(
                          'Restaurar contraseña',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
}
