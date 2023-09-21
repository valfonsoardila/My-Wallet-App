import 'package:flutter/material.dart';
import 'package:my_wallet_app/domain/controller/controllerUserFirebase.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:my_wallet_app/ui/models/theme_model.dart';

class VistaAjustes extends StatefulWidget {
  final bool theme;
  final String uid;
  VistaAjustes({Key? key, required this.uid, required this.theme})
      : super(key: key);
  @override
  _VistaAjustes createState() => _VistaAjustes();
}

class _VistaAjustes extends State<VistaAjustes> {
  //STORAGE
  final theme = GetStorage();
  final sizeLetter = GetStorage();
  //CONTROLLERS
  ControlUserAuth controlua = Get.find();
  ControlUserPerfil controlPerfil = Get.find();
  TextEditingController controlCorreo = TextEditingController();
  TextEditingController controlPassword = TextEditingController();
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlGenero = TextEditingController();
  TextEditingController controlApellido = TextEditingController();
  TextEditingController controlProfesion = TextEditingController();
  TextEditingController controlCiudad = TextEditingController();
  TextEditingController controlDireccion = TextEditingController();
  TextEditingController controlCelular = TextEditingController();
  TextEditingController controlObser = TextEditingController();
  TextEditingController controlURL = TextEditingController();
  ImagePicker picker = ImagePicker();
  //VARIABLES DE CONTROL
  bool _showPassword =
      false; // Variable para controlar si se muestra el texto oculto o no
  bool _isDarkMode = false;
  double fontSize = 16.0;
  double tamano = 20.0;
  String generoSeleccionado = 'Masculino';
  bool isUrlImage = false;
  //VARIABLES DE ESTADO
  var _image;
  var correo = "";
  var nombre = "";
  var profesion = "";
  var ciudad = "";
  var direccion = "";
  var celular = "";
  var foto = "";
  var uid = '';
  //LISTAS
  var generos = <String>[
    'Masculino',
    'Femenino',
    'Otro',
  ];

  //FUNCIONES
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

