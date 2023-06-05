// import 'package:flutter/material.dart';
// import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class VistaAjustes extends StatefulWidget {
//   @override
//   State<VistaAjustes> createState() => _VistaAjustesState();
// }

// class _VistaAjustesState extends State<VistaAjustes> {
//   ControlUserPerfil controlup = Get.find();
//   TextEditingController controlNombre = TextEditingController();
//   TextEditingController controlApellido = TextEditingController();
//   TextEditingController controlProfesion = TextEditingController();
//   TextEditingController controlCiudad = TextEditingController();
//   TextEditingController controlDireccion = TextEditingController();
//   TextEditingController controlCelular = TextEditingController();
//   TextEditingController controlObser = TextEditingController();
//   ImagePicker picker = ImagePicker();
//   var _image;
//   _galeria() async {
//     XFile? image =
//         await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
//     setState(() {
//       _image = (image != null) ? File(image.path) : null;
//       //_image = File(image!.path);
//     });
//   }

//   _camara() async {
//     XFile? image =
//         await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

//     setState(() {
//       _image = (image != null) ? File(image.path) : null;
//       // _image = File(image!.path);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:  EdgeInsets.all(10.0),
//       child: SingleChildScrollView(
//         // Agregar SingleChildScrollView aquí
//         child: Container(
//           color: Colors.black,
//           padding:  EdgeInsets.all(10.0),
//           child: Center(
//             child: ListView(
//               shrinkWrap: true,
//               children: <Widget>[
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       _opcioncamara(context);
//                     },
//                     child: Container(
//                       padding:  EdgeInsets.fromLTRB(10, 10, 10, 0),
//                       height: 220,
//                       width: double.maxFinite,
//                       child: Card(
//                         elevation: 5,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(80.0),
//                         ),
//                         child: _image != null
//                             ? Image.file(
//                                 _image,
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.fitHeight,
//                               )
//                             : Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.grey[800],
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),
//                  SizedBox(height: 10.0),
//                 TextFormField(
//                   controller: controlNombre,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.lightGreen),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.white),
//                     ),
//                     labelText: 'Nombre',
//                     labelStyle:  TextStyle(color: Colors.white),
//                     prefixIcon:  Icon(Icons.accessibility_new,
//                         color: Colors.white),
//                   ),
//                 ),
//                  SizedBox(height: 8.0),
//                 TextFormField(
//                   controller: controlApellido,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.lightGreen),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.white),
//                     ),
//                     labelText: 'Apellido',
//                     labelStyle:  TextStyle(color: Colors.white),
//                     prefixIcon:  Icon(Icons.accessibility_sharp,
//                         color: Colors.white),
//                   ),
//                 ),
//                  SizedBox(height: 8.0),
//                 TextFormField(
//                   controller: controlProfesion,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.lightGreen),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.white),
//                     ),
//                     labelText: 'Profesion',
//                     labelStyle:  TextStyle(color: Colors.white),
//                     prefixIcon:  Icon(Icons.psychology_rounded,
//                         color: Colors.white),
//                   ),
//                 ),
//                  SizedBox(height: 8.0),
//                 TextFormField(
//                   controller: controlCiudad,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.lightGreen),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.white),
//                     ),
//                     labelText: 'Ciudad',
//                     labelStyle:  TextStyle(color: Colors.white),
//                     prefixIcon:
//                          Icon(Icons.add_location, color: Colors.white),
//                   ),
//                 ),
//                  SizedBox(height: 8.0),
//                 TextFormField(
//                   controller: controlDireccion,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.lightGreen),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.white),
//                     ),
//                     labelText: 'Direccion',
//                     labelStyle:  TextStyle(color: Colors.white),
//                     prefixIcon:
//                          Icon(Icons.add_home_work, color: Colors.white),
//                   ),
//                 ),
//                  SizedBox(height: 8.0),
//                 TextFormField(
//                   controller: controlCelular,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.lightGreen),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.white),
//                     ),
//                     labelText: 'Celular',
//                     labelStyle:  TextStyle(color: Colors.white),
//                     prefixIcon:
//                          Icon(Icons.phone_android, color: Colors.white),
//                   ),
//                 ),
//                  SizedBox(height: 8.0),
//                 TextFormField(
//                   controller: controlObser,
//                   decoration: InputDecoration(
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.lightGreen),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide:  BorderSide(color: Colors.white),
//                     ),
//                     labelText: 'Observacion',
//                     labelStyle:  TextStyle(color: Colors.white),
//                     prefixIcon:  Icon(Icons.account_balance_wallet_sharp,
//                         color: Colors.white),
//                   ),
//                 ),
//                  SizedBox(height: 10.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     var catalogo = <String, dynamic>{
//                       'nombre': controlNombre.text,
//                       'apellido': controlApellido.text,
//                       'profesion': controlProfesion.text,
//                       'ciudad': controlCiudad.text,
//                       'direccion': controlDireccion.text,
//                       'celular': controlCelular.text,
//                       'foto': ''
//                     };
//                     controlup.crearcatalogo(catalogo, _image);
//                     if (_image != null || _image == null) {
//                       Get.snackbar("Perfil Guardado Correctamente",
//                           controlup.mensajesPerfil,
//                           duration:  Duration(seconds: 4),
//                           backgroundColor:
//                                Color.fromARGB(255, 73, 73, 73));
//                     } else {
//                       controlup.crearcatalogo(catalogo, null);
//                       Get.snackbar("No se pudo guardar el perfil",
//                           controlup.mensajesPerfil,
//                           duration:  Duration(seconds: 4),
//                           backgroundColor:
//                                Color.fromARGB(255, 73, 73, 73));
//                     }
//                     //Peticiones.crearcatalogo(catalogo, _image);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white,
//                     backgroundColor: Colors.lightGreen,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(32.0),
//                     ),
//                   ),
//                   child:  Text("Guardar"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   //Opciones de camara y galeria
//   void _opcioncamara(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Wrap(
//               children: <Widget>[
//                 ListTile(
//                     leading:  Icon(Icons.photo_library),
//                     title:  Text('Imagen de Galeria'),
//                     onTap: () {
//                       _galeria();
//                       Navigator.of(context).pop();
//                     }),
//                 ListTile(
//                   leading:  Icon(Icons.photo_camera),
//                   title:  Text('Capturar Imagen'),
//                   onTap: () {
//                     _camara();
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet_app/domain/controller/controllerPerfilUser.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class VistaAjustes extends StatefulWidget {
  @override
  _VistaAjustes createState() => _VistaAjustes();
}

