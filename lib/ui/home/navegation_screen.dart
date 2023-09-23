import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_wallet_app/domain/controller/controllerDineroUser.dart';
import 'package:my_wallet_app/domain/controller/controllerGastosUser.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:my_wallet_app/ui/views/vista_ajustes.dart';
import 'package:my_wallet_app/ui/views/vista_gastos.dart';
import 'package:my_wallet_app/ui/views/vista_grafica.dart';
import 'package:my_wallet_app/ui/views/vista_inicial.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NavegationScreen extends StatefulWidget {
  final String uid;
  final String foto;
  final dinero;
  final mapDinero;
  final gastos;
  final dineroGestionado;
  NavegationScreen({
    Key? key,
    required this.uid,
    required this.foto,
    this.dinero,
    this.mapDinero,
    this.gastos,
    this.dineroGestionado,
  }) : super(key: key);
  @override
  State<NavegationScreen> createState() => _NavegationScreenState();
}

class _NavegationScreenState extends State<NavegationScreen> {
  final theme = GetStorage();
  //VARIABLE GLOBAL KEY
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  //CONTROLADORES
  ControlDineroUser controldu = ControlDineroUser();
  ControlGastoUser controlgu = ControlGastoUser();
  ControlUserAuth controlua = Get.find();
  ControlUserPerfil controlPerfil = ControlUserPerfil();
  late TextEditingController _montoInicialController;
  //VARIABLES DE CONTROL
  int _page = 0;
  double tamano = 0.0;
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  String concepto = '';
  //VARIABLES DE ESTADOS
  var montoactual;
  var foto = "";
  var uid = '';

  late FocusScopeNode _focusScopeNode;
  final DateTime now = DateTime.now();
  //LISTAS
  List<int> _selectedIndexList = [0, 1, 2, 3];
  bool _isDarkMode = false;
  //Callback para retornar el producto seleccionado
  retornoProducto() {
    widget.dineroGestionado(montoactual);
  }

  void obtenerConceptoSeleccionado(String concepto) {
    this.concepto = concepto;
    setState(() {
      _page = 2;
    });
  }

  void eliminarMontoActual() {
    controldu.eliminarDinero(widget.mapDinero).then((value) => {
          if (controldu.datosDinero == true)
            {
              setState(() {
                montoactual = 0;
              })
            }
        });
  }

  void eliminarGastos() {
    controlgu.eliminarGastos(uid).then((value) => {
          widget.gastos.clear(),
          montoactual = 0,
        });
  }

