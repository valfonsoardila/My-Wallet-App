import 'package:flutter/material.dart';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  final String uid;
  final String correo;
  final String nombre;
  final String profesion;
  final String ciudad;
  final String direccion;
  final String celular;
  final String foto;
  DrawerScreen({
    Key? key,
    required this.uid,
    required this.correo,
    required this.nombre,
    required this.profesion,
    required this.ciudad,
    required this.direccion,
    required this.celular,
    required this.foto,
  }) : super(key: key);
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  ControlUserAuth controlua = Get.find();
  ControlUserPerfil controlPerfil = Get.find();
  var correo = "";
  var nombre = "";
  var profesion = "";
  var ciudad = "";
  var direccion = "";
  var celular = "";
  var foto = "";
  var uid = '';
  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    correo = widget.correo;
    nombre = widget.nombre;
    profesion = widget.profesion;
    ciudad = widget.ciudad;
    direccion = widget.direccion;
    celular = widget.celular;
    foto = widget.foto;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
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
                SizedBox(
                  width: 10,
                ),
                Text(
                  'MyWallet APP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            NewImage(img: foto, text: ''),
            NewRow(
              textOne: 'Coreo electronico',
              icon: Icons.person_pin_rounded,
              textTwo: correo,
            ),
            NewRow(
              textOne: 'Nombre de usuario',
              icon: Icons.person_outline,
              textTwo: nombre,
            ),
            SizedBox(
              height: 20,
            ),
            NewRow(
              textOne: 'Profesion',
              icon: Icons.work_outline,
              textTwo: profesion,
            ),
            SizedBox(
              height: 20,
            ),
            NewRow(
              textOne: 'Ciudad',
              icon: Icons.location_on_outlined,
              textTwo: ciudad,
            ),
            SizedBox(
              height: 20,
            ),
            NewRow(
              textOne: 'Direccion',
              icon: Icons.home_outlined,
              textTwo: direccion,
            ),
            SizedBox(
              height: 20,
            ),
            NewRow(
              textOne: 'Celular',
              icon: Icons.phone_outlined,
              textTwo: celular,
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  controlua.cerrarSesion();
                  // Get.snackbar(
                  //     "Abandonaste la sesion", controlua.mensajesUser,
                  //     duration:  Duration(seconds: 4),
                  //     backgroundColor:
                  //          Color.fromARGB(255, 73, 73, 73));
                  controlua.userValido == null && controlua.estadoUser == null
                      ? Get.offAllNamed("/home")
                      : Get.offAllNamed("/login");
                });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.lightGreen.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Log out',
                    style: TextStyle(color: Colors.lightGreen.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
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

  NewRow({
    Key? key,
    required this.icon,
    required this.textOne,
    required this.textTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  // Lógica a ejecutar al presionar el botón
                },
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            icon,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              textOne,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              textTwo,
                              style: TextStyle(
                                color: Colors.lightGreenAccent,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NewImage extends StatelessWidget {
  final dynamic img;
  final String text;

  NewImage({
    Key? key,
    required this.text,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (img != null && Uri.parse(img).isAbsolute) {
      // Si img es una URL válida, carga la imagen desde la URL
      imageWidget = CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(img),
      );
    } else {
      // Si img no es una URL válida, carga la imagen desde el recurso local
      imageWidget = CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage('assets/images/user.png'),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        imageWidget,
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
