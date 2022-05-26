import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChartSample9 extends StatefulWidget {
  const LineChartSample9({Key? key}) : super(key: key);

  @override
  _LineChartSample9State createState() => _LineChartSample9State();
}

class _LineChartSample9State extends State<LineChartSample9> {
  List<SalesData> chartData = <SalesData>[
    SalesData(1, 20),
    SalesData(2, 40),
    SalesData(3, 55),
    SalesData(4, 17),
    SalesData(5, 30),
    SalesData(6, 41),
    SalesData(7, 26),
    SalesData(8, 30),
    SalesData(9, 40),
    SalesData(10, 56),
    SalesData(11, 76),
    SalesData(12, 56),
    SalesData(13, 46),
    SalesData(14, 36),
    SalesData(15, 26),
    SalesData(16, 16),
    SalesData(17, 66),
    SalesData(18, 76),
    SalesData(19, 76),
    SalesData(20, 76),
    SalesData(21, 96),
    SalesData(22, 16),
    SalesData(23, 66),
    SalesData(24, 86),
    SalesData(25, 56),
    SalesData(26, 56),
    SalesData(27, 45),
    SalesData(28, 56),
    SalesData(29, 56),
    SalesData(30, 76),
    SalesData(31, 23),
    SalesData(32, 56),
    SalesData(33, 45),
    SalesData(34, 56),
  ];

  Timer? timer;

  @override
  void initState() {
    /*timer = Timer.periodic(Duration(seconds: 15), (Timer t) {
      chartData.addAll(SalesData(Random.nextInt(100), y))
    });*/
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sine Wave',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
          child: Container(
              height: 300.0,
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                  primaryXAxis:
                      NumericAxis(rangePadding: ChartRangePadding.normal),
                  primaryYAxis: NumericAxis(),
                  series: <ChartSeries>[
                    SplineSeries<SalesData, int>(
                      dataSource: chartData,
                      splineType: SplineType.cardinal,
                      cardinalSplineTension: 0.9,
                      xValueMapper: (SalesData data, _) => data.x,
                      yValueMapper: (SalesData data, _) => data.y,
                    )
                  ]))),
    );
  }
}

class SalesData {
  SalesData(this.x, this.y);
  final int x;
  final int y;
}


