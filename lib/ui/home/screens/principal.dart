import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet_app/ui/home/widgets/drawer_screen.dart';
import 'package:my_wallet_app/ui/home/screens/main_screen.dart';

class Principal extends StatefulWidget {
  final String uid;

  const Principal({super.key, this.uid = ''});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  var uid = ''; // Variable local para almacenar el ID del usuario
  @override
  void initState() {
    super.initState();
    final args =
        Get.arguments; // Obtener los argumentos pasados desde la vista anterior
    uid = args ?? ""; // Asignar el valor a una variable local
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            DrawerScreen(uid: uid),
            MainScreen(),
          ],
        ),
      ),
    );
  }
}
