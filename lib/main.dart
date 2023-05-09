import 'package:my_wallet/domain/controller/controllerPerfilFirebase.dart';
import 'package:my_wallet/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyA_qwsJFmcIdOD3up9Hp7C2B5mBMzOUZEk",
              appId: "1:172745531701:android:a8fd67cdd7d1f1619eec7c",
              messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
              projectId: "mywallet-bcefd",
              authDomain: "YOUR_AUTH_DOMAIN",
              storageBucket: "mywallet-bcefd.appspot.com"),
        )
      : await Firebase.initializeApp();
  Get.put(ControlUserAuth());
  Get.put(ControlUserPerfil());
  runApp(const App());
}
