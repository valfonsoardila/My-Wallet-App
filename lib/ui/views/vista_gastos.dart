import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet_app/domain/controller/controllerDineroUser.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet_app/domain/controller/controllerGastosUser.dart';
import 'package:my_wallet_app/ui/models/theme_model.dart';
import 'package:provider/provider.dart';

class VistaGastos extends StatefulWidget {
  final String uid;
  final bool theme;
  final dinero;
  final gastos;
  final concepto;
  VistaGastos(
      {Key? key,
      required this.uid,
      required this.theme,
      this.dinero,
      this.gastos,
      this.concepto})
      : super(key: key);
  @override
  State<VistaGastos> createState() => _VistaGastosState();
}

class _VistaGastosState extends State<VistaGastos> {
  String conceptoSeleccionadoDropd1 = 'Servicios';
  String filtroSeleccionadoDropd1 = 'Filtros';
  int indexSelected1 = 0;
  int indexSelected2 = 0;
  //CONTROLLERS
  ControlDineroUser controldu = ControlDineroUser();
  ControlGastoUser controlgu = ControlGastoUser();
  final TextEditingController _expenseController = TextEditingController();
  //MAPS
  Map<String, Map<String, List<double>>> gastosPorFecha = {};
  Map<String, dynamic> gastosConvertidos = {};
  List<Map<String, dynamic>> gastos = [];
  //VARIBLES DE CONTROL
  double montoInicial = 0.0;
  final DateTime now = DateTime.now();
  double totalExpenses = 0.0;
  bool _isDarkMode = false;
  double fontSize = 16.0;
  double tamano = 20.0;
  bool _isExpense = false;
  //VARIABLES
  var montoactual;
  var uid;
  int indexIcon = 1;
  int indexFiltro = 0;
  List<IconData> itemIcons = [
    Icons.home,
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
  //Lista de conceptos
  var conceptos = <String>[
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
  var coloresFiltro = <Color>[
    Colors.lightGreen,
    Colors.pinkAccent,
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.deepPurple,
    Color.fromARGB(255, 99, 8, 8),
    Colors.green,
    Colors.brown,
  ];
  //Lista de conceptos
  var filtros = <String>[
    'Filtros',
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

  //METODOS
  void addExpense() {
    setState(() {
      double expense = double.parse(_expenseController.text);
      String fecha = DateFormat('dd-MM-yyyy').format(now);
      String hora = DateFormat('HH:mm').format(now);
      String id = uid + fecha + hora;
      gastosConvertidos = {
        'id': id,
        'uid': uid,
        'expense': expense,
        'fecha': fecha,
        'hora': hora,
        'concepto': conceptoSeleccionadoDropd1,
      };
      if (gastosPorFecha.containsKey(gastosConvertidos['fecha'])) {
        Map<String, List<double>> gastosParaFecha =
            gastosPorFecha[gastosConvertidos['fecha']]!;
        if (gastosParaFecha.containsKey(conceptoSeleccionadoDropd1)) {
          gastosParaFecha[conceptoSeleccionadoDropd1]!.add(expense);
        } else {
          gastosParaFecha[conceptoSeleccionadoDropd1] = [expense];
        }
        print(gastosPorFecha);
      } else {
        gastosPorFecha[gastosConvertidos['fecha']] = {
          conceptoSeleccionadoDropd1: [expense],
        };
        print(gastosPorFecha);
      }
      totalExpenses += expense;
      substractCurrentAmount(expense);
      _expenseController.clear();
    });
    if (conceptoSeleccionadoDropd1 == "Servicios" ||
        conceptoSeleccionadoDropd1 == "Ropa" ||
        conceptoSeleccionadoDropd1 == "Alimentos" ||
        conceptoSeleccionadoDropd1 == "Transporte" ||
        conceptoSeleccionadoDropd1 == "Otro") {
      _isExpense = true;
    } else {
      _isExpense = false;
    }
    controlgu.agregarGastos(gastosConvertidos);
  }

  void loadExpenses() async {
    gastos = widget.gastos;
    print(gastos);
    if (gastos != []) {
      setState(() {
        gastos.forEach((element) {
          if (gastosPorFecha.containsKey(element['fecha'])) {
            Map<String, List<double>> gastosParaFecha =
                gastosPorFecha[element['fecha']]!;
            if (gastosParaFecha.containsKey(element['concepto'])) {
              gastosParaFecha[element['concepto']]!.add(element['expense']
                  .toDouble()); // Agregar el gasto a la lista de gastos para el concepto
            } else {
              gastosParaFecha[element['concepto']] = [
                element['expense'].toDouble()
              ];
            }
          } else {
            gastosPorFecha[element['fecha']] = {
              element['concepto']: [element['expense'].toDouble()]
            };
          }
          totalExpenses += element['expense'];
        });
      });
    } else {
      setState(() {
        totalExpenses = 0.0;
      });
    }
  }

  void substractCurrentAmount(expense) {
    controldu.obtenerDinero(uid).then((value) => {
          if (controldu.datosDinero != null)
            {
              if (controldu.datosDinero[0]['dineroInicial'] >= expense)
                {
                  setState(() {
                    montoInicial =
                        double.parse(controldu.datosDinero[0]['dineroInicial']);
                    montoactual = montoInicial - expense;
                    print("Este es el monto actual: $montoactual");
                    var dinero = {
                      'dineroInicial': "$montoactual",
                      'fecha': controldu.datosDinero[0]['fecha'],
                      'hora': controldu.datosDinero[0]['hora'],
                      'id': uid,
                    };
                    controldu.actualizarDinero(dinero);
                  })
                }
              else
                {
                  print('No se puede restar el dinero'),
                  Get.snackbar("La cantidad de dinero es insuficiente",
                      "No se realizó el gasto",
                      duration: Duration(seconds: 4),
                      backgroundColor: Color.fromARGB(255, 73, 73, 73)),
                }
            }
        });
  }

  void consultarMontoActual() async {
    controldu.obtenerDinero(uid).then((value) => {
          if (controldu.datosDinero != null)
            {
              setState(() {
                montoactual = controldu.datosDinero[0]['dineroInicial'];
              })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    uid = widget.uid;
    if (widget.gastos.length > 0) {
      print('Cargando gastos');
      loadExpenses();
    }
    if (widget.concepto != '') {
      conceptoSeleccionadoDropd1 = widget.concepto;
      if (widget.concepto == 'Servicios') {
        indexIcon = 0;
      } else {
        if (widget.concepto == 'Ropa') {
          indexIcon = 1;
        } else {
          if (widget.concepto == 'Alimentos') {
            indexIcon = 2;
          } else {
            if (widget.concepto == 'Transporte') {
              indexIcon = 3;
            } else {
              if (widget.concepto == 'Negocios') {
                indexIcon = 4;
              } else {
                if (widget.concepto == 'Educación') {
                  indexIcon = 5;
                } else {
                  if (widget.concepto == 'Salud') {
                    indexIcon = 6;
                  } else {
                    if (widget.concepto == 'Vivienda') {
                      indexIcon = 7;
                    } else {
                      if (widget.concepto == 'Otro') {
                        indexIcon = 8;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    } else {
      print('No hay concepto');
    }
    consultarMontoActual();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    String formattedTime = timeFormat.format(now);
    final theme = Provider.of<ThemeChanger>(context);
    var temaActual = theme.getTheme();
    if (temaActual == ThemeData.dark()) {
      _isDarkMode = true;
    } else {
      _isDarkMode = false;
    }
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.white : Colors.black,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: _isDarkMode ? Colors.grey[900] : Colors.grey[900],
                      height: 30,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.yellowAccent,
                            ),
                            SizedBox(width: 3.0),
                            Text(
                              'Total dinero: ',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 3.0),
                            Text(
                              montoactual != null
                                  ? montoactual.toString()
                                  : '0.0',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.797,
                child: Container(
                  padding: EdgeInsets.only(
                      right: 10.0, left: 10.0, top: 10.0, bottom: 10.0),
                  child: Column(
                    children: [
                      Icon(Icons.money_off,
                          color: _isDarkMode ? Colors.lightGreen : Colors.white,
                          size: 54),
                      Text(
                        'Registra tus Gastos',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: _isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _isDarkMode
                                ? Colors.black
                                : Colors
                                    .white, // Puedes cambiar el color del borde aquí
                            width:
                                1.0, // Puedes ajustar el grosor del borde aquí
                          ),
                          borderRadius: BorderRadius.circular(
                              8.0), // Puedes ajustar la esquina redondeada aquí
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(
                                itemIcons[indexIcon],
                                color: _isDarkMode == true
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                            Expanded(
                              child: DropdownButton(
                                  padding: EdgeInsets.only(left: 5),
                                  hint: Text(
                                    'Concepto',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  dropdownColor: _isDarkMode == true
                                      ? Colors.white.withOpacity(0.9)
                                      : Colors.grey[900],
                                  icon: Icon(Icons.arrow_drop_down,
                                      color: _isDarkMode == true
                                          ? Colors.black
                                          : Colors.white),
                                  iconSize: 36,
                                  isExpanded: true,
                                  underline: SizedBox(),
                                  style: TextStyle(
                                    color: _isDarkMode == true
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 18.0,
                                  ),
                                  value: conceptoSeleccionadoDropd1,
                                  onChanged: (newValue) {
                                    if (newValue == 'Servicios') {
                                      indexIcon = 1;
                                    } else {
                                      if (newValue == 'Ropa') {
                                        indexIcon = 2;
                                      } else {
                                        if (newValue == 'Alimentos') {
                                          indexIcon = 3;
                                        } else {
                                          if (newValue == 'Transporte') {
                                            indexIcon = 4;
                                          } else {
                                            if (newValue == 'Negocios') {
                                              indexIcon = 5;
                                            } else {
                                              if (newValue == 'Educación') {
                                                indexIcon = 6;
                                              } else {
                                                if (newValue == 'Salud') {
                                                  indexIcon = 7;
                                                } else {
                                                  if (newValue == 'Vivienda') {
                                                    indexIcon = 8;
                                                  } else {
                                                    if (newValue == 'Otro') {
                                                      indexIcon = 9;
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                    setState(() {
                                      conceptoSeleccionadoDropd1 =
                                          newValue.toString();
                                      indexSelected1 = conceptos
                                          .indexOf(newValue.toString());
                                      print(
                                          indexSelected1); // Actualiza el valor seleccionado
                                    });
                                  },
                                  items: conceptos.map((valueItem) {
                                    return DropdownMenuItem(
                                      value: valueItem,
                                      child: Text(valueItem),
                                    );
                                  }).toList()),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        controller: _expenseController,
                        keyboardType: TextInputType.number,
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
                              color: _isDarkMode ? Colors.black : Colors.white,
                            ),
                          ),
                          labelText: 'Monto',
                          labelStyle: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color:
                                _isDarkMode ? Colors.lightGreen : Colors.white,
                          ),
                        ),
                        autofocus: true,
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          addExpense();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          textStyle: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        child: Text(
                          'Agregar Gasto',
                          style: TextStyle(
                            color: _isDarkMode ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Column(
                        children: [
                          Container(
                            height: 30,
                            color: Colors.lightGreen,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    color: coloresFiltro[indexFiltro],
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Icon(
                                          itemIcons[indexFiltro],
                                          color: _isDarkMode == true
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                        Expanded(
                                          child: DropdownButton(
                                              padding: EdgeInsets.only(left: 5),
                                              hint: Text(
                                                'Filtro',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              dropdownColor: _isDarkMode == true
                                                  ? Colors.white
                                                      .withOpacity(0.9)
                                                  : Colors.grey[900],
                                              icon: Icon(Icons.arrow_drop_down,
                                                  color: _isDarkMode == true
                                                      ? Colors.black
                                                      : Colors.white),
                                              iconSize: 36,
                                              isExpanded: true,
                                              underline: SizedBox(),
                                              style: TextStyle(
                                                color: _isDarkMode == true
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                              value: filtroSeleccionadoDropd1,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  if (newValue == "Filtros") {
                                                    indexFiltro = 0;
                                                  } else {
                                                    if (newValue ==
                                                        'Servicios') {
                                                      indexFiltro = 1;
                                                    } else {
                                                      if (newValue == 'Ropa') {
                                                        indexFiltro = 2;
                                                      } else {
                                                        if (newValue ==
                                                            'Alimentos') {
                                                          indexFiltro = 3;
                                                        } else {
                                                          if (newValue ==
                                                              'Transporte') {
                                                            indexFiltro = 4;
                                                          } else {
                                                            if (newValue ==
                                                                'Negocios') {
                                                              indexFiltro = 5;
                                                            } else {
                                                              if (newValue ==
                                                                  'Educación') {
                                                                indexFiltro = 6;
                                                              } else {
                                                                if (newValue ==
                                                                    'Salud') {
                                                                  indexFiltro =
                                                                      7;
                                                                } else {
                                                                  if (newValue ==
                                                                      'Vivienda') {
                                                                    indexFiltro =
                                                                        8;
                                                                  } else {
                                                                    if (newValue ==
                                                                        'Otro') {
                                                                      indexFiltro =
                                                                          9;
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                  filtroSeleccionadoDropd1 =
                                                      newValue.toString();
                                                  indexSelected2 =
                                                      filtros.indexOf(
                                                          newValue.toString());
                                                  print(
                                                      indexSelected2); // Actualiza el valor seleccionado
                                                });
                                              },
                                              items: filtros.map((valueItem) {
                                                return DropdownMenuItem(
                                                  value: valueItem,
                                                  child: Text(valueItem),
                                                );
                                              }).toList()),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Gastos vs Inversion',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: _isDarkMode == true
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.28,
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '\$$totalExpenses',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: _isDarkMode == true
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.429,
                            color: _isDarkMode
                                ? Colors.grey[200]
                                : Colors.grey[900],
                            child: ListView.builder(
                              physics:
                                  AlwaysScrollableScrollPhysics(), // Permitir scroll siempre
                              itemCount: gastosPorFecha.length,
                              itemBuilder: (context, index) {
                                String fecha =
                                    gastosPorFecha.keys.toList()[index];
                                List<double> gastos = gastosPorFecha[fecha]!
                                    .values
                                    .expand((element) => element)
                                    .toList();
                                return ExpansionTile(
                                  collapsedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  collapsedIconColor:
                                      _isDarkMode ? Colors.black : Colors.white,
                                  iconColor:
                                      _isDarkMode ? Colors.black : Colors.white,
                                  backgroundColor: _isDarkMode
                                      ? Color.fromARGB(255, 205, 245, 159)
                                      : Colors.grey[800],
                                  title: _isExpense
                                      ? Text(
                                          "Inversion # ${index + 1}",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: _isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          "Gastos # ${index + 1}",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: _isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                  subtitle: Text(
                                    fecha,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: _isDarkMode
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  children: gastos.map((gasto) {
                                    String concepto = gastosPorFecha[fecha]!
                                        .keys
                                        .firstWhere(
                                            (key) =>
                                                gastosPorFecha[fecha]![key]!
                                                    .contains(gasto),
                                            orElse: () => '');
                                    print(concepto);
                                    return ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.monetization_on,
                                                      color: Colors.lightGreen,
                                                      size: 18,
                                                    ),
                                                    Text(
                                                      'Gasto: $gasto',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: _isDarkMode
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  formattedTime,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: _isDarkMode
                                                        ? Colors.black
                                                        : Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              child: Column(
                                            children: [
                                              Text('$concepto',
                                                  style: TextStyle(
                                                    color: _isDarkMode
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 15.0,
                                                  )),
                                            ],
                                          ))
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
      ),
    );
  }
}
