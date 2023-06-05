import 'package:flutter/material.dart';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DrawerScreen extends StatefulWidget {
  final String uid;
  const DrawerScreen({Key? key, this.uid = ''}) : super(key: key);
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
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: controlPerfil.obtenercatalogo(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se carga el perfil, puedes mostrar un indicador de carga, por ejemplo:
          return Center(
            child: CircularProgressIndicator(
              color: Colors.lightGreen,
            ),
          );
        } else if (snapshot.hasError) {
          // Si ocurre un error al obtener el perfil, puedes mostrar un mensaje de error
          return Text('Error al obtener el perfil');
        } else {
          final datosPerfil =
              snapshot.data ?? {}; // Obtener los datos del perfil del snapshot
          // Asignar los valores a las variables correspondientes
          correo = datosPerfil['correo'] ?? "";
          nombre = datosPerfil['nombre'] ?? "";
          profesion = datosPerfil['profesion'] ?? "";
          ciudad = datosPerfil['ciudad'] ?? "";
          direccion = datosPerfil['direccion'] ?? "";
          celular = datosPerfil['celular'] ?? "";
          foto = datosPerfil['foto'] ?? "";
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
                  const SizedBox(
                    height: 20,
                  ),
                  NewRow(
                    textOne: 'Profesion',
                    icon: Icons.work_outline,
                    textTwo: profesion,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NewRow(
                    textOne: 'Ciudad',
                    icon: Icons.location_on_outlined,
                    textTwo: ciudad,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NewRow(
                    textOne: 'Direccion',
                    icon: Icons.home_outlined,
                    textTwo: direccion,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  NewRow(
                    textOne: 'Celular',
                    icon: Icons.phone_outlined,
                    textTwo: celular,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        controlua.cerrarSesion();
                        // Get.snackbar(
                        //     "Abandonaste la sesion", controlua.mensajesUser,
                        //     duration: const Duration(seconds: 4),
                        //     backgroundColor:
                        //         const Color.fromARGB(255, 73, 73, 73));
                        controlua.userValido == null &&
                                controlua.estadoUser == null
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
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Log out',
                          style: TextStyle(
                              color: Colors.lightGreen.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextButton(
              onPressed: () {
                // Lógica a ejecutar al presionar el botón
              },
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            icon,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              textOne,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            Text(
                              textTwo,
                              style: const TextStyle(
                                  color: Colors.lightGreenAccent, fontSize: 16),
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
