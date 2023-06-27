import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fl_chart/fl_chart.dart';

class VistaGrafica extends StatefulWidget {
  final bool theme;
  VistaGrafica({Key? key, required this.theme});
  @override
  State<VistaGrafica> createState() => _VistaGraficaState();
}

class _VistaGraficaState extends State<VistaGrafica> {
  //STORAGE
  final theme = GetStorage();
  final sizeLetter = GetStorage();
  //VARIABLES DE CONTROL
  bool isDarkMode = false;
  double fontSize = 16.0;
  double tamano = 20.0;
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
    consultarTema();
    consultarTamanoLetra();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Gráfica Gastos vs Ahorros',
            style: TextStyle(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(4.0),
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.red,
                        value: 40,
                        title: '40%',
                        radius: 50,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      PieChartSectionData(
                        color: Colors.blue,
                        value: 30,
                        title: '30%',
                        radius: 40,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      PieChartSectionData(
                        color: Colors.green,
                        value: 20,
                        title: '20%',
                        radius: 30,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      PieChartSectionData(
                        color: Colors.yellow,
                        value: 10,
                        title: '10%',
                        radius: 20,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //Indices de grafica
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Gastos',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Ahorros',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Inversiones',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Otros',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: isDarkMode
                    ? Colors.grey[900]
                    : Color.fromARGB(255, 202, 200, 200),
                child: ListView.builder(
                  itemCount: consejos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ExpansionTile(
                      iconColor: isDarkMode ? Colors.white : Colors.black,
                      title: Text(
                        'Consejo ${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            consejos[index],
                            style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
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
    );
  }
}
