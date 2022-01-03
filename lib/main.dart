import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cli_script/cli_script.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String kkk = "1111";
  String gpu_usage_g21 = "cat /sys/devices/platform/18500000.mali/utilization";
  List<SalesData> _chartData = [];


  @override
  void initState() {

    _start();
    _chartData = getChartData();
    super.initState();

  }

  List<SalesData> getChartData(){
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30),
    ];
    return chartData;
  }


  void _start(){
    int temp = 0;
    const oneSec = Duration(seconds:1);
    Timer.periodic(
      oneSec,
      (Timer t) => setState(() {
        wrapMain(() async {
          var pipeline = Script(gpu_usage_g21);
          kkk = await pipeline.stdout.text;
          // print("${await pipeline.stdout.text} instances of waitFor");
        });
      }),
    );
  }



  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(text: 'test'),
        legend: Legend(isVisible: true),
        series: <ChartSeries>[
          LineSeries<SalesData, double>(name: 'Sales', dataSource: _chartData, xValueMapper: (SalesData sales, _) => sales.year, yValueMapper: (SalesData sales, _) => sales.sales, dataLabelSettings: DataLabelSettings(isVisible: true))
        ],
        primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
        primaryYAxis: NumericAxis(
            labelFormat: '{value}M',
            numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
      ),
    ));
  }


}

class SalesData{
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}