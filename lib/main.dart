import 'dart:async';

import 'package:flutter/material.dart';
import 'package:root/root.dart';

import 'package:syncfusion_flutter_charts/charts.dart';



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

  String gpuUsageG21 = "cat /sys/devices/platform/18500000.mali/utilization";
  String cpuUsageG21 = "cat /proc/stat";
  String netUsageG21 = "cat /proc/net/dev | grep lo| tail -n1";
  String cpu0FreqG21 = "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq";
  String cpu1FreqG21 = "cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq";
  String cpu2FreqG21 = "cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq";
  String cpu3FreqG21 = "cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq";
  String cpu4FreqG21 = "cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq";
  String cpu5FreqG21 = "cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq";
  String cpu6FreqG21 = "cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq";
  String cpu7FreqG21 = "cat /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq";
  String gpuFreqG21 = "cat /sys/devices/platform/18500000.mali/clock";
  String fpsG21 = "dumpsys SurfaceFlinger | grep default-format=4 | head -1";
  String temperature0G21 = "su -c cat /sys/class/thermal/thermal_zone0/temp";
  String temperature1G21 = "su -c cat /sys/class/thermal/thermal_zone1/temp";
  String temperature2G21 = "su -c cat /sys/class/thermal/thermal_zone2/temp";
  String temperature3G21 = "su -c cat /sys/class/thermal/thermal_zone3/temp";
  String temperature4G21 = "su -c cat /sys/class/thermal/thermal_zone4/temp";
  String temperature5G21 = "su -c cat /sys/class/thermal/thermal_zone5/temp";
  String temperature6G21 = "su -c cat /sys/class/thermal/thermal_zone6/temp";
  String temperature7G21 = "su -c cat /sys/class/thermal/thermal_zone7/temp";
  String temperature8G21 = "su -c cat /sys/class/thermal/thermal_zone8/temp";


  List<SalesData> _cpuUsageChartData = [];
  List<SalesData> _gpuUsageChartData = [];
  List<SalesData> _cpu0FreqChartData = [];
  List<SalesData> _cpu4FreqChartData = [];
  List<SalesData> _cpu7FreqChartData = [];
  List<SalesData> _gpuFreqChartData = [];
  List<SalesData> _fpsChartData = [];
  List<SalesData> _networkChartData = [];
  List<SalesData> _temperature0ChartData = [];

  List<String> oldCpuUsageTemp = [];
  int oldFpsValue = 0;
  int oldNetTraffic = 0;

  late ChartSeriesController _chartSeriesController;

  @override
  void initState() {

    // _start();

    _cpuUsageChartData = getChartData();
    _gpuUsageChartData = getChartData();
    _cpu0FreqChartData = getChartData();
    _cpu4FreqChartData = getChartData();
    _cpu7FreqChartData = getChartData();
    _gpuFreqChartData = getChartData();
    _fpsChartData = getChartData();
    _networkChartData = getChartData();
    _temperature0ChartData = getChartData();

    Timer.periodic(const Duration(seconds: 1), updateDataSource);
    super.initState();

  }

  int yeartmp = 2027;


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


  void updateDataSource(Timer timer){
    cpuUsage();
    gpuUsage();
    cpuFreq();
    gpuFreq();
    fpsResult();
    netResult();
    tempResult();

    _chartSeriesController.updateDataSource(
      addedDataIndex: _cpuUsageChartData.length -1,
      removedDataIndex: 0
    );

  }

  void gpuUsage() async{
    int gpuUsageResult = 0;
    var res = await Root.exec(cmd: gpuUsageG21);
    setState(() {
      gpuUsageResult = int.parse(res.toString());
      _gpuUsageChartData.add(SalesData(yeartmp++, gpuUsageResult));
      _gpuUsageChartData.removeAt(0);
    });
    // print("${await pipeline.stdout.text} instances of waitFor");
  }

  void cpuUsage() async{
    int cpuUsageResult = 0;
    int cpuCoreNum = 8;
    int oldUser = 0;
    int oldNice = 0;
    int oldSystem = 0;
    int oldIdle = 0;
    int oldIowait = 0;
    int oldIrq = 0;
    int oldSoftirq = 0;
    int oldSteal = 0;
    int oldQuest = 0;
    int oldQuestNice = 0;
    int dUser = 0;
    int dNice = 0;
    int dSystem = 0;
    int dIdle = 0;
    int dIowait = 0;
    int dIrq = 0;
    int dSoftirq = 0;
    int dSteal = 0;
    int dQuest = 0;
    int dQuestNice = 0;
    List<String> cpuUsageTemp = [];
    int previousIdle = 0;
    int currentIdle = 0;
    int previousNonIdle = 0;
    int currentNonIdle = 0;
    int previousTotal = 0;
    int currentTotal = 0;
    double diffTotal = 0;
    double diffIdle = 0;
    double cpuTotal = 0;



    var res = await Root.exec(cmd: cpuUsageG21);
    cpuUsageTemp = res.toString().split(" ");
    // String test = "";
    // int number = 0;
    // for(test in cpuUsageTemp){
    //     print("${number} 횟수");
    //     print(test);
    //     number++;
    // }


    for(int j = 0; j < cpuCoreNum; j++){
      if(oldCpuUsageTemp.isNotEmpty) {
        oldUser = int.parse(oldCpuUsageTemp[12 + j * 10]);
        oldNice = int.parse(oldCpuUsageTemp[13 + j * 10]);
        oldSystem = int.parse(oldCpuUsageTemp[14 + j * 10]);
        oldIdle = int.parse(oldCpuUsageTemp[15 + j * 10]);
        oldIowait = int.parse(oldCpuUsageTemp[16 + j * 10]);
        oldIrq = int.parse(oldCpuUsageTemp[17 + j * 10]);
        oldSoftirq = int.parse(oldCpuUsageTemp[18 + j * 10]);
        oldSteal = int.parse(oldCpuUsageTemp[19 + j * 10]);
        oldQuest = int.parse(oldCpuUsageTemp[20 + j * 10]);
        // oldQuestNice = int.parse(oldCpuUsageTemp[21 + j * 10]);
      }

      dUser = int.parse(cpuUsageTemp[12+j*10]);
      dNice = int.parse(cpuUsageTemp[13+j*10]);
      dSystem = int.parse(cpuUsageTemp[14+j*10]);
      dIdle = int.parse(cpuUsageTemp[15+j*10]);
      dIowait = int.parse(cpuUsageTemp[16+j*10]);
      dIrq = int.parse(cpuUsageTemp[17+j*10]);
      dSoftirq = int.parse(cpuUsageTemp[18+j*10]);
      dSteal = int.parse(cpuUsageTemp[19+j*10]);
      dQuest = int.parse(cpuUsageTemp[20+j*10]);
      // dQuestNice = int.parse(cpuUsageTemp[21+j*11]);

      previousIdle = oldIdle + oldIowait;
      currentIdle = dIdle + dIowait;

      previousNonIdle = oldUser + oldNice + oldSystem + oldIrq + oldSoftirq + oldSteal;
      currentNonIdle = dUser + dNice + dSystem + dIrq + dSoftirq + dSteal;

      previousTotal = previousIdle + previousNonIdle;
      currentTotal = currentIdle + currentNonIdle;

      diffTotal = (currentTotal - previousTotal).toDouble();
      diffIdle = (currentIdle - previousIdle).toDouble();

      cpuTotal = ((diffTotal - diffIdle) / diffTotal * 100 )+ cpuTotal;

    }
    cpuUsageResult = (cpuTotal/8).toInt();
    // print(cpuUsageResult);
    oldCpuUsageTemp = cpuUsageTemp;

    _cpuUsageChartData.add(SalesData(yeartmp++, cpuUsageResult));
    _cpuUsageChartData.removeAt(0);

    setState(() {

    });
  }

  void cpuFreq() async{
    double cpu0FreqResult = 0;
    double cpu4FreqResult = 0;
    double cpu7FreqResult = 0;

    var res0 = await Root.exec(cmd: cpu0FreqG21);
    // var res1 = await Root.exec(cmd: cpu1FreqG21);
    // var res2 = await Root.exec(cmd: cpu2FreqG21);
    // var res3 = await Root.exec(cmd: cpu3FreqG21);
    var res4 = await Root.exec(cmd: cpu4FreqG21);
    // var res5 = await Root.exec(cmd: cpu5FreqG21);
    // var res6 = await Root.exec(cmd: cpu6FreqG21);
    var res7 = await Root.exec(cmd: cpu7FreqG21);

    cpu0FreqResult = int.parse(res0.toString())/1000000;
    cpu4FreqResult = int.parse(res4.toString())/1000000;
    cpu7FreqResult = int.parse(res7.toString())/1000000;

    _cpu0FreqChartData.add(SalesData(yeartmp++, cpu0FreqResult.toInt()));
    _cpu0FreqChartData.removeAt(0);

    _cpu4FreqChartData.add(SalesData(yeartmp++, cpu4FreqResult.toInt()));
    _cpu4FreqChartData.removeAt(0);

    _cpu7FreqChartData.add(SalesData(yeartmp++, cpu7FreqResult.toInt()));
    _cpu7FreqChartData.removeAt(0);
    setState(() {

    });

  }

  void gpuFreq() async{
    double gpuFreqResult = 0;

    var res0 = await Root.exec(cmd: gpuFreqG21);

    gpuFreqResult = int.parse(res0.toString())/1000000;

    _gpuFreqChartData.add(SalesData(yeartmp++, gpuFreqResult.toInt()));
    _gpuFreqChartData.removeAt(0);

    setState(() {

    });

  }

  void fpsResult() async{
    List<String> _fpsResult = [];
    int _fpsnum = 0;
    int _framecounterEnd = 14;
    int _fpsValueResult = 0;

    var res = await Root.exec(cmd: fpsG21);
    _fpsResult = res.toString().split(" ");
    _fpsnum = int.parse(_fpsResult[7].substring(_framecounterEnd, _fpsResult[7].length));

    _fpsValueResult = _fpsnum - oldFpsValue;

    _fpsChartData.add(SalesData(yeartmp++, _fpsValueResult));
    _fpsChartData.removeAt(0);

    oldFpsValue = _fpsnum;

    setState(() {
    });

  }

  void netResult() async{
    List<String> _netResult = [];
    int _netRecv = 0;
    int _netSend = 0;
    double _netTraffic = 0;

    var res = await Root.exec(cmd: netUsageG21);
    _netResult = res.toString().split(" ");
    _netRecv = int.parse(_netResult[5]);
    _netSend = int.parse(_netResult[44]);
    _netTraffic = ((_netRecv + _netSend) - oldNetTraffic)/1000;

    oldNetTraffic = _netRecv + _netSend;

    _networkChartData.add(SalesData(yeartmp++, _netTraffic.toInt()));
    _networkChartData.removeAt(0);

    setState(() {
    });

  }

  void tempResult() async{
    int _temp0Result = 0;

    var res = await Root.exec(cmd: temperature0G21);
    _temp0Result = int.parse(res.toString());

    _temperature0ChartData.add(SalesData(yeartmp++, _temp0Result));
    _temperature0ChartData.removeAt(0);

    setState(() {
    });

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
            body: Container(
              child: ListView(
                children: [
                  graphArc(_cpuUsageChartData, 150, "CPU usage"),
                  graphArc(_gpuUsageChartData, 150, "GPU usage"),
                  graphArc(_cpu0FreqChartData, 150, "CPU 0 Freq"),
                  graphArc(_cpu4FreqChartData, 150, "CPU 4 Freq"),
                  graphArc(_cpu7FreqChartData, 150, "CPU 7 Freq"),
                  graphArc(_gpuFreqChartData, 150, "GPU Freq"),
                  graphArc(_fpsChartData, 150, "FPS Value"),
                  graphArc(_networkChartData, 150, "Network Traffic"),
                  graphArc(_temperature0ChartData, 150, "Temperature"),
                ],
              ),
            ),
        ));
  }

  Widget graphArc(List<SalesData> _cpuUsageChartData, double height, String title){

    return Container(
      height: height,
      child:
      SfCartesianChart(
        title: ChartTitle(text: title),
        // legend: Legend(isVisible: true),
        series: <SplineSeries>[
          SplineSeries<SalesData, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            name: title,
            dataSource: _cpuUsageChartData,
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
    );
  }
}

class SalesData{
  SalesData(this.year, this.sales);
  final int year;
  final int sales;
}




