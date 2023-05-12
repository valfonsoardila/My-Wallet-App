import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import 'package:my_wallet/domain/controller/controllerPerfilFirebase.dart';
import 'package:my_wallet/domain/controller/controllerUserFirebase.dart';
import 'package:get/get.dart';
import 'package:my_wallet/ui/home/widgets/vista_ajustes.dart';
import 'package:my_wallet/ui/home/widgets/vista_gastos.dart';
import 'package:my_wallet/ui/home/widgets/vista_panel.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  double montoInicial = 0;
  late TextEditingController _montoInicialController;
  final List<Widget> _widgetOptions = <Widget>[
    const VistaPanel(titulo: 'Home'),
    const VistaGastos(titulo: 'AddMonto'),
    VistaAjustes(),
  ];
  @override
  void initState() {
    super.initState();
    _montoInicialController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    ControlUserPerfil controlua = Get.find();
    ControlUserAuth controluser = Get.find();
    return DefaultTabController(
      length: 3,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(isDrawerOpen ? 0.85 : 1.00)
          ..rotateZ(isDrawerOpen ? -50 : 0),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: isDrawerOpen
              ? BorderRadius.circular(40)
              : BorderRadius.circular(0),
        ),
        child: Scaffold(
          endDrawer: Drawer(
              child: Container(
                color: Colors.lightGreenAccent[700],
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                      color: Colors.black,
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: const Text(
                              'MyWallet',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: const Text(
                              'Bienvenido a la aplicación de gestión de gastos, en esta aplicación podras llevar un control de tus gastos y ver en que gastas tu dinero',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.monetization_on,
                                    color: Colors.white),
                                const SizedBox(width: 5.0),
                                Text(
                                  "$montoInicial",
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'Monto Inicial',
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _montoInicialController,
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.lightGreen),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    labelText: 'Digita el Inicial',
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    prefixIcon: const Icon(Icons.monetization_on,
                                        color: Colors.white),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    montoInicial =
                                        double.parse(_montoInicialController.text);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(120, 50),
                                  backgroundColor: Colors.lightGreen,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Guardar',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))),
                ),
              )),
          appBar: AppBar(
              leading: isDrawerOpen
                  ? GestureDetector(
                      child: const Icon(Icons.arrow_back_ios),
                      onTap: () {
                        setState(() {
                          xOffset = 0;
                          yOffset = 0;
                          isDrawerOpen = false;
                        });
                      },
                    )
                  : GestureDetector(
                      child: const CircleAvatar(
                        backgroundImage: NetworkImage('https://mi-imagen.com'),
                        radius: 14,
                      ),
                      onTap: () {
                        setState(() {
                          xOffset = 290;
                          yOffset = 80;
                          isDrawerOpen = true;
                        });
                      },
                    ),
              title: const Text(
                'MyWallet',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              centerTitle: true,
              backgroundColor: Colors.lightGreen,
              elevation: 0,
              bottom: const TabBar(tabs: [
                Tab(
                  icon: Icon(Icons.home),
                ),
                Tab(
                  icon: Icon(Icons.add),
                ),
                Tab(
                  icon: Icon(Icons.settings),
                ),
              ])),
              body: Container(
                color: Colors.black,
                child: TabBarView(
                  children: _widgetOptions,
                  ),
              ),
        ),
      ),
    );
  }
}

class NewPadding extends StatelessWidget {
  final String image1;
  final String text1;
  final String image2;
  final String text2;

  const NewPadding({
    Key? key,
    required this.image1,
    required this.text1,
    required this.image2,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image(
                    height: 100,
                    width: 100,
                    image: AssetImage(image1),
                  ),
                ),
                Text(
                  text1,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      decoration: TextDecoration.none),
                )
              ],
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Image(
                    height: 100,
                    width: 100,
                    image: AssetImage(image2),
                  ),
                ),
                Text(
                  text2,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      decoration: TextDecoration.none),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// // import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:my_wallet/domain/controller/controllerPerfilFirebase.dart';
// import 'package:my_wallet/domain/controller/controllerUserFirebase.dart';
// import 'package:get/get.dart';
// import 'package:my_wallet/ui/home/widgets/vista_ajustes.dart';
// import 'package:my_wallet/ui/home/widgets/vista_gastos.dart';
// import 'package:my_wallet/ui/home/widgets/vista_panel.dart';