  @override
  void initState() {
    super.initState();
    montoactual = widget.dinero;
    print("Este es ele monto actual: $montoactual");
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
      VistaInicial(
          theme: isDrawerOpen, onReturnConcept: obtenerConceptoSeleccionado),
      VistaGrafica(
        uid: uid,
        theme: isDrawerOpen,
        dinero: widget.dinero,
        gastos: widget.gastos,
      ),
      VistaGastos(
        uid: uid,
        theme: isDrawerOpen,
        dinero: widget.dinero,
        gastos: widget.gastos,
        concepto: concepto,
      ),
      VistaAjustes(uid: uid, theme: isDrawerOpen),
    ];
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    String formattedDate = dateFormat.format(now);
    String formattedTime = timeFormat.format(now);
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
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
            color: _isDarkMode ? Colors.white : Colors.black87,
            child: Padding(
              padding: EdgeInsets.all(0.5),
              child: Container(
                  color: _isDarkMode ? Colors.white : Colors.black87,
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
                                color: _isDarkMode
                                    ? Colors.lightGreen
                                    : Colors.white,
                                size: 50),
                            Text(
                              'Dinero Inicial',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
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
                            color: _isDarkMode ? Colors.grey : Colors.white,
                          ),
                          textAlign: TextAlign.center,
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
                            montoactual != 0
                                ? Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.634,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.monetization_on,
                                            color: Colors.white),
                                        Text(
                                          "$montoactual",
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            var mensaje =
                                                "¿Quieres eliminar el dinero inicial? se eliminaran todos los gastos asociados a este dinero";
                                            showCupertinoDialog(
                                                context: context,
                                                builder: (_) =>
                                                    _buildAlertDialog(mensaje));
                                          },
                                          icon: Icon(Icons.delete,
                                              color: Colors.white),
                                          iconSize: 20,
                                          tooltip: 'Eliminar dinero inicial',
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.red),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            )),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.634,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(Icons.monetization_on,
                                            color: Colors.white),
                                        Text(
                                          "0",
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
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Monto Inicial',
                        style: TextStyle(
                          fontSize: 24,
                          color: _isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _montoInicialController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.lightGreen),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: _isDarkMode
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                labelText: 'Digita el Inicial',
                                labelStyle: TextStyle(
                                  color:
                                      _isDarkMode ? Colors.black : Colors.white,
                                ),
                                prefixIcon: Icon(Icons.monetization_on,
                                    color: _isDarkMode
                                        ? Colors.lightGreen
                                        : Colors.white),
                              ),
                              style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          montoactual != 0
                              ? ElevatedButton(
                                  onPressed: () {
                                    var dinero = <String, dynamic>{
                                      'id': uid,
                                      'dineroInicial': double.parse(
                                          _montoInicialController.text),
                                      'fecha': formattedDate,
                                      'hora': formattedTime,
                                    };
                                    //consulta dinero inicial
                                    controldu
                                        .actualizarDinero(dinero)
                                        .then((value) => {
                                              if (controldu.datosDinero != null)
                                                {
                                                  setState(() {
                                                    controldu
                                                        .obtenerDinero(uid)
                                                        .then((value) => {
                                                              if (controldu
                                                                      .datosDinero !=
                                                                  null)
                                                                {
                                                                  _montoInicialController
                                                                      .clear(),
                                                                  setState(() {
                                                                    montoactual = controldu
                                                                        .datosDinero[
                                                                            0][
                                                                            'dineroInicial']
                                                                        .toString();
                                                                  })
                                                                }
                                                            });
                                                  })
                                                }
                                            });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(120, 50),
                                    backgroundColor: Colors.lightGreen,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Modificar',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ))
                              : ElevatedButton(
                                  onPressed: () {
                                    var dinero = <String, dynamic>{
                                      'id': uid,
                                      'dineroInicial': double.parse(
                                          _montoInicialController.text),
                                      'fecha': formattedDate,
                                      'hora': formattedTime,
                                    };
                                    //crea el dinero inicial
                                    controldu
                                        .crearDinero(dinero)
                                        .then((value) => {
                                              if (controldu.datosDinero == true)
                                                {
                                                  if (controldu
                                                          .mensajesDinero ==
                                                      "Proceso exitoso")
                                                    {
                                                      // Get.snackbar(
                                                      //     "Se ha guardado el dinero",
                                                      //     controldu
                                                      //         .mensajesDinero,
                                                      //     duration: Duration(
                                                      //         seconds: 4),
                                                      //     backgroundColor:
                                                      //         Color.fromARGB(
                                                      //             255,
                                                      //             73,
                                                      //             73,
                                                      //             73)),
                                                      //consulta dinero inicial
                                                      controldu
                                                          .obtenerDinero(uid)
                                                          .then((value) => {
                                                                if (controldu
                                                                        .datosDinero !=
                                                                    null)
                                                                  {
                                                                    setState(
                                                                        () {
                                                                      _montoInicialController
                                                                          .clear();
                                                                      montoactual = controldu
                                                                          .datosDinero[
                                                                              0]
                                                                              [
                                                                              'dineroInicial']
                                                                          .toString();
                                                                      print(
                                                                          montoactual);
                                                                    })
                                                                  }
                                                              })
                                                    }
                                                }
                                            });
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
              Icon(Icons.home,
                  size: 30, color: _isDarkMode ? Colors.white : Colors.black),
              Icon(Icons.show_chart,
                  size: 30, color: _isDarkMode ? Colors.white : Colors.black),
              Icon(Icons.attach_money_sharp,
                  size: 30, color: _isDarkMode ? Colors.white : Colors.black),
              Icon(Icons.settings,
                  size: 30, color: _isDarkMode ? Colors.white : Colors.black),
            ],
            color: Colors.lightGreen,
            buttonBackgroundColor:
                _isDarkMode ? Colors.lightGreen : Colors.white,
            backgroundColor: _isDarkMode ? Colors.white : Colors.black,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
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
                  color: _isDarkMode ? Colors.white : Colors.black),
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            backgroundColor: Colors.lightGreen,
            elevation: 0,
          ),
          //Estilos para el contenido de la aplicacion
          body: Container(
            color: _isDarkMode ? Colors.black : Colors.white,
            child: _widgetOptions[_page],
          )),
    );
  }

  Widget _buildAlertDialog(mensaje) {
    return CupertinoAlertDialog(
      title: Text('Alerta'),
      content: Text('$mensaje'),
      actions: <Widget>[
        TextButton(
            child: const Text(
              "Aceptar",
              style: TextStyle(color: Colors.green),
            ),
            onPressed: () {
              eliminarMontoActual();
              eliminarGastos();
              Navigator.of(context).pop();
            }),
      ],
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
        radius: 30,
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
        radius: 30,
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
          width: 10,
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