class _VistaAjustes extends State<VistaAjustes> {
  bool isDarkMode = false;
  double fontSize = 16.0;
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

  //Opciones de camara y galeria
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

  void _mostrarGestionPerfil() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          width: 300, // Establece el ancho deseado
          height: 200, // Establece la altura deseada
          child: AlertDialog(
            backgroundColor:
                isDarkMode ? Color.fromARGB(255, 19, 18, 18) : Colors.white,
            title: Text(
              'Datos de Perfil',
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            content: Container(
              color:
                  isDarkMode ? Color.fromARGB(255, 19, 18, 18) : Colors.white,
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Container(
                  color: isDarkMode
                      ? Color.fromARGB(255, 19, 18, 18)
                      : Colors.white,
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
                                child: _image != null
                                    ? Image.file(
                                        _image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitHeight,
                                      )
                                    : Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          //controller: controlNombre,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.lightGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: 'Nombre',
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color.fromARGB(255, 29, 29, 29)),
                            prefixIcon: Icon(Icons.accessibility_new,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          //controller: controlApellido,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.lightGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: 'Apellido',
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color.fromARGB(255, 29, 29, 29)),
                            prefixIcon: Icon(Icons.accessibility_sharp,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          //controller: controlProfesion,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.lightGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: 'Profesion',
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color.fromARGB(255, 29, 29, 29)),
                            prefixIcon: Icon(Icons.psychology_rounded,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          //controller: controlCiudad,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.lightGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: 'Ciudad',
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color.fromARGB(255, 29, 29, 29)),
                            prefixIcon: Icon(Icons.add_location,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          //controller: controlDireccion,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.lightGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: 'Direccion',
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color.fromARGB(255, 29, 29, 29)),
                            prefixIcon: Icon(Icons.add_home_work,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          //controller: controlCelular,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.lightGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: 'Celular',
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color.fromARGB(255, 29, 29, 29)),
                            prefixIcon: Icon(Icons.phone_android,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          //controller: controlObser,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.lightGreen),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            labelText: 'Observacion',
                            labelStyle: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : const Color.fromARGB(255, 29, 29, 29)),
                            prefixIcon: Icon(Icons.account_balance_wallet_sharp,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                          ),
                        ),
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
                },
                child: Text('Guardar',
                    style: TextStyle(
                        color: isDarkMode ? Colors.lightGreen : Colors.black)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar',
                    style: TextStyle(
                        color: isDarkMode ? Colors.lightGreen : Colors.black)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      // appBar: AppBar(
      //   title: Text('Configuración de Usuario',
      //       style: TextStyle(
      //           color: isDarkMode ? Colors.white : Colors.black,
      //           fontSize: fontSize)),
      //   backgroundColor: isDarkMode ? Colors.lightGreen : Colors.transparent,
      // ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person,
                color: isDarkMode ? Colors.grey : Colors.black),
            title: Text('Gestión de Perfil',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              // Lógica para gestionar el perfil del usuario
              _mostrarGestionPerfil();
            },
          ),
          ListTile(
            leading: Icon(
              isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
              color: isDarkMode ? Colors.grey : Colors.black,
            ),
            title: Text(
              isDarkMode ? 'Dark Mode' : 'Light Mode',
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                  // Lógica para cambiar el tema de la aplicación
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.format_size,
                color: isDarkMode ? Colors.grey : Colors.black),
            title: Text('Tamaño de Letra',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.black)),
            onTap: () {
              // Lógica para cambiar el tamaño de la letra
            },
          ),
          Spacer(),
          Container(
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
                              color: isDarkMode ? Colors.grey : Colors.black,
                              size: 15,
                            ),
                          ),
                          Text(
                            'Desarrollado por: ',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Lógica para abrir el perfil de GitHub
                            },
                            child: Text('GitHub'),
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
                              Icons.email,
                              color: isDarkMode ? Colors.grey : Colors.black,
                              size: 15,
                            ),
                          ),
                          Text(
                            'usuario_de_correo_electronico',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
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
                              color: isDarkMode ? Colors.grey : Colors.black,
                              size: 15,
                            ),
                          ),
                          Text(
                            'número_de_teléfono',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
