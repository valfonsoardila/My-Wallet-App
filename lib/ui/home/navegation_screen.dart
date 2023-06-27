import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_wallet_app/domain/controller/controllerDineroUser.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/ui/views/vista_ajustes.dart';
import 'package:my_wallet_app/ui/views/vista_gastos.dart';
import 'package:my_wallet_app/ui/views/vista_grafica.dart';
import 'package:my_wallet_app/ui/views/vista_inicial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class NavegationScreen extends StatefulWidget {
  final String uid;
  final String foto;
  final String dinero;

  NavegationScreen(
      {Key? key, required this.uid, required this.foto, required this.dinero})
      : super(key: key);
  @override
  State<NavegationScreen> createState() => _NavegationScreenState();
}

class _NavegationScreenState extends State<NavegationScreen> {
  final theme = GetStorage();
  //VARIABLE GLOBAL KEY
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  //CONTROLADORES
  ControlDineroUser controldu = ControlDineroUser();
  ControlUserAuth controlua = Get.find();
  ControlUserPerfil controlPerfil = ControlUserPerfil();
  late TextEditingController _montoInicialController;
  //VARIABLES DE CONTROL
  int _page = 0;
  bool isDarkMode = false;
  double tamano = 0.0;
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  //VARIABLES DE ESTADOS
  var montoactual;
  var foto = "";
  var uid = '';

  late FocusScopeNode _focusScopeNode;
  final DateTime now = DateTime.now();
  //LISTAS
  List<int> _selectedIndexList = [0, 1, 2, 3];

  void verificadorDeCambios() {
    Timer.periodic(Duration(microseconds: 1), (timer) {
      setState(() {
        isDarkMode = theme.read('theme') ?? false;
      });
    });
  }

  void consultarTema() {
    setState(() {
      isDarkMode = theme.read('theme') ?? false;
    });
    verificadorDeCambios();
  }

  @override
  void initState() {
    super.initState();
    consultarTema();
    _montoInicialController = TextEditingController();
    _focusScopeNode = FocusScopeNode();
    uid = widget.uid;
    foto = widget.foto;
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      VistaInicial(theme: isDrawerOpen),
      VistaGrafica(theme: isDrawerOpen),
      VistaGastos(uid: uid, theme: isDrawerOpen),
      VistaAjustes(uid: uid, theme: isDrawerOpen),
    ];
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    String formattedDate = dateFormat.format(now);
    String formattedTime = timeFormat.format(now);
    Color _getBackgroundColor(bool isDarkMode) {
      return isDarkMode ? Colors.black : Colors.white;
    }

    Color _getButtonBackgroundColor(bool isDarkMode) {
      return isDarkMode ? Colors.white : Colors.lightGreen;
    }