  //FUNCIONES
  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
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
          );
        });
  }

  void _mostrarGestionPerfil(Future<Map<String, dynamic>> perfil) {
    controlCorreo.text = controlPerfil.datosPerfil['correo'];
    controlPassword.text = controlPerfil.datosPerfil['password'];
    controlNombre.text = controlPerfil.datosPerfil['nombre'];
    controlGenero.text = controlPerfil.datosPerfil['genero'];
    controlProfesion.text = controlPerfil.datosPerfil['profesion'];
    controlCiudad.text = controlPerfil.datosPerfil['ciudad'];
    controlDireccion.text = controlPerfil.datosPerfil['direccion'];
    controlCelular.text = controlPerfil.datosPerfil['celular'];
    controlURL.text = controlPerfil.datosPerfil['foto'];
    if (controlURL.text != '') {
      isUrlImage = true;
      print('URL: ${controlPerfil.datosPerfil['foto']}');
    } else {
      isUrlImage = false;
      print('esta vacio');
    }

    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          width: 300, // Establece el ancho deseado
          height: 200, // Establece la altura deseada
          child: AlertDialog(
            backgroundColor: _isDarkMode
                ? Colors.grey[200]
                : Color.fromARGB(255, 19, 18, 18),
            title: Text(
              'Datos de Perfil',
              style:
                  TextStyle(color: _isDarkMode ? Colors.black : Colors.white),
            ),
            content: Container(
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  //Agregar los campos necesarios
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              _opcioncamara(context);
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                              height: 200,
                              width: double.maxFinite,
                              child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                  child: Image.network(
                                      isUrlImage
                                          ? controlPerfil.datosPerfil['foto']
                                          : 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          'Datos de acceso',
                          style: TextStyle(
                              color: _isDarkMode ? Colors.black : Colors.white),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: controlCorreo,
                          style: TextStyle(
                              color: _isDarkMode ? Colors.black : Colors.white),
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
                                      : Colors.white),
                            ),
                            labelText: 'Correo electrónico',
                            labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                            prefixIcon: Icon(Icons.email,
                                color:
                                    _isDarkMode ? Colors.black : Colors.white),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: controlPassword,
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
                          obscureText: !_showPassword, // ¡Cambia aquí!
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
                                      : Colors.white),
                            ),
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showPassword =
                                      !_showPassword; // ¡Cambia aquí!
                                });
                              },
                              child: Icon(
                                _showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese su contraseña';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          'Datos personales',
                          style: TextStyle(
                              color: _isDarkMode ? Colors.black : Colors.white),
                        ),
                        SizedBox(height: 12.0),
                        TextFormField(
                          controller: controlNombre,
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
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
                                      : Colors.white),
                            ),
                            labelText: 'Nombre',
                            labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                            prefixIcon: Icon(
                              Icons.accessibility_new,
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        DropdownButtonFormField<String>(
                          dropdownColor: _isDarkMode
                              ? Colors.grey[200]
                              : Color.fromARGB(255, 29, 29, 29),
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: _isDarkMode
                                ? Color.fromARGB(255, 29, 29, 29)
                                : Colors.white,
                          ),
                          iconSize: 36,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: _isDarkMode
                                    ? Color.fromARGB(255, 29, 29, 29)
                                    : Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.lightGreen),
                            ),
                          ),
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
                          value: generoSeleccionado,
                          onChanged: (newValue) {
                            setState(() {
                              generoSeleccionado = newValue!;
                            });
                          },
                          items: generos.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: controlProfesion,
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
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
                                      : Colors.white),
                            ),
                            labelText: 'Profesión',
                            labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                            prefixIcon: Icon(Icons.psychology_rounded,
                                color:
                                    _isDarkMode ? Colors.black : Colors.white),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: controlCiudad,
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
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
                                      : Colors.white),
                            ),
                            labelText: 'Ciudad',
                            labelStyle: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white),
                            prefixIcon: Icon(
                              Icons.add_location,
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: controlDireccion,
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
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
                                      : Colors.white),
                            ),
                            labelText: 'Direccion',
                            labelStyle: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white),
                            prefixIcon: Icon(
                              Icons.add_home_work,
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: controlCelular,
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
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
                                      : Colors.white),
                            ),
                            labelText: 'Celular',
                            labelStyle: TextStyle(
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                            prefixIcon: Icon(Icons.phone_android,
                                color:
                                    _isDarkMode ? Colors.black : Colors.white),
                          ),
                        ),
                        SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Lógica para guardar los cambios realizados en el perfil
                  Navigator.of(context).pop();
                  var catalogo = <String, dynamic>{
                    'id': controlua.userValido!.user!.uid,
                    'foto': _image != null ? _image.path : null,
                    'correo': controlCorreo.text,
                    'password': controlPassword.text,
                    'estado': 'activo',
                    'nombre': controlNombre.text,
                    'genero': generoSeleccionado,
                    'profesion': controlProfesion.text,
                    'ciudad': controlCiudad.text,
                    'direccion': controlDireccion.text,
                    'celular': controlCelular.text,
                  };
                  controlPerfil.actualizarPerfil(catalogo, _image);
                  if (_image != null || _image == null) {
                    Get.snackbar("Perfil Guardado Correctamente",
                        controlPerfil.mensajesPerfil,
                        duration: Duration(seconds: 4),
                        backgroundColor: const Color.fromARGB(255, 73, 73, 73));
                    Get.toNamed("/login");
                  } else {
                    controlPerfil.actualizarPerfil(catalogo, null);
                    Get.snackbar("No se pudo guardar el perfil",
                        controlPerfil.mensajesPerfil,
                        duration: const Duration(seconds: 4),
                        backgroundColor: const Color.fromARGB(255, 73, 73, 73));
                  }
                },
                child: Text('Guardar',
                    style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.lightGreen)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar',
                    style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.lightGreen)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _mostrarPopup() {
    setState(() {
      showDialog(
          barrierColor: _isDarkMode
              ? Colors.white.withOpacity(0.5)
              : Colors.black.withOpacity(0.5),
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                backgroundColor: _isDarkMode
                    ? Colors.white
                    : Color.fromARGB(255, 19, 18, 18),
                title: Text('Ajustar tamaño',
                    style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.white)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tamaño actual: $tamano',
                        style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white)),
                    Slider(
                      value: tamano,
                      min: 0.0,
                      max: 24.0,
                      divisions: 12,
                      label: '$tamano',
                      onChanged: (double newValue) {
                        setState(() {
                          tamano = newValue;
                        });
                      },
                      activeColor: Colors.lightGreen, // Cambio de color aquí
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        tamano = tamano;
                      });
                      // Lógica para guardar los cambios y actualizar la vista
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Aceptar',
                      style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.lightGreen,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.lightGreen,
                      ),
                    ),
                  ),
                ],
              );
            });
          });
    });
  }

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
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
      backgroundColor: _isDarkMode ? Colors.white : Colors.black,
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person,
                color: _isDarkMode ? Colors.black : Colors.white),
            title: Text('Gestión de Perfil',
                style: TextStyle(
                    color: _isDarkMode ? Colors.black : Colors.white,
                    fontSize: tamano)),
            onTap: () {
              // Lógica para gestionar el perfil del usuario
              var perfil = controlPerfil.obtenerPerfil(uid);
              _mostrarGestionPerfil(perfil);
            },
          ),
          ListTile(
            leading: Icon(
              _isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: _isDarkMode ? Colors.black : Colors.white,
            ),
            title: Text(
              _isDarkMode ? 'Dark Mode' : 'Light Mode',
              style: TextStyle(
                color: _isDarkMode ? Colors.black : Colors.white,
                fontSize: tamano,
              ),
            ),
            trailing: Switch(
              activeColor: Colors.lightGreen,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey,
              value: _isDarkMode,
              onChanged: (value) {
                setState(() {
                  _isDarkMode = !_isDarkMode;
                  if (_isDarkMode) {
                    theme.setTheme(ThemeData.dark());
                  } else {
                    theme.setTheme(ThemeData.light());
                  }
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.format_size,
                color: _isDarkMode ? Colors.black : Colors.white),
            title: Text('Tamaño de Letra',
                style: TextStyle(
                    color: _isDarkMode ? Colors.black : Colors.white,
                    fontSize: tamano)),
            onTap: () {
              setState(() {
                _mostrarPopup();
                sizeLetter.write('size', tamano);
              });
            },
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 220,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.person,
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                size: 16,
                              ),
                            ),
                            Text(
                              'Desarrollador: ',
                              style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Lógica para abrir el perfil de GitHub
                              },
                              child: Text('GitHub',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        width: 235,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.email,
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                size: 18,
                              ),
                            ),
                            Text(
                              'Correo: ',
                              style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Lógica para abrir el perfil de LinkedIn
                              },
                              child: Text('victoradila@gmail.com'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Container(
                        width: 220,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.phone,
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                size: 16,
                              ),
                            ),
                            Text(
                              'Celular:',
                              style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Lógica para abrir el perfil de LinkedIn
                              },
                              child: Text('+57 314 713 3334',
                                  style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
