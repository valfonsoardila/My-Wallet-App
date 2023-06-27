import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: "AIzaSyA_qwsJFmcIdOD3up9Hp7C2B5mBMzOUZEk",
            appId: "1:172745531701:android:a8fd67cdd7d1f1619eec7c",
            messagingSenderId: "7672350998687376030",
            projectId: "mywallet-bcefd",
            authDomain: "mywallet-bcefd.firebaseapp.com",
            storageBucket: "mywallet-bcefd.appspot.com",
          ),
        )
      : await Firebase.initializeApp();
  Get.put(ControlUserAuth());
  Get.put(ControlUserPerfil());
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(App());
}
