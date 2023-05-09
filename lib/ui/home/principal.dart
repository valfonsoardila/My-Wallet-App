import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:my_wallet/data/services/peticionesPerfilFirebase.dart';
import 'package:my_wallet/domain/controller/controllerPerfilFirebase.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
            child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: const Text(
                        'Gestión de Gastos',
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
                                borderSide:
                                    const BorderSide(color: Colors.lightGreen),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white),
                              ),
                              labelText: 'Digita el Inicial',
                              labelStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(Icons.monetization_on,
                                  color: Colors.white),
                            ),
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
                )))),
        appBar: AppBar(
            title: const Text('Gestión de Gastos'),
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
        body: TabBarView(children: _widgetOptions), // new
      ),
    );
  }
}

class VistaPanel extends StatelessWidget {
  final String titulo;
  const VistaPanel({this.titulo = "Comming son", super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        titulo,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreen,
        ),
      ),
    );
  }
}

class VistaGastos extends StatelessWidget {
  final String titulo;
  const VistaGastos({this.titulo = "Comming son", super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        titulo,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.lightGreen,
        ),
      ),
    );
  }
}

class VistaAjustes extends StatefulWidget {
  @override
  State<VistaAjustes> createState() => _VistaAjustesState();
}

class _VistaAjustesState extends State<VistaAjustes> {
  ControlUserPerfil controlup = Get.find();

  TextEditingController controlNombre = TextEditingController();

  TextEditingController controlApellido = TextEditingController();

  TextEditingController controlProfesion = TextEditingController();

  TextEditingController controlCiudad = TextEditingController();

  TextEditingController controlDireccion = TextEditingController();

  TextEditingController controlCelular = TextEditingController();

  TextEditingController controlObser = TextEditingController();

  ImagePicker picker = ImagePicker();

  var _image;

  _galeria() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
      //_image = File(image!.path);
    });
  }

  _camara() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
      // _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Center(),
    );
  }
}
