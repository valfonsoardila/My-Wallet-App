import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class VistaInicial extends StatefulWidget {
  final bool theme;
  VistaInicial({Key? key, required this.theme}) : super(key: key);
  @override
  _VistaInicialState createState() => _VistaInicialState();
}

class _VistaInicialState extends State<VistaInicial>
    with SingleTickerProviderStateMixin {
  //STORAGE
  final theme = GetStorage();
  final sizeLetter = GetStorage();
  //VARIABLES DE CONTROL
  late AnimationController _controller;
  bool isDarkMode = false;
  double fontSize = 16.0;
  double tamano = 20.0;
  String selectedItem = '';
  //VARIABLES DE ESTADO
  var navegator = 60;
  var mobile = 45;
  //LISTA DE ICONOS
  List<IconData> itemIcons = [
    Icons.directions_car,
    Icons.fastfood,
    Icons.shopping_bag,
    Icons.build,
    Icons.category,
  ];
  //LISTA DE CATEGORIAS
  List<String> itemNames = [
    'Transporte',
    'Alimentos',
    'Ropa',
    'Servicios',
    'Otro',
  ];
  //LISTA DE COLORES
  List<Color> itemColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];
  //METODOS
  void consultarTema() {
    setState(() {
      isDarkMode = theme.read('theme') ?? false;
    });
  }

  void consultarTamanoLetra() {
    setState(() {
      tamano = sizeLetter.read('size') ?? 16.0;
    });
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      mobile = navegator;
      print("Estoy en web");
    } else {
      mobile = 45;
      print("Estoy en movil");
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    consultarTema();
    consultarTamanoLetra();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Widget para dimensionar el tamaño de los iconos
  Widget buildItem(
      int index, Animation<double> animation, double containerSize) {
    bool isSelected = selectedItem == itemNames[index];
    Color itemColor = isSelected ? Colors.white : itemColors[index];

    final double radius = containerSize / 2;
    final double angle =
        (2 * pi * index / itemIcons.length) + (2 * pi * _controller.value);

    final double x = radius + (radius - mobile) * cos(angle);
    final double y = radius + (radius - mobile) * sin(angle);

    return Positioned(
      left: x - 30,
      top: y - 40,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedItem = itemNames[index];
          });
        },
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: itemColor,
              radius: 30,
              child: Icon(
                itemIcons[index],
                color: isSelected ? itemColors[index] : Colors.white,
              ),
            ),
            Text(
              itemNames[index],
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Widget buildItem(
  //     int index, Animation<double> animation, double containerSize) {
  //   bool isSelected = selectedItem == itemNames[index];
  //   Color itemColor = isSelected ? Colors.white : itemColors[index];

  //   final double radius = containerSize / 2;
  //   final double angle =
  //       (2 * pi * index / itemIcons.length) + (2 * pi * _controller.value);
  //   //Posicion de los iconos
  //   final double x = (radius - 60) * cos(angle) + radius;
  //   final double y = (radius - 60) * sin(angle) + radius;
  //   //Iconos de las categorias
  //   return Positioned(
  //     left: x - 30,
  //     top: y - 30,
  //     child: GestureDetector(
  //       onTap: () {
  //         setState(() {
  //           selectedItem = itemNames[index];
  //         });
  //       },
  //       child: Column(
  //         children: [
  //           Text(
  //             itemNames[index],
  //             style: TextStyle(color: Colors.white),
  //           ),
  //           CircleAvatar(
  //             backgroundColor: itemColor,
  //             radius: 30,
  //             child: Icon(itemIcons[index],
  //                 color: isSelected ? itemColors[index] : Colors.white),
  //           ),
  //           SizedBox(height: 8),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //Vista inicial
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Center(
          child: Text(
            'Vista Inicial',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Selecciona una categoría',
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: tamano,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.category,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final double containerSize =
                        MediaQuery.of(context).size.width * 0.75;
                    return Stack(
                      children: [
                        Container(
                          width: containerSize,
                          height: containerSize,
                          child: CustomPaint(
                            painter: CirclePainter(
                              radius: containerSize / 1.8,
                              colors: itemColors,
                            ),
                            child: Stack(
                              children: [
                                for (int i = 0; i < itemIcons.length; i++)
                                  buildItem(i, _controller, containerSize),
                              ],
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // Lógica cuando se toca el botón circular en el centro
                              },
                              child: CircleAvatar(
                                radius: containerSize * 0.2,
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                child:
                                    Icon(Icons.add, color: Colors.lightGreen),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double radius;
  final List<Color> colors;

  CirclePainter({required this.radius, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    final double sectionAngle = 2 * pi / colors.length;

    for (int i = 0; i < colors.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        i * sectionAngle,
        sectionAngle,
        true,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



// class _VistaInicialState extends State<VistaInicial>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   var pi = 3.1415926535897932;
//   List<IconData> itemIcons = [
//     Icons.directions_car,
//     Icons.fastfood,
//     Icons.shopping_bag,
//     Icons.build,
//     Icons.category,
//   ];
//   List<String> itemNames = [
//     'Transporte',
//     'Alimentos',
//     'Ropa',
//     'Servicios',
//     'Otro',
//   ];
//   String selectedItem = '';

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Widget buildItem(
//       int index, Animation<double> animation, double containerSize) {
//     bool isSelected = selectedItem == itemNames[index];
//     Color itemColor = isSelected ? Colors.green : Colors.grey;

//     final double radius = containerSize / 2;
//     final double angle =
//         (2 * pi * index / itemIcons.length) + (2 * pi * _controller.value);

//     final double x = (radius - 60) * cos(angle) + radius;
//     final double y = (radius - 60) * sin(angle) + radius;

//     return Positioned(
//       left: x - 30,
//       top: y - 30,
//       child: GestureDetector(
//         onTap: () {
//           setState(() {
//             selectedItem = itemNames[index];
//           });
//         },
//         child: Column(
//           children: [
//             CircleAvatar(
//               backgroundColor: itemColor,
//               radius: 30,
//               child: Icon(itemIcons[index], color: Colors.white),
//             ),
//             SizedBox(height: 8),
//             Text(
//               itemNames[index],
//               style: TextStyle(color: itemColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Vista Inicial'),
//       ),
//       body: Center(
//         child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//             final double containerSize =
//                 MediaQuery.of(context).size.width * 0.7;
//             return Stack(
//               children: [
//                 Container(
//                   width: containerSize,
//                   height: containerSize,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.grey,
//                   ),
//                   child: Stack(
//                     children: [
//                       for (int i = 0; i < itemIcons.length; i++)
//                         buildItem(i, _controller, containerSize),
//                     ],
//                   ),
//                 ),
//                 Positioned.fill(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: GestureDetector(
//                       onTap: () {
//                         // Lógica cuando se toca el botón circular en el centro
//                       },
//                       child: CircleAvatar(
//                         radius: containerSize * 0.1,
//                         backgroundColor: Colors.blue,
//                         child: Icon(Icons.add, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
