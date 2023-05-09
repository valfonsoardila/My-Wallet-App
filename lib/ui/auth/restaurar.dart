import 'package:my_wallet/domain/controller/controllerUserFirebase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Restaurar extends StatelessWidget {
  const Restaurar({super.key});
  void _resetPassword() {
    final TextEditingController emailController = TextEditingController();
    // Lógica para enviar el enlace de restablecimiento de contraseña al correo electrónico
    String email = emailController.text;
    // Aquí puedes implementar la lógica para enviar el enlace de restablecimiento de contraseña
    print('Enviar enlace de restablecimiento de contraseña a: $email');
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0, // Eliminar la sombra del AppBar
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: const Text(
                '¿Has olvidado tu contraseña?',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: const Text(
                'Introduce el correo electronico asociado\na tu cuenta y te enviaremos un codigo de verificacion',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),
            ),
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
            ElevatedButton(
              onPressed: _resetPassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                textStyle: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              child: const Text(
                'Enviar enlace',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}