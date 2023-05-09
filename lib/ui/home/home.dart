import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:my_wallet/ui/home/gasto.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  double montoInicial = 0;
  late TextEditingController _montoInicialController;

  @override
  void initState() {
    super.initState();
    _montoInicialController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: const Text(
              'Gestión de Gastos',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: const Text(
              'Bienvenido a la aplicación de gestión de gastos, en esta aplicación podras llevar un control de tus gastos y ver en que gastas tu dinero',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          const SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.white),
                const SizedBox(width: 5.0),
                Text(
                  "$montoInicial",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Monto Inicial',
            style: TextStyle(fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                TextFormField(
                  //controller: _montoInicialController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.lightGreen),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    labelText: 'Digita el Inicial',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon:
                        const Icon(Icons.monetization_on, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      //montoInicial = double.parse(_montoInicialController.text);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Guardar',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

  // final double _money = 1000000;
  // final List<double> _expenses = [];
  // late List<charts.Series> _chartData;
  // @override
  // void initState() {
  //   super.initState();
  //   _chartData = [
  //     charts.Series(
  //       id: 'Money',
  //       domainFn: (index, _) => '',
  //       measureFn: (index, _) => _money,
  //       colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
  //       data: [0],
  //     ),
  //     charts.Series(
  //       id: 'Expenses',
  //       domainFn: (index, _) => '',
  //       measureFn: (index, _) =>
  //           _expenses.isEmpty ? 0 : _expenses.reduce((a, b) => a + b),
  //       colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
  //       data: [0],
  //     ),
  //   ];
  // }

  // void _addExpense(double expense) {
  //   setState(() {
  //     _expenses.add(expense);
  //     _chartData[1].data.add(_expenses.reduce((a, b) => a + b));
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Gestión de Gastos'),
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           Text(
  //             'Dinero disponible: $_money',
  //             style: const TextStyle(fontSize: 24),
  //           ),
  //           const SizedBox(height: 20),
  //           SizedBox(
  //             height: 200,
  //             child: charts.PieChart(
  //               _chartData,
  //               animate: true,
  //               defaultRenderer: charts.ArcRendererConfig(
  //                 arcWidth: 20,
  //                 arcRendererDecorators: [
  //                   charts.ArcLabelDecorator(
  //                     labelPosition: charts.ArcLabelPosition.auto,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 20),
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: _expenses.length,
  //               itemBuilder: (context, index) {
  //                 return ListTile(
  //                   leading: const Icon(Icons.money_off),
  //                   title: Text('Gasto ${index + 1}: ${_expenses[index]}'),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: const Text('Agregar Gasto'),
  //               content: TextField(
  //                 keyboardType:
  //                     const TextInputType.numberWithOptions(decimal: true),
  //                 decoration: const InputDecoration(
  //                   hintText: 'Monto del Gasto',
  //                 ),
  //                 onSubmitted: (value) {
  //                   double expense = double.tryParse(value) ?? 0.0;
  //                   _addExpense(expense);
  //                   Navigator.of(context).pop();
  //                 },
  //               ),
  //             );
  //           },
  //         );
  //       },
  //       child: const Icon(Icons.add),
  //     ),
  //   );
  // }
