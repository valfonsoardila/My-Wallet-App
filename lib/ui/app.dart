import 'package:my_wallet_app/ui/anim/introFull_app.dart';
import 'package:my_wallet_app/ui/auth/login.dart';
// import 'package:my_wallet_app/ui/anim/introSimple_app.dart';
import 'package:my_wallet_app/ui/auth/perfil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet_app/ui/auth/register.dart';
import 'package:my_wallet_app/ui/auth/restaurar.dart';
import 'package:my_wallet_app/ui/home/main_provider.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  App({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger(ThemeData.light()),
      child: Consumer<ThemeChanger>(
        builder: (context, themeProvider, child) {
          return MaterialAppWithTheme();
        },
      ),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  MaterialAppWithTheme({
    super.key,
  });
  // Define los temas personalizados aquí
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    print(theme);
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
        "/principal": (context) => MainProvider(),
      },
    );
  }
}
