import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:provider/provider.dart';

class VistaInicial extends StatefulWidget {
  final bool theme;
  final onReturnConcept;
  VistaInicial({Key? key, required this.theme, this.onReturnConcept})
      : super(key: key);
  @override
  _VistaInicialState createState() => _VistaInicialState();
}

class _VistaInicialState extends State<VistaInicial>
    with SingleTickerProviderStateMixin {
  //VARIABLES DE CONTROL
  late AnimationController _controller;
  String concepto = 'Servicios';
  bool _isDarkMode = false;
  double fontSize = 16.0;
  double tamano = 20.0;
  String selectedItem = '';
  //VARIABLES DE ESTADO
  var navegator = 60;
  var mobile = 45;
  //LISTA DE ICONOS
  List<IconData> itemIcons = [
    Icons.build,
    Icons.shopping_bag,
    Icons.fastfood,
    Icons.directions_car,
    Icons.business,
    Icons.school,
    Icons.local_hospital,
    Icons.house,
    Icons.category,
  ];
  //LISTA DE CATEGORIAS
  List<String> itemNames = [
    'Servicios',
    'Ropa',
    'Alimentos',
    'Transporte',
    'Negocios',
    'Educación',
    'Salud',
    'Vivienda',
    'Otro',
  ];
  //LISTA DE COLORES
  List<Color> itemColors = [
    Colors.pinkAccent,
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.deepPurple,
    Color.fromARGB(255, 3, 0, 153),
    Colors.green,
    Colors.brown,
  ];

  //Callback para retornar concepto
  retornarConcepto() {
    widget.onReturnConcept(concepto);
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
      //top: y - 40,
      top: y - 30,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedItem = itemNames[index];
            concepto = itemNames[index];
          });
        },
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: _isDarkMode ? Colors.white : Colors.black,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: _isDarkMode ? Colors.black : Colors.white,
                  width: 1,
                ),
              ),
              child: Tooltip(
                //triggerMode: TooltipTriggerMode.tap,
                decoration: BoxDecoration(
                  color: _isDarkMode ? Colors.white : Colors.black,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: _isDarkMode ? Colors.white : Colors.black,
                    width: 1,
                  ),
                ),
                richMessage: TextSpan(
                  text: itemNames[index],
                  style: TextStyle(
                    color: _isDarkMode ? Colors.black : Colors.white,
                    fontSize: fontSize,
                  ),
                ),
                child: CircleAvatar(
                  backgroundColor: itemColor,
                  radius: 30,
                  child: Icon(
                    itemIcons[index],
                    color: isSelected ? itemColors[index] : Colors.white,
                  ),
                ),
              ),
            ),
            // Text(
            //   itemNames[index],
            //   style: TextStyle(
            //       color: _isDarkMode ? Colors.white : Colors.black,
            //       fontSize: fontSize),
            // ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  //Vista inicial
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
      appBar: AppBar(
        backgroundColor: _isDarkMode ? Colors.white : Colors.grey[900],
        automaticallyImplyLeading: false, // Oculta la flecha de retroceso
        centerTitle: true, // Centra el título
        title: Text(
          'Vista Inicial',
          style: TextStyle(
            color: _isDarkMode ? Colors.black : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                color: _isDarkMode ? Colors.white60 : Colors.grey[800],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selecciona una categoría',
                      style: TextStyle(
                        color: _isDarkMode ? Colors.black : Colors.white,
                        fontSize: tamano,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.category,
                      color: _isDarkMode ? Colors.black : Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.717,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
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
                                child: ElevatedButton(
                                    onPressed: () {
                                      retornarConcepto();
                                    },
                                    child: Icon(Icons.add,
                                        color: _isDarkMode
                                            ? Colors.black
                                            : Colors.white),
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: _isDarkMode
                                            ? Colors.black
                                            : Colors.white,
                                        shape: CircleBorder(),
                                        minimumSize: Size(120, 120),
                                        backgroundColor: _isDarkMode
                                            ? Color.fromARGB(255, 219, 217, 217)
                                            : Colors.grey[800])),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
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
