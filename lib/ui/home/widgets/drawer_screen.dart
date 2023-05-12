import 'package:flutter/material.dart';
import 'package:my_wallet/domain/controller/controllerUserFirebase.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  ControlUserAuth controlua = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/my_wallet.png',
                  width:
                      30, // Ajusta el ancho de la imagen según tus necesidades
                  height:
                      30, // Ajusta la altura de la imagen según tus necesidades
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'MyWallet APP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const NewImage(img: '', text: ''),
            const NewRow(
              textOne: 'Nombre de usuario',
              icon: Icons.person_outline,
              textTwo: '',
            ),
            const SizedBox(
              height: 20,
            ),
            const NewRow(
              textOne: 'Profesion',
              icon: Icons.work_outline,
              textTwo: '',
            ),
            const SizedBox(
              height: 20,
            ),
            const NewRow(
              textOne: 'Ciudad',
              icon: Icons.location_on_outlined,
              textTwo: '',
            ),
            const SizedBox(
              height: 20,
            ),
            const NewRow(
              textOne: 'Direccion',
              icon: Icons.home_outlined,
              textTwo: '',
            ),
            const SizedBox(
              height: 20,
            ),
            const NewRow(
              textOne: 'Celular',
              icon: Icons.phone_outlined,
              textTwo: '',
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.cancel,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log out',
                    style: TextStyle(color: Colors.white.withOpacity(0.5)),
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  controlua.cerrarSesion();
                  Get.snackbar("Abandonaste la sesion", controlua.mensajesUser,
                      duration: const Duration(seconds: 4),
                      backgroundColor: const Color.fromARGB(255, 73, 73, 73));
                  Get.toNamed("/login");
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String textOne;
  final String textTwo;

  const NewRow({
    Key? key,
    required this.icon,
    required this.textOne,
    required this.textTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              textOne,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              textTwo,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}

class NewImage extends StatelessWidget {
  final String img;
  final String text;

  const NewImage({
    Key? key,
    required this.text,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(img),
          radius: 30,
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
