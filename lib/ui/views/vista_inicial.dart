import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class VistaInicial extends StatefulWidget {
  const VistaInicial({super.key});
  @override
  State<VistaInicial> createState() => _VistaInicialState();
}

class _VistaInicialState extends State<VistaInicial> {
  List<charts.Series<DataPoint, String>> _createSeries() {
    return [
      charts.Series<DataPoint, String>(
        id: 'Sales',
        data: data,
        domainFn: (DataPoint sales, _) => sales.category,
        measureFn: (DataPoint sales, _) => sales.value,
        labelAccessorFn: (DataPoint sales, _) => '${sales.category}: ${sales.value}',
      ),
    ];
  }
  final List<DataPoint> data = [
    DataPoint('A', 50),
    DataPoint('B', 25),
    DataPoint('C', 15),
    DataPoint('D', 10),
  ];
  @override
  Widget build(BuildContext context) {
    final seriesList = _createSeries();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              padding: EdgeInsets.all(16),
              // child: AspectRatio(
              //   aspectRatio: 1,
              //   child: charts.PieChart(
              //     seriesList,
              //     animate: true,
              //     animationDuration: Duration(milliseconds: 500),
              //     behaviors: [
              //       charts.DatumLegend(
              //         position: charts.BehaviorPosition.end,
              //         outsideJustification:
              //             charts.OutsideJustification.endDrawArea,
              //       ),
              //     ],
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}

class DataPoint {
  final String category;
  final int value;

  DataPoint(this.category, this.value);
}
