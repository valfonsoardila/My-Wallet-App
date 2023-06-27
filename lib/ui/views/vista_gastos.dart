import 'package:flutter/material.dart';
import 'package:my_wallet_app/domain/controller/controllerDineroUser.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class VistaGastos extends StatefulWidget {
  final String uid;
  final bool theme;
  VistaGastos({Key? key, required this.uid, required this.theme})
      : super(key: key);
  @override
  State<VistaGastos> createState() => _VistaGastosState();
}

class _VistaGastosState extends State<VistaGastos> {
  //STORAGE
  final theme = GetStorage();
  final sizeLetter = GetStorage();
  //CONTROLLERS
  ControlDineroUser controldu = ControlDineroUser();
  final TextEditingController _expenseController = TextEditingController();
  //MAPS
  Map<String, List<double>> gastosPorFecha = {};
  //VARIBLES DE CONTROL
  double montoInicial = 0.0;
  final DateTime now = DateTime.now();
  double totalExpenses = 0.0;
  bool isDarkMode = false;
  double fontSize = 16.0;
  double tamano = 20.0;
  //VARIABLES
  var montoactual;
  var uid;
  //METODOS
  void addExpense() {
    setState(() {
      double expense = double.parse(_expenseController.text);
      String fecha = DateFormat('dd-MM-yyyy').format(now);
      if (gastosPorFecha.containsKey(fecha)) {
        gastosPorFecha[fecha]!.add(expense);
      } else {
        gastosPorFecha[fecha] = [expense];
      }
      totalExpenses += expense;
      _expenseController.clear();
    });
  }

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

  void consultarMontoActual() async {
    var montoconsultado = await controldu.leerDinero(uid);
    setState(() {
      montoactual = montoconsultado;
    });
  }

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    consultarTema();
    consultarTamanoLetra();
    consultarMontoActual();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    String formattedTime = timeFormat.format(now);
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30,
              color: isDarkMode ? Colors.black : Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: isDarkMode ? Colors.grey[900] : Colors.white,
                    height: 30,
                    constraints: BoxConstraints(
                      maxWidth: double.infinity,
                    ),
                    margin: EdgeInsets.only(right: 5.0),
                    child: Row(children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.yellowAccent,
                      ),
                      SizedBox(width: 3.0),
                      Text(
                        'Total dinero:',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 3.0),
                      Text(
                        montoactual != null ? montoactual.toString() : '0.0',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            Container(
              color: isDarkMode
                  ? Colors.black
                  : Colors.white, // Cambiar el color de fondo a negro
              child: Container(
                padding: EdgeInsets.only(
                    right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                child: Column(
                  children: [
                    Icon(Icons.money_off,
                        color: isDarkMode ? Colors.white : Colors.lightGreen,
                        size: 54),
                    Text(
                      'Registra tus Gastos',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      controller: _expenseController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.lightGreen),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        labelText: 'Monto',
                        labelStyle: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        prefixIcon: Icon(
                          Icons.attach_money,
                          color: isDarkMode ? Colors.white : Colors.lightGreen,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      onPressed: addExpense,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        textStyle: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      child: Text(
                        'Agregar Gasto',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      children: [
                        Container(
                          height: 20,
                          color: Colors.lightGreen,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Gastos por fecha',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 300,
                          color: isDarkMode
                              ? Colors.grey[900]
                              : Color.fromARGB(255, 202, 200, 200),
                          child: ListView.builder(
                            physics:
                                AlwaysScrollableScrollPhysics(), // Permitir scroll siempre
                            itemCount: gastosPorFecha.length,
                            itemBuilder: (context, index) {
                              String fecha =
                                  gastosPorFecha.keys.toList()[index];
                              List<double> gastos = gastosPorFecha[fecha]!;
                              return ExpansionTile(
                                title: Text(
                                  fecha,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                children: gastos.map((gasto) {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.monetization_on,
                                                    color: Colors.lightGreen,
                                                  ),
                                                  Text(
                                                    'Gasto: $gasto',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: isDarkMode
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                formattedTime,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: isDarkMode
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            },
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
      ),
    );
  }
}
