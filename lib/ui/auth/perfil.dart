import 'dart:io';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:provider/provider.dart';

class Perfil extends StatefulWidget {
  Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  ControlUserPerfil controlup = Get.find();
  ControlUserAuth controlua = Get.find();
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlUser = TextEditingController();
  TextEditingController controlPass = TextEditingController();
  TextEditingController controlProfesion = TextEditingController();
  TextEditingController controlCiudad = TextEditingController();
  TextEditingController controlDireccion = TextEditingController();
  TextEditingController controlCelular = TextEditingController();
  ImagePicker picker = ImagePicker(); // Lista de opciones
  List<String> registroSesion = [];
  bool _isDarkMode = false;
  String generoSeleccionado =
      'Masculino'; // Variable de estado para almacenar el valor seleccionado del género
  var generos = <String>[
    'Masculino',
    'Femenino',
    'Otro',
  ];
  @override
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

  void initState() {
    super.initState();
    final args =
        Get.arguments; // Obtener los argumentos pasados desde la vista anterior
    registroSesion = args ?? "";
    controlNombre.text = registroSesion[0];
    controlUser.text = registroSesion[1];
    controlPass.text = registroSesion[2];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Completar Perfil", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        color: _isDarkMode ? Colors.white : Colors.black,
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      _opcioncamara(
                        context,
                      );
                      setState(() {});
                    },
                    child: Container(
                      width: 180,
                      height: 200,
                      child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/user.png'),
                          radius: 120,
                          child: _image != null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: FileImage(_image),
                                  radius: 120,
                                )
                              : CircleAvatar(
                                  backgroundColor:
                                      Colors.black.withOpacity(0.4),
                                  radius: 120,
                                  child: Center(
                                    child: IconButton(
                                        alignment: Alignment.center,
                                        onPressed: () {
                                          _opcioncamara(
                                            context,
                                          );
                                          setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                        ),
                                        color: Colors.white),
                                  ),
                                )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                enabled: false,
                style:
                    TextStyle(color: _isDarkMode ? Colors.black : Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.black : Colors.white),
                  ),
                  labelText: controlua.userValido!.user!.email,
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.black : Colors.white),
                  prefixIcon: Icon(Icons.email,
                      color: _isDarkMode ? Colors.black : Colors.white),
                ),
              ),
              TextFormField(
                controller: controlNombre,
                style:
                    TextStyle(color: _isDarkMode ? Colors.black : Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: _isDarkMode
                            ? Colors.black
                            : Colors.white), //Color.fromARGB(255, 73, 73, 73)
                  ),
                  labelText: "Confirme su nombre",
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.black : Colors.white),
                  prefixIcon: Icon(Icons.accessibility_new,
                      color: _isDarkMode ? Colors.black : Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: controlProfesion,
                style:
                    TextStyle(color: _isDarkMode ? Colors.black : Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.black : Colors.white),
                  ),
                  labelText: 'Profesion',
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.black : Colors.white),
                  prefixIcon: Icon(Icons.psychology_rounded,
                      color: _isDarkMode ? Colors.black : Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: controlCiudad,
                style:
                    TextStyle(color: _isDarkMode ? Colors.black : Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.black : Colors.white),
                  ),
                  labelText: 'Ciudad',
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.black : Colors.white),
                  prefixIcon: Icon(Icons.add_location,
                      color: _isDarkMode ? Colors.black : Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: controlDireccion,
                style:
                    TextStyle(color: _isDarkMode ? Colors.black : Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.black : Colors.white),
                  ),
                  labelText: 'Direccion',
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.black : Colors.white),
                  prefixIcon: Icon(Icons.add_home_work,
                      color: _isDarkMode ? Colors.black : Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: controlCelular,
                style:
                    TextStyle(color: _isDarkMode ? Colors.black : Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.lightGreen),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: _isDarkMode ? Colors.black : Colors.white),
                  ),
                  labelText: 'Celular',
                  labelStyle: TextStyle(
                      color: _isDarkMode ? Colors.black : Colors.white),
                  prefixIcon: Icon(Icons.phone_android,
                      color: _isDarkMode ? Colors.black : Colors.white),
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _isDarkMode
                        ? Colors.black
                        : Colors
                            .white, // Puedes cambiar el color del borde aquí
                    width: 1.0, // Puedes ajustar el grosor del borde aquí
                  ),
                  borderRadius: BorderRadius.circular(
                      8.0), // Puedes ajustar la esquina redondeada aquí
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(
                        Icons.person, // Puedes cambiar el icono aquí
                        color: _isDarkMode ? Colors.black : Colors.white,
                      ),
                    ),
                    Expanded(
                      child: DropdownButton(
                        hint: Text(
                          'Genero',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                        dropdownColor: _isDarkMode
                            ? Colors.white.withOpacity(0.8)
                            : Colors.grey[800],
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: _isDarkMode ? Colors.black : Colors.white,
                        ),
                        iconSize: 36,
                        isExpanded: true,
                        underline: SizedBox(),
                        style: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white,
                        ),
                        value: generoSeleccionado,
                        onChanged: (newValue) {
                          setState(() {
                            generoSeleccionado = newValue
                                .toString(); // Actualiza el valor seleccionado
                          });
                        },
                        items: generos.map((valueItem) {
                          return DropdownMenuItem(
                            value: valueItem,
                            child: Text(valueItem),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  var catalogo = <String, dynamic>{
                    'id': controlua.userValido!.user!.uid,
                    'foto': _image != null ? _image.path : null,
                    'correo': controlUser.text,
                    'password': controlPass.text,
                    'estado': 'activo',
                    'nombre': controlNombre.text,
                    'genero': generoSeleccionado,
                    'profesion': controlProfesion.text,
                    'ciudad': controlCiudad.text,
                    'direccion': controlDireccion.text,
                    'celular': controlCelular.text,
                  };
                  controlup.crearPerfil(catalogo, _image);
                  if (_image != null || _image == null) {
                    Get.snackbar("Perfil Guardado Correctamente",
                        controlup.mensajesPerfil,
                        duration: Duration(seconds: 4),
                        backgroundColor: Color.fromARGB(255, 73, 73, 73));
                    Get.toNamed("/login");
                  } else {
                    controlup.crearPerfil(catalogo, null);
                    Get.snackbar("No se pudo guardar el perfil",
                        controlup.mensajesPerfil,
                        duration: Duration(seconds: 4),
                        backgroundColor: Color.fromARGB(255, 73, 73, 73));
                  }
                  //Peticiones.crearcatalogo(catalogo, _image);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: Text("Crear mi perfil",
                    style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Seleccionar la camara o la galeria

  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Imagen de Galeria'),
                      onTap: () {
                        _galeria();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Capturar Imagen'),
                    onTap: () {
                      _camara();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
