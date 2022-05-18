
// ignore_for_file: prefer_const_constructors

import 'dart:async';
// import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:root/root.dart';
import 'package:screenshot/screenshot.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled2/alldata.dart';
import 'package:untitled2/data/database2.dart';
import 'package:untitled2/data/profiling.dart';
import 'package:untitled2/getpicture.dart';

import 'data/util.dart';
import 'package:flutter_background/flutter_background.dart';
// import 'package:intl/intl.dart';

import 'package:permission_handler/permission_handler.dart';

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

  final dbHelper = DatabaseHelper();
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  List<Profiling> profilings = [];

  // DateTime time = DateTime.now();
  int timE = 0;
  int selectIndex = 0;
  bool currentState = false;

  bool _cpuChecked = false;
  bool _gpuChecked = false;
  bool _cpu0freqChecked = true;
  bool _cpu4freqChecked = true;
  bool _cpu7freqChecked = true;
  bool _gpufreqChecked = true;
  bool _fpsChecked = true;
  bool _networkChecked = false;
  bool _temp0Checked = true;
  bool _temp1Checked = true;
  bool _temp2Checked = true;
  bool _temp3Checked = false;
  bool _temp8Checked = false;

  bool _ddrclkChecked = true;

  String gpuUsageG21 = "cat /sys/devices/platform/18500000.mali/utilization";
  String cpuUsageG21 = "cat /proc/stat";
  String netUsageG21 = "cat /proc/net/dev | grep rmnet1| tail -n1";
  String cpu0FreqG21 = "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq";
  String cpu1FreqG21 = "cat /sys/devices/system/cpu/cpu1/cpufreq/scaling_cur_freq";
  String cpu2FreqG21 = "cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_cur_freq";
  String cpu3FreqG21 = "cat /sys/devices/system/cpu/cpu3/cpufreq/scaling_cur_freq";
  String cpu4FreqG21 = "cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_cur_freq";
  String cpu5FreqG21 = "cat /sys/devices/system/cpu/cpu5/cpufreq/scaling_cur_freq";
  String cpu6FreqG21 = "cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq";
  String cpu7FreqG21 = "cat /sys/devices/system/cpu/cpu7/cpufreq/scaling_cur_freq";
  String gpuFreqG21 = "cat /sys/devices/platform/18500000.mali/clock";
  // String fpsG21 = "dumpsys SurfaceFlinger | grep default-format=4 | head -1"; // Galaxy S21+
  String fpsG21 = "dumpsys SurfaceFlinger | grep \"HWC frame count\""; // Galaxy S21 Ultra Game
  String temperature0G21 = "su -c cat /sys/class/thermal/thermal_zone0/temp"; // BIG
  String temperature1G21 = "su -c cat /sys/class/thermal/thermal_zone1/temp"; // MID
  String temperature2G21 = "su -c cat /sys/class/thermal/thermal_zone2/temp"; // LITTLE
  String temperature3G21 = "su -c cat /sys/class/thermal/thermal_zone3/temp"; // G3D
  String temperature4G21 = "su -c cat /sys/class/thermal/thermal_zone4/temp";
  String temperature5G21 = "su -c cat /sys/class/thermal/thermal_zone5/temp";
  String temperature6G21 = "su -c cat /sys/class/thermal/thermal_zone6/temp";
  String temperature7G21 = "su -c cat /sys/class/thermal/thermal_zone7/temp"; // AC
  String temperature8G21 = "su -c cat /sys/class/thermal/thermal_zone8/temp"; // Battery
  String ddrclk = "su -c /data/local/tmp/clk_s.sh -d";

  String screencap = "screencap -p /storage/emulated/0/Download/screen.jpg";
  String capResult = "";

  ScreenshotController screenshotController = ScreenshotController();


  final myController = TextEditingController();
  final cpu0freqctrl = TextEditingController();
  // final capimgctrl = TextEditingController();
  // int imgcounter = 1;


  List<trackData> _cpuUsageChartData = [];
  List<trackData> _gpuUsageChartData = [];
  List<trackData> _cpu0FreqChartData = [];
  List<trackData> _cpu4FreqChartData = [];
  List<trackData> _cpu7FreqChartData = [];
  List<trackData> _gpuFreqChartData = [];
  List<trackData> _fpsChartData = [];
  List<trackData> _networkChartData = [];
  List<trackData> _temperature0ChartData = [];
  List<trackData> _temperature1ChartData = [];
  List<trackData> _temperature2ChartData = [];
  List<trackData> _temperature3ChartData = [];
  List<trackData> _temperature8ChartData = [];
  List<trackData> _ddrclkChartData = [];

  List<String?> capresult = [];



  int cpuUsageTemp_f = 0;
  int testCounter = 0;

  List<String> oldCpuUsageTemp = [];
  int oldFpsValue = 0;
  int oldNetTraffic = 0;

  // late ChartSeriesController _chartSeriesController;
  Timer _timer = Timer(const Duration(seconds: 100), (){});
  int floatingCounter = 0;

  @override
  void initState() {



    permissionset();
    // screencapDo();

    getCounter();
    bakgroundset();
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
    _temperature1ChartData = getChartData();
    _temperature2ChartData = getChartData();
    _temperature3ChartData = getChartData();
    _temperature8ChartData = getChartData();

    _ddrclkChartData = getChartData();

    // capimgctrl.text = "0";
    // cpuGovernor();

    // clockSet();
    _tooltipBehavior =  TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, enablePanning: true);


    super.initState();

  }

  void permissionset() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  void clockSet() async{

    String clocktemp0 = cpu0freqctrl.text;
    await Root.exec(
        cmd: "su -c echo $clocktemp0 >> /sys/devices/platform/17000010.devfreq_mif/devfreq/17000010.devfreq_mif/exynos_data/debug_scaling_devfreq_max");
    // await Root.exec(
    //     cmd: "su -c echo $clocktemp0 >> /sys/devices/system/cpu/cpufreq/policy0/scaling_governor");
    // //
    // //
    // // int clocktemp4 = int.parse(cpu4freqctrl.text);
    // //
    // await Root.exec(
    //     cmd: "su -c echo $clocktemp0 >> /sys/devices/system/cpu/cpufreq/policy4/scaling_governor");
    // // await Root.exec(
    // //     cmd: "su -c echo $clocktemp4 >> /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq");
    // //
    // await Root.exec(
    //     cmd: "su -c echo $clocktemp0 >> /sys/devices/system/cpu/cpufreq/policy7/scaling_governor");
    // await Root.exec(
    //     cmd: "su -c echo $clocktemp4 >> /sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq");


    setState(() {
    });
  }

  void bakgroundset() async {
    final androidConfig = FlutterBackgroundAndroidConfig(
      notificationTitle: "flutter_background example app",
      notificationText: "Background notification for keeping the example app running in the background",
      notificationImportance: AndroidNotificationImportance.Default,
      notificationIcon: AndroidResource(name: 'background_icon', defType: 'drawable'), // Default is ic_launcher from folder mipmap
    );
    bool success = await FlutterBackground.initialize(androidConfig: androidConfig);
}

  void putProfiling(Profiling pro) async {
    await dbHelper.InsertProfiling(pro);
    setState(() {

    });
  }
  void getAllProfilingData() async{
    profilings = await dbHelper.getAllProfilinig();
    setState(() {

    });
  }

  void getCounter() async{
    testCounter = await dbHelper.getLastRow();
    setState(() {

    });
    // final data = await dbHelper.rawQuery()
    // profilings = await dbHelper.getAllProfilinig();
    // testCounter = profilings.
  }



  int xAxistmp = 2;
  List<trackData> getChartData(){
    final List<trackData> chartData = [
      trackData(1, 1),
      trackData(2, 1),
      trackData(3, 1),
      // trackData(4, 1),
      // trackData(5, 1),
      // trackData(6, 1),
      // trackData(7, 1),
      // trackData(8, 1),
      // trackData(9, 1),
      // trackData(10, 1),
      // trackData(11, 1),
      // trackData(12, 1)
      // trackData(2025, 18),
      // trackData(2027, 30),
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
    ddrResult();
    screencapDo();

    // if(_cpuChecked == true){cpuUsage();}
    // if(_gpuChecked == true){ gpuUsage();}
    // if(_cpu0freqChecked == true){cpuFreq();}
    // if(_cpu4freqChecked == true){cpuFreq();}
    // if(_cpu7freqChecked == true){cpuFreq();}
    // if(_gpufreqChecked == true){gpuFreq();}
    // if(_fpsChecked == true){fpsResult();}
    // if(_networkChecked == true){netResult();}
    // if(_temp0Checked == true){tempResult();}


    Profiling todayProfiling = Profiling(
        time: xAxistmp,
        count: testCounter,
        CPUusage: _cpuUsageChartData[_cpuUsageChartData.length-1].yAxis,
        GPUusage: _gpuUsageChartData[_gpuUsageChartData.length-1].yAxis,
        CPU0Freq: _cpu0FreqChartData[_cpu0FreqChartData.length-1].yAxis,
        CPU4Freq: _cpu4FreqChartData[_cpu4FreqChartData.length-1].yAxis,
        CPU7Freq: _cpu7FreqChartData[_cpu7FreqChartData.length-1].yAxis,
        GPUFreq: _gpuFreqChartData[_gpuFreqChartData.length-1].yAxis,
        FPS: _fpsChartData[_fpsChartData.length-1].yAxis,
        Network: _networkChartData[_networkChartData.length-1].yAxis,
        Temp0: _temperature0ChartData[_temperature0ChartData.length-1].yAxis,
        Temp1: _temperature1ChartData[_temperature1ChartData.length-1].yAxis,
        Temp2: _temperature2ChartData[_temperature2ChartData.length-1].yAxis,
        Temp3: _temperature3ChartData[_temperature3ChartData.length-1].yAxis,
        Temp8: _temperature8ChartData[_temperature8ChartData.length-1].yAxis,
        ttime: timE,
        textf: myController.text,
        ddrclk: _ddrclkChartData[_ddrclkChartData.length-1].yAxis,
        capimg: capResult,
    );
    putProfiling(todayProfiling);


    xAxistmp++;
    // _chartSeriesController.updateDataSource(
    //   addedDataIndex: _cpuUsageChartData.length -1,
    //   removedDataIndex: 0
    // );

  }

  void screencapDo() async{

    // screenshotController.capture().then((Uint8List image) {
    //   print(image);
    // }).catchError((onError) {
    //   print(onError);
    // });

    int screen = 0;
    var res = await Root.exec(cmd: screencap);
    String imagepath = "/storage/emulated/0/Download/screen.jpg";
    File imagefile = File(imagepath);
    Uint8List imagebytes = await imagefile.readAsBytes();
    capResult = Utils.base64String(imagebytes);
    setState(() {
      // gpuUsageResult = int.parse(res.toString());
      // _gpuUsageChartData.add(trackData(xAxistmp, gpuUsageResult));
      // _gpuUsageChartData.removeAt(0);
    });

    // print("${await pipeline.stdout.text} instances of waitFor");
  }

  void gpuUsage() async{
    int gpuUsageResult = 0;
    var res = await Root.exec(cmd: gpuUsageG21);
    setState(() {
      gpuUsageResult = int.parse(res.toString());
      _gpuUsageChartData.add(trackData(xAxistmp, gpuUsageResult));
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
    // int oldQuest = 0;
    // int oldQuestNice = 0;
    int dUser = 0;
    int dNice = 0;
    int dSystem = 0;
    int dIdle = 0;
    int dIowait = 0;
    int dIrq = 0;
    int dSoftirq = 0;
    int dSteal = 0;
    // int dQuest = 0;
    // int dQuestNice = 0;
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
        // oldQuest = int.parse(oldCpuUsageTemp[20 + j * 10]);
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
      // dQuest = int.parse(cpuUsageTemp[20+j*10]);
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
    // cpuUsageResult = (cpuTotal/8).toInt();
    cpuUsageResult = cpuTotal ~/ 8;

    oldCpuUsageTemp = cpuUsageTemp;

    _cpuUsageChartData.add(trackData(xAxistmp, cpuUsageResult));
    _cpuUsageChartData.removeAt(0);



    setState(() {

    });
  }

  void cpuFreq() async{
    double cpu0FreqResult = 0;
    double cpu4FreqResult = 0;
    double cpu7FreqResult = 0;

    var res0 = await Root.exec(cmd: cpu0FreqG21);
    // var res0 = 0;
    // var res1 = await Root.exec(cmd: cpu1FreqG21);
    // var res2 = await Root.exec(cmd: cpu2FreqG21);
    // var res3 = await Root.exec(cmd: cpu3FreqG21);
    var res4 = await Root.exec(cmd: cpu4FreqG21);
    // var res4 = 0;
    // var res5 = await Root.exec(cmd: cpu5FreqG21);
    // var res6 = await Root.exec(cmd: cpu6FreqG21);
    var res7 = await Root.exec(cmd: cpu7FreqG21);

    cpu0FreqResult = int.parse(res0.toString())/1000;
    cpu4FreqResult = int.parse(res4.toString())/1000;
    cpu7FreqResult = int.parse(res7.toString())/1000;

    _cpu0FreqChartData.add(trackData(xAxistmp, cpu0FreqResult.toInt()));
    _cpu0FreqChartData.removeAt(0);



    _cpu4FreqChartData.add(trackData(xAxistmp, cpu4FreqResult.toInt()));
    _cpu4FreqChartData.removeAt(0);



    _cpu7FreqChartData.add(trackData(xAxistmp, cpu7FreqResult.toInt()));
    _cpu7FreqChartData.removeAt(0);



    setState(() {

    });

  }

  void gpuFreq() async{
    double gpuFreqResult = 0;

    var res0 = await Root.exec(cmd: gpuFreqG21);

    gpuFreqResult = int.parse(res0.toString())/1000;

    _gpuFreqChartData.add(trackData(xAxistmp, gpuFreqResult.toInt()));
    _gpuFreqChartData.removeAt(0);


    setState(() {

    });

  }

  void fpsResult() async{
    // List<String> _fpsResult = [];
    int _fpsResult;
    // double _fpstemp;
    // int _fpsnum = 0;
    int _framecounterEnd = 14;
    int _fpsValueResult = 0;

    // print(fpsG21);
    var res = await Root.exec(cmd: fpsG21);
    // _fpsResult = res.toString().split(" ");

    _fpsResult = int.parse(res.toString().replaceAll(RegExp(r'[^0-9]'),""));
    // print(_fpsResult);
    // _fpsnum = int.parse(_fpsResult[7].substring(_framecounterEnd, _fpsResult[7].length));

    _fpsValueResult = _fpsResult - oldFpsValue;

    _fpsChartData.add(trackData(xAxistmp, _fpsValueResult));
    _fpsChartData.removeAt(0);


    oldFpsValue = _fpsResult;

    setState(() {
    });

  }

  void netResult() async{
    List<String> _netResult = [];
    int _netRecv = 0;
    int _netSend = 0;
    double _netTraffic = 0;

    // var res = await Root.exec(cmd: netUsageG21);
    var res = 0;
    _netResult = res.toString().split(" ");

    // _netRecv = int.parse(_netResult[1]);
    // _netSend = int.parse(_netResult[42]);

    _netRecv = 10000;
    _netSend = 10000;

    _netTraffic = ((_netRecv + _netSend) - oldNetTraffic)/1000;

    oldNetTraffic = _netRecv + _netSend;

    _networkChartData.add(trackData(xAxistmp, _netTraffic.toInt()));
    _networkChartData.removeAt(0);


    setState(() {
    });

  }

  void ddrResult() async{
    // List<String> _ddrResult = [];
    String _ddrResult;
    double _ddrtemp = 0;

    var res = await Root.exec(cmd: ddrclk);
    // _ddrResult = res.toString().replaceAll("[^0-9]","");
    // _ddrResult = res.toString();
    _ddrResult = res.toString().replaceAll(RegExp(r'[^0-9]'),"");
    // print(_ddrResult);

    _ddrtemp = int.parse(_ddrResult)/1000;
    // print(_ddrtemp);
    // _ddrtemp = int.parse(_ddrResult[1]);

    _ddrclkChartData.add(trackData(xAxistmp, _ddrtemp.toInt()));
    _ddrclkChartData.removeAt(0);


    setState(() {
    });

  }

  void tempResult() async{
    int _temp0Result = 0;
    int _temp1Result = 0;
    int _temp2Result = 0;
    int _temp3Result = 0;
    int _temp8Result = 0;


    var res = await Root.exec(cmd: temperature0G21);
    _temp0Result = (int.parse(res.toString())/1000).floor();

    var res1 = await Root.exec(cmd: temperature1G21);
    // var res1 = 0;
    _temp1Result = (int.parse(res1.toString())/1000).floor();

    var res2 = await Root.exec(cmd: temperature2G21);
    // var res2 = 0;
    _temp2Result = (int.parse(res2.toString())/1000).floor();

    // var res3 = await Root.exec(cmd: temperature3G21);
    var res3 = 0;
    _temp3Result = (int.parse(res3.toString())/1000).floor();

    // var res8 = await Root.exec(cmd: temperature8G21);
    var res8 = 0;
    _temp8Result = (int.parse(res8.toString())/1000).floor();


    _temperature0ChartData.add(trackData(xAxistmp, _temp0Result));
    _temperature0ChartData.removeAt(0);

    _temperature1ChartData.add(trackData(xAxistmp, _temp1Result));
    _temperature1ChartData.removeAt(0);

    _temperature2ChartData.add(trackData(xAxistmp, _temp2Result));
    _temperature2ChartData.removeAt(0);

    _temperature3ChartData.add(trackData(xAxistmp, _temp3Result));
    _temperature3ChartData.removeAt(0);

    _temperature8ChartData.add(trackData(xAxistmp, _temp8Result));
    _temperature8ChartData.removeAt(0);

    setState(() {
    });

  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          body:Container(child: getPage()),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(Icons.wb_incandescent_rounded),
                  onPressed: (){
                    if(floatingCounter % 2 == 1) {
                      _timer.cancel();
                      currentState = false;
                    }else{
                      testCounter++;
                      _timer = Timer.periodic(const Duration(seconds: 1), updateDataSource);
                      currentState = true;
                      timE = Utils.getFormatTime(DateTime.now());
                      xAxistmp = 2;
                      clockSet();
                    }
                    floatingCounter++;
                  }),
              // FloatingActionButton(
              //   child: Icon(Icons.photo_camera),
              //   onPressed: () async {
              //
              //
              //     await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => getAllPicturePage(capresult: capresult)) );
              //
              //     // xAxistmp = 2;
              //     // imgcounter = int.parse(capimgctrl.text);
              //     setState(() {
              //     });
              //     // await dbHelper.InsertProfiling(todayProfiling);
              //   },
              // ),

            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.today_outlined),
                label: "Profiling"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.abc_outlined),
                label: "Profilied"
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_horiz),
                label: "AllData"
              ),
            ],
            currentIndex: selectIndex,
            onTap: (idx){
              setState(() {
                selectIndex = idx;
              });
              if(selectIndex == 1){
                getAllProfilingData();
                // getAllProfiling();
                // print(allprofilings[0].title);
              }
            },
          ),
        ));
  }

  Widget getPage(){
    if (selectIndex == 0){
      return getCurrentProfiling();
    }else if(selectIndex == 1){
      return getOldProfiling();
    }else{
      return getAllData();
    }
  }

  Widget getCurrentProfiling(){

    return Container(
      child: Center(
        child: ListView(
            children: [
              cpucheckedBox(),
              cpu0freqcheckedBox(),
              cpu4freqcheckedBox(),
              cpu7freqcheckedBox(),
              gpucheckedBox(),
              gpufreqcheckedBox(),
              fpscheckedBox(),
              netcheckedBox(),
              temp0checkedBox(),
              temp1checkedBox(),
              temp2checkedBox(),
              temp3checkedBox(),
              temp8checkedBox(),

              ddrclkcheckedBox(),
              Text("${currentState}"),
              Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  controller: myController,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: TextField(
                  controller: cpu0freqctrl,
                ),
              ),
              // Container(
              //   margin: EdgeInsets.all(8),
              //   child: TextField(
              //     controller: cpu4freqctrl,
              //   ),
              // ),


              // Text("${timE}")
            ],
    )));

      // child: ListView(
      //   children: [
      //     graphArc(_cpuUsageChartData, 150, "CPU usage"),
      //     // graphArc(_gpuUsageChartData, 150, "GPU usage"),
      //     // graphArc(_cpu0FreqChartData, 150, "CPU 0 Freq"),
      //     // graphArc(_cpu4FreqChartData, 150, "CPU 4 Freq"),
      //     // graphArc(_cpu7FreqChartData, 150, "CPU 7 Freq"),
      //     // graphArc(_gpuFreqChartData, 150, "GPU Freq"),
      //     // graphArc(_fpsChartData, 150, "FPS Value"),
      //     // graphArc(_networkChartData, 150, "Network Traffic"),
      //     // graphArc(_temperature0ChartData, 150, "Temperature"),
      //
      //   ],
      // ),
    // );
  }

  Widget cpucheckedBox(){
    return Container(
         child: CheckboxListTile(
            title: const Text('CPU Usage'),
            value: _cpuChecked,
            onChanged: (bool? value){
              setState(() {
                _cpuChecked = value!;
              });
            },
          )
    );
  }

  Widget gpucheckedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('GPU Usage'),
          value: _gpuChecked,
          onChanged: (bool? value){
            setState(() {
              _gpuChecked = value!;
            });
          },
        )
    );
  }

  Widget cpu0freqcheckedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('CPU 0 Freq'),
          value: _cpu0freqChecked,
          onChanged: (bool? value){
            setState(() {
              _cpu0freqChecked = value!;
            });
          },
        )
    );
  }

  Widget cpu4freqcheckedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('CPU 4 Freq'),
          value: _cpu4freqChecked,
          onChanged: (bool? value){
            setState(() {
              _cpu4freqChecked = value!;
            });
          },
        )
    );
  }

  Widget cpu7freqcheckedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('CPU 4 Freq'),
          value: _cpu7freqChecked,
          onChanged: (bool? value){
            setState(() {
              _cpu7freqChecked = value!;
            });
          },
        )
    );
  }

  Widget gpufreqcheckedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('GPU Freq'),
          value: _gpufreqChecked,
          onChanged: (bool? value){
            setState(() {
              _gpufreqChecked = value!;
            });
          },
        )
    );
  }

  Widget fpscheckedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('FPS'),
          value: _fpsChecked,
          onChanged: (bool? value){
            setState(() {
              _fpsChecked = value!;
            });
          },
        )
    );
  }

  Widget netcheckedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('NETWORK Traffic'),
          value: _networkChecked,
          onChanged: (bool? value){
            setState(() {
              _networkChecked = value!;
            });
          },
        )
    );
  }

  Widget temp0checkedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('Temp 0'),
          value: _temp0Checked,
          onChanged: (bool? value){
            setState(() {
              _temp0Checked = value!;
            });
          },
        )
    );
  }

  Widget temp1checkedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('Temp 1'),
          value: _temp1Checked,
          onChanged: (bool? value){
            setState(() {
              _temp1Checked = value!;
            });
          },
        )
    );
  }

  Widget temp2checkedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('Temp 2'),
          value: _temp2Checked,
          onChanged: (bool? value){
            setState(() {
              _temp2Checked = value!;
            });
          },
        )
    );
  }

  Widget temp3checkedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('Temp 3'),
          value: _temp3Checked,
          onChanged: (bool? value){
            setState(() {
              _temp3Checked = value!;
            });
          },
        )
    );
  }
  Widget temp8checkedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('Temp 8'),
          value: _temp8Checked,
          onChanged: (bool? value){
            setState(() {
              _temp8Checked = value!;
            });
          },
        )
    );
  }

  Widget ddrclkcheckedBox(){
    return Container(
        child: CheckboxListTile(
          title: const Text('DDR CLK'),
          value: _ddrclkChecked,
          onChanged: (bool? value){
            setState(() {
              _ddrclkChecked = value!;
            });
          },
        )
    );
  }

  Widget getOldProfiling(){
    final List<trackData> chartData = [ trackData(1, 0), trackData(2, 0)];

    List<trackData> _cpuUsage_temp = [];
    List<trackData> _gpuUsage_temp = [];
    List<trackData> _cpu0Freq_temp = [];
    List<trackData> _cpu4Freq_temp = [];
    List<trackData> _cpu7Freq_temp = [];
    List<trackData> _gpuFreq_temp = [];
    List<trackData> _fps_temp = [];
    List<trackData> _network_temp = [];
    List<trackData> _temperature0_temp = [];
    List<trackData> _temperature1_temp = [];
    List<trackData> _temperature2_temp = [];
    List<trackData> _temperature3_temp = [];
    List<trackData> _temperature8_temp = [];

    List<trackData> _ddrclk_temp = [];
    int? time = 0;
    String? textf;
    // List<String?> capresult = [];

    // int temp = 0;

    for(var profiling in profilings){
      if(profiling.count == testCounter){
        if(_cpuChecked == true){_cpuUsage_temp.add(trackData(profiling.time, profiling.CPUusage));}
        if(_gpuChecked == true){ _gpuUsage_temp.add(trackData(profiling.time, profiling.GPUusage));}
        if(_cpu0freqChecked == true){_cpu0Freq_temp.add(trackData(profiling.time, profiling.CPU0Freq));}
        if(_cpu4freqChecked == true){_cpu4Freq_temp.add(trackData(profiling.time, profiling.CPU4Freq));}
        if(_cpu7freqChecked == true){_cpu7Freq_temp.add(trackData(profiling.time, profiling.CPU7Freq));}
        if(_gpufreqChecked == true){_gpuFreq_temp.add(trackData(profiling.time, profiling.GPUFreq));}
        if(_fpsChecked == true){_fps_temp.add(trackData(profiling.time, profiling.FPS));}
        if(_networkChecked == true){_network_temp.add(trackData(profiling.time, profiling.Network));}
        if(_temp0Checked == true){_temperature0_temp.add(trackData(profiling.time, profiling.Temp0));}
        if(_temp1Checked == true){_temperature1_temp.add(trackData(profiling.time, profiling.Temp1));}
        if(_temp2Checked == true){_temperature2_temp.add(trackData(profiling.time, profiling.Temp2));}
        if(_temp3Checked == true){_temperature3_temp.add(trackData(profiling.time, profiling.Temp3));}
        if(_temp8Checked == true){_temperature8_temp.add(trackData(profiling.time, profiling.Temp8));}
        if(_ddrclkChecked == true){_ddrclk_temp.add(trackData(profiling.time, profiling.ddrclk));}
        time = profiling.ttime;
        textf = profiling.textf;
        capresult.add(profiling.capimg);
      }

    }


    return profilings.isEmpty ? Container() : Container(
      child: ListView(
        children: [
          Text("${time}"),
          Text("${textf}"),

          oldgraph(_cpuUsage_temp, _cpuChecked, "CPU Usage"),
          oldgraph(_cpu0Freq_temp, _cpu0freqChecked, "CPU 0 Freq"),
          oldgraph(_cpu4Freq_temp, _cpu4freqChecked, "CPU 4 Freq"),
          oldgraph(_cpu7Freq_temp, _cpu7freqChecked, "CPU 7 Freq"),
          oldgraph(_gpuUsage_temp, _gpuChecked, "GPU Usage"),
          oldgraph(_gpuFreq_temp, _gpufreqChecked, "GPU Freq"),
          oldgraph(_fps_temp, _fpsChecked, "FPS"),
          oldgraph(_network_temp, _networkChecked, "Network"),
          oldgraph(_temperature0_temp, _temp0Checked, "Temp 0"),
          oldgraph(_temperature1_temp, _temp1Checked, "Temp 1"),
          oldgraph(_temperature2_temp, _temp2Checked, "Temp 2"),
          oldgraph(_temperature3_temp, _temp3Checked, "Temp 3"),
          oldgraph(_temperature8_temp, _temp8Checked, "Temp 8"),
          oldgraph(_ddrclk_temp, _ddrclkChecked, "DDR CLK"),
          InkWell(child: Container(
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                // borderRadius: BorderRadius.circular(100)
            ),
            child: Text("pciture"),
          ),
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => getAllPicturePage(capresult: capresult)) );
              setState(() {});
            },
          ),
        ],
      ),
    );

  }

  // Widget getAllpicture(List<String?> capresulttemp){
  //   // int temp = 0;
  //   // print(capresulttemp.length);
  //   return capresulttemp.isEmpty ? Container() : Container(
  //     margin: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
  //     child: ListView(
  //       scrollDirection: Axis.vertical,
  //       children: List.generate(capresulttemp.length, (_idx){
  //         // temp++;
  //         // print(_idx);
  //         return Container(
  //           height: 70,
  //           width: 700,
  //           margin: EdgeInsets.symmetric(vertical: 10),
  //           child: Text("${_idx}"),
  //         );
  //       }),
  //     ),
  //   );
  // }

  Widget getAllpicture(){
    int temp = 0;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(1, (_idx){
          temp++;
          return InkWell(child: Container(
            height: 70,
            width: 700,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text("Picture List"),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              // borderRadius: BorderRadius.circular(50)
            ),
          ),onTap: () async{
            // await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => GetAllDataPage(testCounter: _idx, cpuChecked: _cpuChecked, gpuChecked: _gpuChecked, cpu0freqChecked: _cpu0freqChecked, cpu4freqChecked: _cpu4freqChecked, cpu7freqChecked: _cpu7freqChecked, gpufreqChecked: _gpufreqChecked, fpsChecked: _fpsChecked, networkChecked: _networkChecked, temp0Checked: _temp0Checked, temp1Checked: _temp1Checked, temp2Checked: _temp2Checked, temp3Checked: _temp3Checked, temp8Checked: _temp8Checked,ddrclkChecked: _ddrclkChecked,)) );

          },
          );
        }),
      ),
    );
  }

  Widget getAllData(){
    int temp = 0;
    return profilings.isEmpty ? Container() : Container(
      margin: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(testCounter, (_idx){
          temp++;
          return InkWell(child: Container(
            height: 70,
            width: 700,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text("${temp}"),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                // borderRadius: BorderRadius.circular(50)
            ),
          ),onTap: () async{
            await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => GetAllDataPage(testCounter: _idx, cpuChecked: _cpuChecked, gpuChecked: _gpuChecked, cpu0freqChecked: _cpu0freqChecked, cpu4freqChecked: _cpu4freqChecked, cpu7freqChecked: _cpu7freqChecked, gpufreqChecked: _gpufreqChecked, fpsChecked: _fpsChecked, networkChecked: _networkChecked, temp0Checked: _temp0Checked, temp1Checked: _temp1Checked, temp2Checked: _temp2Checked, temp3Checked: _temp3Checked, temp8Checked: _temp8Checked,ddrclkChecked: _ddrclkChecked,)) );

          },
          );
        }),
      ),
    );
  }

  Widget oldgraph(List<trackData> chartData, bool temp, String Tempstr){
    // _tooltipBehavior =  TooltipBehavior(enable: true);


    return temp == false ? Container(
      height: 1,
    ) : Container(
        height: 200,
        child: SfCartesianChart(
            title: ChartTitle(
              text: Tempstr,
            ),
            zoomPanBehavior: _zoomPanBehavior,
            tooltipBehavior: _tooltipBehavior,
            primaryXAxis: CategoryAxis(),
            series: <ChartSeries>[
              // Renders line chart
              LineSeries<trackData, int>(
                  enableTooltip: true,
                  dataSource: chartData,
                  xValueMapper: (trackData data, _) => data.xAxis,
                  yValueMapper: (trackData data, _) => data.yAxis,
                  // markerSettings: MarkerSettings(isVisible: true),
                  // dataLabelSettings: DataLabelSettings(isVisible: true),
                  // color: Colors.orange,
                  width: 5,
                  opacity: 0.5,
              )
            ]
        )
    );
  }

  // Widget graphArc(List<trackData> _cpuUsageChartData, double height, String title){
  //
  //   return Container(
  //     height: height,
  //     child:
  //     SfCartesianChart(
  //       title: ChartTitle(text: title),
  //       // legend: Legend(isVisible: true),
  //       series: <SplineSeries>[
  //         SplineSeries<trackData, int>(
  //           onRendererCreated: (ChartSeriesController controller) {
  //             _chartSeriesController = controller;
  //           },
  //           name: title,
  //           dataSource: _cpuUsageChartData,
  //           xValueMapper: (trackData yAxis, _) => yAxis.xAxis,
  //           yValueMapper: (trackData yAxis, _) => yAxis.yAxis,
  //           dataLabelSettings: DataLabelSettings(isVisible: true),
  //           color: Colors.orange,
  //           width: 10,
  //           opacity: 0.5,
  //         )
  //       ],
  //       primaryXAxis: NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
  //       // primaryYAxis: NumericAxis(
  //       //     labelFormat: '{value}M',
  //       //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
  //     ),
  //   );
  // }
}

class trackData{
  trackData(this.xAxis, this.yAxis);
  final int? xAxis;
  final int? yAxis;
}




