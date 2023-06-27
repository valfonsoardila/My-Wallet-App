import 'package:my_wallet_app/ui/anim/introFull_app.dart';
// import 'package:my_wallet_app/ui/anim/introSimple_app.dart';
import 'package:my_wallet_app/ui/auth/perfil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet_app/ui/home/principal.dart';

import 'auth/restaurar.dart';
import 'auth/login.dart';
import 'auth/register.dart';

class App extends StatelessWidget {
  App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Wallet App',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        // "/": (context) =>  IntroSimple(),
        "/": (context) => IntroFull(),
        "/login": (context) => Login(),
        "/register": (context) => Register(),
        "/restaurar": (context) => Restaurar(),
        "/perfil": (context) => Perfil(),
        "/principal": (context) => Principal(),
      },
    );
  }
}
