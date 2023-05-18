import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VistaGastos extends StatefulWidget {
  const VistaGastos({super.key});

  @override
  State<VistaGastos> createState() => _VistaGastosState();
}

class _VistaGastosState extends State<VistaGastos> {
  List<double> expenses = [];
  final TextEditingController _expenseController = TextEditingController();
  double montoInicial = 0.0;
  // Obtén la fecha y hora actual
  final DateTime now = DateTime.now();
  double totalExpenses = 0.0;
  void addExpense() {
    setState(() {
      double expense = double.parse(_expenseController.text);
      expenses.add(expense);
      totalExpenses += expense;
      _expenseController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Formatea la fecha y la hora actual en el formato deseado
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    String formattedDate = dateFormat.format(now);
    String formattedTime = timeFormat.format(now);
    List<String> generos = [formattedDate, 'Femenino']; // Lista de opciones
    String fechaSeleccionada = generos
        .first; // Variable de estado para almacenar el valor seleccionado del género

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Registrar gastos'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 30,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.grey[900],
                    height: 30,
                    constraints: BoxConstraints(
                      maxWidth: double.infinity,
                    ),
                    margin: const EdgeInsets.only(right: 5.0),
                    child: Row(children: [
                      const Icon(
                        Icons.monetization_on,
                        color: Colors.yellowAccent,
                      ),
                      const SizedBox(width: 3.0),
                      const Text(
                        'Total gastos:',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(width: 3.0),
                      Text(
                        '-$totalExpenses',
                        style: const TextStyle(
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
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 20.0),
                                const Text(
                                  'Ingresa tus gastos diarios',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 10.0),
                                TextFormField(
                                  controller: _expenseController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: Colors.lightGreen),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                    ),
                                    labelText: 'Digite el monto del gasto',
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
                                    prefixIcon: const Icon(
                                        Icons.add_task_outlined,
                                        color: Colors.white),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: addExpense,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightGreen,
                                    textStyle: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  child: const Text(
                                    'Agregar',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 30.0,
                                  color: Colors.lightGreen,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: DropdownButton(
                                            dropdownColor: Colors.lightGreen,
                                            hint: Text(
                                              'Fecha de registros',
                                              style:
                                                  TextStyle(color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.white),
                                            iconSize: 36,
                                            isExpanded: true,
                                            underline: const SizedBox(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            value: fechaSeleccionada,
                                            onChanged: (newValue) {
                                              setState(() {
                                                fechaSeleccionada = newValue
                                                    .toString(); // Actualiza el valor seleccionado
                                              });
                                            },
                                            items: generos.map((valueItem) {
                                              return DropdownMenuItem(
                                                value: valueItem,
                                                child: Text(valueItem,
                                                    textAlign: TextAlign.center),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Tus gastos',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            'Total: -$totalExpenses',
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Color.fromARGB(
                                                  255, 158, 19, 19),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.grey[900],
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width: MediaQuery.of(context).size.width,
                                  child: Expanded(
                                    child: ListView.builder(
                                      itemCount: expenses.length,
                                      itemBuilder: (context, index) {
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
                                                          color:
                                                              Colors.lightGreen,
                                                        ),
                                                        Text(
                                                            'Gasto ${index + 1}:',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text('${expenses[index]}',
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text('$formattedTime',
                                                        style: const TextStyle(
                                                          fontSize: 16.0,
                                                          color: Colors.white,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