    //Animacion para el menu
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? 0 : 0),
      // ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      //Vista principal
      child: Scaffold(
          //vista del panel lateral
          endDrawer: Drawer(
              child: Container(
            color: Colors.lightGreenAccent[700],
            child: Padding(
              padding: EdgeInsets.all(0.5),
              child: Container(
                  color: isDarkMode ? Colors.black : Colors.white,
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 15.0),
                            Icon(Icons.point_of_sale,
                                color: Colors.lightGreen, size: 50),
                            Text(
                              'Dinero Inicial',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Container(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Bienvenido a la aplicación de gestión de gastos, en esta aplicación podras llevar un control de tus gastos y ver en que gastas tu dinero',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            color: isDarkMode ? Colors.grey : Colors.black,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.monetization_on, color: Colors.white),
                            SizedBox(width: 5.0),
                            Text(
                              "$montoactual",
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Monto Inicial',
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _montoInicialController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.lightGreen),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelText: 'Digita el Inicial',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(Icons.monetization_on,
                                    color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                              var dinero = <String, dynamic>{
                                'id': uid,
                                'dineroInicial': _montoInicialController.text,
                                'fecha': formattedDate,
                                'hora': formattedTime,
                              };
                              controldu.crearDinero(dinero);
                              if (_montoInicialController != 0) {
                                if (controldu.mensajesDinero ==
                                    "Proceso exitoso") {
                                  Get.snackbar("Se ha guardado el dinero",
                                      controldu.mensajesDinero,
                                      duration: Duration(seconds: 4),
                                      backgroundColor:
                                          Color.fromARGB(255, 73, 73, 73));
                                } else {
                                  Get.snackbar("No se pudo guardar el dinero",
                                      controldu.mensajesDinero,
                                      duration: Duration(seconds: 4),
                                      backgroundColor:
                                          Color.fromARGB(255, 73, 73, 73));
                                }
                              }
                              // setState(() {
                              //   montoInicial = double.parse(
                              //       _montoInicialController.text);
                              // });
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(120, 50),
                              backgroundColor: Colors.lightGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
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
          //Estilos para el panel de navegacion inferior de la aplicacion
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _selectedIndexList[_page],
            height: 60.0,
            items: <Widget>[
              Icon(Icons.home, size: 30),
              Icon(Icons.show_chart, size: 30),
              Icon(Icons.attach_money_sharp, size: 30),
              Icon(Icons.settings, size: 30),
            ],
            color: Colors.lightGreen,
            buttonBackgroundColor: _getButtonBackgroundColor(isDarkMode),
            backgroundColor: _getBackgroundColor(isDarkMode),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
                isDarkMode = theme.read('theme') ?? false;
              });
            },
            letIndexChange: (index) => true,
          ),
          //Estilos del panel superior de la aplicacion
          appBar: AppBar(
            leading: SizedBox(
              width: 20, // Ajusta el ancho según sea necesario
              child: isDrawerOpen
                  ? GestureDetector(
                      child: CircleAvatarOpen(img: foto, text: ''),
                      onTap: () {
                        setState(() {
                          xOffset = 0;
                          yOffset = 0;
                          isDrawerOpen = false;
                        });
                      },
                    )
                  : GestureDetector(
                      child: CircleAvatarClose(img: foto, text: ''),
                      onTap: () {
                        setState(() {
                          FocusScope.of(context).unfocus(); // Cierra el teclado
                          xOffset = 290;
                          yOffset = 80;
                          isDrawerOpen = true;
                        });
                      },
                    ),
            ),
            title: Text(
              'Gestion de gastos',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            elevation: 0,
          ),
          //Estilos para el contenido de la aplicacion
          body: Container(
            color: isDarkMode ? Colors.black : Colors.white,
            child: Center(
              child: _widgetOptions[_page],
            ),
          )),
    );
  }
}

class NewPadding extends StatelessWidget {
  final String image1;
  final String text1;
  final String image2;
  final String text2;

  NewPadding({
    Key? key,
    required this.image1,
    required this.text1,
    required this.image2,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35),
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
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Image(
                    height: 100,
                    width: 100,
                    image: AssetImage(image1),
                  ),
                ),
                Text(
                  text1,
                  style: TextStyle(
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
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Image(
                    height: 100,
                    width: 100,
                    image: AssetImage(image2),
                  ),
                ),
                Text(
                  text2,
                  style: TextStyle(
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

//Clase para el avatar del panel superior de la aplicacion
class CircleAvatarOpen extends StatelessWidget {
  final dynamic img;
  final String text;

  CircleAvatarOpen({
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
        radius: 25,
        backgroundImage: NetworkImage(img),
        child: Container(
          alignment: Alignment.center,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      );
    } else {
      // Si img no es una URL válida, carga la imagen desde el recurso local
      imageWidget = CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/user.png'),
        child: Container(
          alignment: Alignment.center,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: imageWidget),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

//Clase para el avatar del panel superior de la aplicacion
class CircleAvatarClose extends StatelessWidget {
  final dynamic img;
  final String text;

  CircleAvatarClose({
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
        radius: 25,
        backgroundImage: NetworkImage(img),
      );
    } else {
      // Si img no es una URL válida, carga la imagen desde el recurso local
      imageWidget = CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/user.png'),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(child: imageWidget),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
