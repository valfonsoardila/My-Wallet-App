import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_wallet_app/domain/controller/controllerDineroUser.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:provider/provider.dart';

class VistaGrafica extends StatefulWidget {
  final String uid;
  final bool theme;
  final dinero;
  final gastos;
  VistaGrafica(
      {Key? key,
      required this.uid,
      required this.theme,
      this.dinero,
      this.gastos});
  @override
  State<VistaGrafica> createState() => _VistaGraficaState();
}

class _VistaGraficaState extends State<VistaGrafica> {
  late List<dynamic> data;
  late TooltipBehavior _tooltip;
  //CONTROLADORES
  ControlDineroUser controldu = ControlDineroUser();
  //VARIABLES DE CONTROL
  bool _isDarkMode = false;
  double fontSize = 16.0;
  double tamano = 20.0;
  double dinero = 0;
  double gastos = 0;
  double ahorros = 0;
  double inversiones = 0;
  double otroConcepto = 0;
  double porcentajeGastos = 0;
  double porcentajeAhorros = 0;
  double porcentajeInversiones = 0;
  double porcentajeOtroConcepto = 0;
  var uid;
  //LISTA DE CONSEJOS
  final List<String> consejos = [
    '1. Realiza un presupuesto mensual y adhiérete a él.',
    '2. Ahorra un porcentaje de tus ingresos mensuales.',
    '3. Reduce los gastos innecesarios, como comer fuera de casa o compras impulsivas.',
    '4. Compara precios antes de realizar compras grandes.',
    '5. Utiliza aplicaciones de descuentos y cupones para ahorrar en tus compras.',
    '6. Evita las deudas de tarjetas de crédito y paga tus facturas a tiempo.',
    '7. Ahorra en energía eléctrica y agua en tu hogar.',
    '8. Considera opciones de transporte más económicas, como caminar o usar bicicleta.',
    '9. Planifica tus compras y aprovecha las ofertas y descuentos.',
    '10. Establece metas de ahorro a corto y largo plazo.'
  ];
  List<Map<String, dynamic>> gastosList = [];
  //FUNCIONES
  void obtenerGastos() {
    print('Gastos: ${widget.gastos}');
    if (widget.gastos.isNotEmpty) {
      print("No esta vacio");
      gastosList = widget.gastos;
      for (var i = 0; i < gastosList.length; i++) {
        gastos += gastosList[i]['expense'];
      }
    } else {
      gastos = 0;
    }
  }

  void obtenerAhorros() {
    if (dinero > 0 && gastos > 0) {
      ahorros = dinero - gastos;
    } else {
      ahorros = 0;
    }
  }

  void obtenerInversiones() {
    if (widget.gastos.isNotEmpty) {
      print("No esta vacio inversiones");
      gastosList = widget.gastos;
      print("Gastos consultados inver: $gastosList");
      for (int i = 0; i < gastosList.length; i++) {
        if (gastosList[i]['concepto'] == "Negocios") {
          inversiones += gastosList[i]['expense'];
        } else {
          if (gastosList[i]['concepto'] == "Educación") {
            inversiones += gastosList[i]['expense'];
          } else {
            if (gastosList[i]['concepto'] == "Salud") {
              inversiones += gastosList[i]['expense'];
            } else {
              if (gastosList[i]['concepto'] == "Vivienda") {
                inversiones += gastosList[i]['expense'];
              }
            }
          }
        }
      }
    } else {
      print("Esta vacio");
    }
  }

  void obtenerOtroConcepto() {
    if (widget.gastos.isNotEmpty) {
      print("No esta vacio");
      List<Map<String, dynamic>> gastosConsultados = widget.gastos;
      for (int i = 0; i < gastosConsultados.length; i++) {
        if (gastosConsultados[i]['concepto'] == "Otro") {
          otroConcepto += gastosConsultados[i]['expense'];
        }
      }
    } else {
      print("Esta vacio");
    }
  }

