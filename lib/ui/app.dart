import 'package:my_wallet/ui/auth/perfil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet/ui/home/principal.dart';

import 'auth/restaurar.dart';
import 'auth/login.dart';
import 'auth/register.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Wallet App',
      theme: ThemeData.dark(),
      initialRoute: '/principal',
      routes: {
        "/login": (context) => const Login(),
        "/register": (context) => const Register(),
        "/restaurar": (context) => const Restaurar(),
        "/perfil": (context) => const Perfil(),
        "/principal": (context) => const Principal(),
      },
    );
  }
}