import 'dart:async';

import 'package:flutter/material.dart';
import 'package:root/root.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:file/local.dart';
import 'package:shell/shell.dart';

// https://pub.dev/packages/syncfusion_flutter_charts

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
  String cpu_usage_g21 = "cat /proc/stat";
  String net_usage_g21 = "cat /proc/net/dev";
  List<SalesData> _chartData = [];
  List<SalesData> _chartData2 = [];
  int gpu_usage_result = 0;
  int cpu_usage_result = 0;
  String old_cpu_usage_temp = "";
  int cpu_core_num = 8;

  String _result = "";

  Future<void> setCommand() async {
    var res = await Root.exec(cmd: "cat /proc/stat");
    setState(() {
      _result = res.toString();
    });
    print(_result);
  }



  var shell = new Shell();


  late ChartSeriesController _chartSeriesController;
  late ChartSeriesController _chartSeriesController2;


  @override
  void initState() {

    // _start();

    _chartData = getChartData();
    _chartData2 = getChartData2();
    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    setCommand();
    super.initState();

  }

  int yeartmp = 2027;

  void updateDataSource(Timer timer){
    cpuUsage();
    // gpuUsage();
    _chartData.add(SalesData(yeartmp++, cpu_usage_result));
    _chartData2.add(SalesData(yeartmp++, gpu_usage_result));
    _chartData.removeAt(0);
    _chartData2.removeAt(0);


    _chartSeriesController.updateDataSource(
      addedDataIndex: _chartData.length -1,
      removedDataIndex: 0
    );
    _chartSeriesController2.updateDataSource(
      addedDataIndex: _chartData2.length -1,
      removedDataIndex: 0
    );

  }

  List<SalesData> getChartData(){
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30),
      SalesData(2022, 25),
      SalesData(2023, 12),
      SalesData(2024, 24),
      SalesData(2025, 18),
      SalesData(2027, 30),
    ];
    return chartData;
  }

  List<SalesData> getChartData2(){
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30),
      SalesData(2022, 25),
      SalesData(2023, 12),
      SalesData(2024, 24),
      SalesData(2025, 18),
      SalesData(2027, 30),
    ];
    return chartData;
  }

  void gpuUsage() async{

    setState(() {   });
    // print("${await pipeline.stdout.text} instances of waitFor");
  }

  void cpuUsage() async{
    int old_user = 0;
    int old_nice = 0;
    int old_system = 0;
    int old_idle = 0;
    int old_iowait = 0;
    int old_irq = 0;
    int old_softirq = 0;
    int old_steal = 0;
    int old_guest = 0;
    int old_guest_nice = 0;
    int d_user = 0;
    int d_nice = 0;
    int d_system = 0;
    int d_idle = 0;
    int d_iowait = 0;
    int d_irq = 0;
    int d_softirq = 0;
    int d_steal = 0;
    int d_guest = 0;
    int d_guest_nice = 0;
    String cpu_usage_temp = "";
    int previous_idle = 0;
    int current_idle = 0;
    int previous_non_idle = 0;
    int current_non_idle = 0;
    int previous_total = 0;
    int current_total = 0;
    double diff_total = 0;
    double diff_idle = 0;
    double cpu_total = 0;


    // var pipeline = Script(net_usage_g21);
    // cpu_usage_temp = await pipeline.stdout.text;

    // var echo = await shell.start('cat', arguments: ['/proc/stat']);
    // var echoText = await echo.stderr.toString();
    // print(echoText);


    // for(int j = 0; j < cpu_core_num; j++){
    //   if(old_cpu_usage_temp != ""){
    //     old_user = int.parse(old_cpu_usage_temp[12+j*11]);
    //     old_nice = int.parse(old_cpu_usage_temp[13+j*11]);
    //     old_system = int.parse(old_cpu_usage_temp[14+j*11]);
    //     old_idle = int.parse(old_cpu_usage_temp[15+j*11]);
    //     old_iowait = int.parse(old_cpu_usage_temp[16+j*11]);
    //     old_irq = int.parse(old_cpu_usage_temp[17+j*11]);
    //     old_softirq = int.parse(old_cpu_usage_temp[18+j*11]);
    //     old_steal = int.parse(old_cpu_usage_temp[19+j*11]);
    //     old_guest = int.parse(old_cpu_usage_temp[20+j*11]);
    //     old_guest_nice = int.parse(old_cpu_usage_temp[21+j*11]);
    //   }
    //
    //   d_user = int.parse(cpu_usage_temp[12+j*11]);
    //   d_nice = int.parse(cpu_usage_temp[13+j*11]);
    //   d_system = int.parse(cpu_usage_temp[14+j*11]);
    //   d_idle = int.parse(cpu_usage_temp[15+j*11]);
    //   d_iowait = int.parse(cpu_usage_temp[16+j*11]);
    //   d_irq = int.parse(cpu_usage_temp[17+j*11]);
    //   d_softirq = int.parse(cpu_usage_temp[18+j*11]);
    //   d_steal = int.parse(cpu_usage_temp[19+j*11]);
    //   d_guest = int.parse(cpu_usage_temp[20+j*11]);
    //   d_guest_nice = int.parse(cpu_usage_temp[21+j*11]);
    //
    //   previous_idle = old_idle + old_iowait;
    //   current_idle = d_idle + d_iowait;
    //
    //   previous_non_idle = old_user + old_nice + old_system + old_irq + old_softirq + old_steal;
    //   current_non_idle = d_user + d_nice + d_system + d_irq + d_softirq + d_steal;
    //
    //   previous_total = previous_idle + previous_non_idle;
    //   current_total = current_idle + current_non_idle;
    //
    //   diff_total = (current_total - previous_total).toDouble();
    //   diff_idle = (current_idle - previous_idle).toDouble();
    //
    //   cpu_total = ((diff_total - diff_idle) / diff_total * 100 )+ cpu_total;
    //
    // }
    // cpu_usage_result = (cpu_total/8).toInt();
    // // print(cpu_usage_result);
    // old_cpu_usage_temp = cpu_usage_temp;

  }



  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            body: Container(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    child:
                      SfCartesianChart(
                        title: ChartTitle(text: 'CPU Usage'),
                        // legend: Legend(isVisible: true),
                        series: <SplineSeries>[
                          SplineSeries<SalesData, int>(
                            onRendererCreated: (ChartSeriesController controller) {
                              _chartSeriesController = controller;
                            },
                            name: 'CPU Usage',
                            dataSource: _chartData,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales,
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                            color: Colors.orange,
                            width: 10,
                            opacity: 0.5,
                          )
                        ],
                        primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                        // primaryYAxis: NumericAxis(
                        //     labelFormat: '{value}M',
                        //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
                      ),
                  ),
                  Container(child:
                    SfCartesianChart(
                      title: ChartTitle(text: 'GPU Usage'),
                      // legend: Legend(isVisible: true),
                      series: <SplineSeries>[
                        SplineSeries<SalesData, int>(
                          onRendererCreated: (ChartSeriesController controller) {
                            _chartSeriesController2 = controller;
                          },
                          name: 'GPU Usage',
                          dataSource: _chartData2,
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          color: Colors.orange,
                          width: 12,
                          opacity: 0.5,
                        )
                      ],
                      primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                      // primaryYAxis: NumericAxis(
                      //     // labelFormat: '{value}M',
                      //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
                    ),
                  ),
                ],
              ),
            ),
        ));
  }
}

class SalesData{
  SalesData(this.year, this.sales);
  final int year;
  final int sales;
}