// //Widget principal de la aplicacion
// class Principal extends StatefulWidget {
//   const Principal({super.key});

//   @override
//   State<Principal> createState() => _PrincipalState();
// }
//Clase que contiene el estado del widget principal
// class _PrincipalState extends State<Principal> {
//   double montoInicial = 0;
//   late TextEditingController _montoInicialController;
//   final List<Widget> _widgetOptions = <Widget>[
//     const VistaPanel(titulo: 'Home'),
//     const VistaGastos(titulo: 'AddMonto'),
//     VistaAjustes(),
//   ];
//   double xOffset = 0;
//   double yOffset = 0;
//   bool isDrawerOpen = false;
      
//   @override
//   void initState() {
//     super.initState();
//     _montoInicialController = TextEditingController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ControlUserPerfil controlua = Get.find();
//     ControlUserAuth controluser = Get.find();
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         drawer: Drawer(
//             child: Container(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Center(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.only(bottom: 20.0),
//                       child: const Text(
//                         'MyWallet',
//                         style: TextStyle(
//                           fontSize: 24.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     const SizedBox(height: 5.0),
//                     Container(
//                       padding: const EdgeInsets.only(bottom: 20.0),
//                       child: const Text(
//                         'Bienvenido a la aplicación de gestión de gastos, en esta aplicación podras llevar un control de tus gastos y ver en que gastas tu dinero',
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.normal,
//                           color: Colors.grey,
//                         ),
//                         textAlign: TextAlign.start,
//                       ),
//                     ),
//                     const SizedBox(height: 16.0),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[900],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.monetization_on,
//                               color: Colors.white),
//                           const SizedBox(width: 5.0),
//                           Text(
//                             "$montoInicial",
//                             style: const TextStyle(
//                               fontSize: 24.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                             textAlign: TextAlign.start,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16.0),
//                     const Text(
//                       'Monto Inicial',
//                       style: TextStyle(fontSize: 24),
//                     ),
//                     const SizedBox(height: 16.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: _montoInicialController,
//                             decoration: InputDecoration(
//                               focusedBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide:
//                                     const BorderSide(color: Colors.lightGreen),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide:
//                                     const BorderSide(color: Colors.white),
//                               ),
//                               labelText: 'Digita el Inicial',
//                               labelStyle: const TextStyle(color: Colors.white),
//                               prefixIcon: const Icon(Icons.monetization_on,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(() {
//                               montoInicial =
//                                   double.parse(_montoInicialController.text);
//                             });
//                           },
//                           style: ElevatedButton.styleFrom(
//                             fixedSize: const Size(120, 50),
//                             backgroundColor: Colors.lightGreen,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: const Text(
//                             'Guardar',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 36.0),
//                     Row(
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             controluser.cerrarSesion();
//                             if (controluser.mensajesUser == "Sesion Cerrada") {
//                               Get.snackbar("Se ha cerrado la sesion",
//                                   controluser.mensajesUser,
//                                   duration: const Duration(seconds: 4),
//                                   backgroundColor:
//                                       const Color.fromARGB(255, 73, 73, 73));
//                               Get.toNamed("/login");
//                             } else {
//                               Get.snackbar("No se pudo cerrar la sesion",
//                                   controluser.mensajesUser,
//                                   duration: const Duration(seconds: 4),
//                                   backgroundColor:
//                                       const Color.fromARGB(255, 73, 73, 73));
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             fixedSize: const Size(120, 50),
//                             backgroundColor: Colors.lightGreen,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: const Text(
//                             'Cerrar Sesión',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )))),
//         appBar: AppBar(
//             title: const Text(
//               'MyWallet',
//               style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white),
//             ),
//             actions: const [
//               CircleAvatar(
//                     backgroundImage: NetworkImage('https://mi-imagen.com'),
//                     radius: 20,
//                   ),
//             ],
//             backgroundColor: Colors.lightGreen,
//             elevation: 0,
//             bottom: const TabBar(tabs: [
//               Tab(
//                 icon: Icon(Icons.home),
//               ),
//               Tab(
//                 icon: Icon(Icons.add),
//               ),
//               Tab(
//                 icon: Icon(Icons.settings),
//               ),
//             ])),
//         body: TabBarView(children: _widgetOptions), // new
//       ),
//     );
//   }
// }