  void calcularPorcentajes() {
    print("Dinero en calcular: $dinero");
    if (dinero > 0) {
      porcentajeGastos = ((gastos * 100) / dinero);
      porcentajeAhorros = (ahorros * 100) / dinero;
      porcentajeInversiones = (inversiones * 100) / dinero;
      porcentajeOtroConcepto = (otroConcepto * 100) / dinero;
      print("Porcentaje Gastos: $porcentajeGastos");
      data = [
        _ChartData('Gastos', porcentajeGastos),
        _ChartData('Ahorros', porcentajeAhorros),
        _ChartData('Inversiones', porcentajeInversiones),
        _ChartData('Otros', porcentajeOtroConcepto),
      ];
    } else {
      porcentajeGastos = 0;
      porcentajeAhorros = 0;
      porcentajeInversiones = 0;
      porcentajeOtroConcepto = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    data = [
      _ChartData('Gastos', 0),
      _ChartData('Ahorros', 0),
      _ChartData('Inversiones', 0),
      _ChartData('Otros', 0),
    ];
    _tooltip = TooltipBehavior(enable: true);
    controldu.obtenerDinero(uid).then((value) => {
          if (controldu.datosDinero != null)
            {
              setState(() {
                dinero = controldu.datosDinero[0]['dineroInicial'].toDouble();
                if (dinero > 0) {
                  obtenerGastos();
                  obtenerAhorros();
                  obtenerInversiones();
                  obtenerOtroConcepto();
                  calcularPorcentajes();
                }
              })
            }
        });
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
      appBar: AppBar(
        automaticallyImplyLeading: false, // Oculta la flecha de retroceso
        centerTitle: true, // Centra el título
        title: Text(
          'Seguimiento de Gastos',
          style: TextStyle(
            color: _isDarkMode ? Colors.black : Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: _isDarkMode ? Colors.white : Colors.black87,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  child: SfCircularChart(
                      palette: <Color>[
                        Colors.red,
                        Colors.blue,
                        Colors.green,
                        Colors.yellow
                      ],
                      tooltipBehavior: _tooltip,
                      legend: Legend(
                        title: LegendTitle(
                          text: 'Indices',
                          textStyle: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                            fontSize: fontSize,
                          ),
                        ),
                        shouldAlwaysShowScrollbar: true,
                        position: LegendPosition.bottom,
                        isResponsive: true,
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                        textStyle: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      selectionGesture: ActivationMode.singleTap,
                      enableMultiSelection: true,
                      title: ChartTitle(
                        text: 'Gastos vs Ahorros',
                        textStyle: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white,
                          fontSize: fontSize,
                        ),
                      ),
                      series: <CircularSeries>[
                        DoughnutSeries<dynamic, String>(
                            dataSource: data,
                            xValueMapper: (dynamic data, _) => data.x,
                            yValueMapper: (dynamic data, _) => data.y,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: true,
                              showCumulativeValues: true,
                              showZeroValue: true,
                              textStyle: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                fontSize: 14,
                              ),
                              useSeriesColor: true,
                              labelPosition: ChartDataLabelPosition.outside,
                            ),
                            enableTooltip: true,
                            // Explode the segments on tap
                            strokeColor: Colors.black,
                            explode: true,
                            explodeIndex: 1)
                      ]),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                //Indices de grafica
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color:
                              _isDarkMode ? Colors.grey[200] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        richMessage: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Gastos',
                              style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "\$$gastos",
                        style: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color:
                              _isDarkMode ? Colors.grey[200] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        richMessage: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Ahorros',
                              style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "\$$ahorros",
                        style: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color:
                              _isDarkMode ? Colors.grey[200] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        richMessage: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Inversiones',
                              style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$$inversiones',
                        style: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Tooltip(
                        triggerMode: TooltipTriggerMode.tap,
                        decoration: BoxDecoration(
                          color:
                              _isDarkMode ? Colors.grey[200] : Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        richMessage: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Otros',
                              style: TextStyle(
                                color:
                                    _isDarkMode ? Colors.black : Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        child: Container(
                          width: 20,
                          height: 20,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\$$otroConcepto',
                        style: TextStyle(
                          color: _isDarkMode ? Colors.black : Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.grey[200] : Colors.grey[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                    itemCount: consejos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpansionTile(
                        iconColor: _isDarkMode ? Colors.white70 : Colors.white,
                        initiallyExpanded: false,
                        trailing: Icon(
                          Icons.arrow_drop_down,
                          color: _isDarkMode ? Colors.black : Colors.white,
                        ),
                        title: Text(
                          'Consejo ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              consejos[index],
                              style: TextStyle(
                                  color:
                                      _isDarkMode ? Colors.black : Colors.white,
                                  fontSize: 14),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
