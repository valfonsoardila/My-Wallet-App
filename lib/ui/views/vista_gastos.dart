import 'package:flutter/material.dart';
import 'package:my_wallet_app/domain/controller/controllerDineroUser.dart';
import 'package:intl/intl.dart';

class VistaGastos extends StatefulWidget {
  final String uid;
  VistaGastos({Key? key, this.uid = ''}) : super(key: key);
  @override
  State<VistaGastos> createState() => _VistaGastosState();
}

class _VistaGastosState extends State<VistaGastos> {
  ControlDineroUser controldu = ControlDineroUser();
  Map<String, List<double>> gastosPorFecha = {};
  final TextEditingController _expenseController = TextEditingController();
  var montoactual;
  double montoInicial = 0.0;
  final DateTime now = DateTime.now();
  double totalExpenses = 0.0;

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

  var uid = '';
  @override
  void initState() {
    super.initState();
    uid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    String formattedDate = dateFormat.format(now);
    String formattedTime = timeFormat.format(now);

    return FutureBuilder<Map<String, dynamic>>(
      future: controldu.leerDinero(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 4.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error al obtener el perfil');
        } else {
          final datosDinero = snapshot.data ?? {};
          if (datosDinero['dineroInicial'] == 0 ||
              datosDinero['dineroInicial'] == null) {
            montoactual = 0;
          } else {
            montoactual = datosDinero['dineroInicial'];
          }
          return Scaffold(
            backgroundColor: Colors.black,
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
                          margin: EdgeInsets.only(right: 5.0),
                          child: Row(children: [
                            Icon(
                              Icons.monetization_on,
                              color: Colors.yellowAccent,
                            ),
                            SizedBox(width: 3.0),
                            Text(
                              'Total gastos:',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            SizedBox(width: 3.0),
                            Text(
                              '$montoactual',
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
                    color: Colors.black, // Cambiar el color de fondo a negro
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Icon(Icons.money_off, color: Colors.white, size: 54),
                          Text(
                            'Registra tus Gastos',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            controller: _expenseController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.lightGreen),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              labelText: 'Monto',
                              labelStyle: TextStyle(color: Colors.white),
                              prefixIcon:
                                  Icon(Icons.attach_money, color: Colors.white),
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
                              style: TextStyle(color: Colors.white),
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
                                color: Colors.grey[900],
                                child: ListView.builder(
                                  physics:
                                      AlwaysScrollableScrollPhysics(), // Permitir scroll siempre
                                  itemCount: gastosPorFecha.length,
                                  itemBuilder: (context, index) {
                                    String fecha =
                                        gastosPorFecha.keys.toList()[index];
                                    List<double> gastos =
                                        gastosPorFecha[fecha]!;
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
                                                          color:
                                                              Colors.lightGreen,
                                                        ),
                                                        Text(
                                                          'Gasto: $gasto',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color: Colors.white,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
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
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
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
      },
    );
  }
}
