import 'package:flutter/material.dart';
import 'package:my_wallet/ui/home/widgets/drawer_screen.dart';
import 'package:my_wallet/ui/home/screens/principal_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            DrawerScreen(),
            Principal(),
          ],
        ),
      ),
    );
  }
}