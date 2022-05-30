

// import 'package:flutter/cupertino.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled2/data/database2.dart';
import 'package:untitled2/getpicture.dart';

import 'data/profiling.dart';

class GetAllDataPage extends StatefulWidget{

  final int testCounter;
  final bool cpuChecked;
  final bool gpuChecked;
  final bool cpu0freqChecked;
  final bool cpu4freqChecked;
  final bool cpu7freqChecked;
  final bool gpufreqChecked;
  final bool fpsChecked;
  final bool networkChecked;
  final bool temp0Checked;
  final bool temp1Checked;
  final bool temp2Checked;
  final bool temp3Checked;
  final bool temp8Checked;

  final bool ddrclkChecked;
  final bool currentNowChecked;

  final bool memBufferChecked;
  final bool memCachedChecked;
  final bool memSwapCachedChecked;



  GetAllDataPage({Key? key, required this.testCounter, required this.cpuChecked, required this.gpuChecked, required this.cpu0freqChecked, required this.cpu4freqChecked, required this.cpu7freqChecked, required this.gpufreqChecked, required this.fpsChecked, required this.networkChecked, required this.temp0Checked, required this.temp1Checked, required this.temp2Checked, required this.temp3Checked, required this.temp8Checked, required this.ddrclkChecked, required this.currentNowChecked, required this.memBufferChecked, required this.memCachedChecked, required this.memSwapCachedChecked}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GetAllDataPage();
  }
}

class _GetAllDataPage extends State<GetAllDataPage>{

  final dbHelper = DatabaseHelper();
  List<Profiling> profilings = [];
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;
  int testCounter = 0;
  bool _cpuChecked = true;
  bool _gpuChecked = true;
  bool _cpu0freqChecked = true;
  bool _cpu4freqChecked = true;
  bool _cpu7freqChecked = true;
  bool _gpufreqChecked = true;
  bool _fpsChecked = true;
  bool _networkChecked = true;
  bool _temp0Checked = true;
  bool _temp1Checked = true;
  bool _temp2Checked = true;
  bool _temp3Checked = true;
  bool _temp8Checked = true;

  bool _ddrclkChecked = true;
  bool _currentNowChecked = true;

  bool _memBufferChecked = true;
  bool _memCachedChecked = true;
  bool _memSwapCachedChecked = true;


  final countingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    getAllProfilingData();
    testCounter = widget.testCounter;
    testCounter++;

    _cpuChecked = widget.cpuChecked;
    _gpuChecked = widget.gpuChecked;
    _cpu0freqChecked = widget.cpu0freqChecked;
    _cpu4freqChecked = widget.cpu4freqChecked;
    _cpu7freqChecked = widget.cpu7freqChecked;
    _gpufreqChecked = widget.gpufreqChecked;
    _fpsChecked = widget.fpsChecked;
    _networkChecked = widget.networkChecked;
    _temp0Checked = widget.temp0Checked;
    _temp1Checked = widget.temp1Checked;
    _temp2Checked = widget.temp2Checked;
    _temp3Checked = widget.temp3Checked;
    _temp8Checked = widget.temp8Checked;

    _ddrclkChecked = widget.ddrclkChecked;
    _currentNowChecked = widget.currentNowChecked;

    _memBufferChecked = widget.memBufferChecked;
    _memCachedChecked = widget.memCachedChecked;
    _memSwapCachedChecked = widget.memSwapCachedChecked;

    countingController.text = "0";

    _tooltipBehavior =  TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, zoomMode: ZoomMode.x, enablePanning: true);
    super.initState();
  }

  void getAllProfilingData() async{
    profilings = await dbHelper.getAllProfilinig();
    setState(() {

    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: Container(child: getOldProfiling()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
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
    List<trackData> _currentNow_temp = [];

    List<trackData> _ddrclk_temp = [];

    List<trackData> _memBuffer_temp = [];
    List<trackData> _memCached_temp = [];
    List<trackData> _memSwapCached_temp = [];
    int? time = 0;
    String? textf;
    // List<Uint8List> capresultTemp = [];
    List<Uint8List?> capresultTemp = [];


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
        if(_currentNowChecked == true){_currentNow_temp.add(trackData(profiling.time, profiling.currentNow));}

        if(_memBufferChecked == true){_memBuffer_temp.add(trackData(profiling.time, profiling.memBuffer));}
        if(_memCachedChecked == true){_memCached_temp.add(trackData(profiling.time, profiling.memCached));}
        if(_memSwapCachedChecked == true){_memSwapCached_temp.add(trackData(profiling.time, profiling.memSwapCached));}

        time = profiling.ttime;
        textf = profiling.textf;
        capresultTemp.add(profiling.capimg);
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
          oldgraph(_temperature0_temp, _temp0Checked, "Temp"),
          oldgraph(_temperature1_temp, _temp1Checked, "Temp 1"),
          oldgraph(_temperature2_temp, _temp2Checked, "Temp 2"),
          oldgraph(_temperature3_temp, _temp3Checked, "Temp 3"),
          oldgraph(_temperature8_temp, _temp8Checked, "Temp 8"),
          oldgraph(_ddrclk_temp, _ddrclkChecked, "DDR CLK"),
          oldgraph(_currentNow_temp, _currentNowChecked, "Current Now"),

          oldgraph(_memBuffer_temp, _memBufferChecked, "MEM Buffer"),
          oldgraph(_memCached_temp, _memCachedChecked, "MEM Cached"),
          oldgraph(_memSwapCached_temp, _memSwapCachedChecked, "MEM SwapCached"),
          Container(
            // margin: EdgeInsets.all(8),
            child: TextField(
              controller: countingController,
            ),
          ),
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
              await Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => getAllPicturePage(capresult: capresultTemp, counting: int.parse(countingController.text),)) );
              setState(() {});
            },
          ),

      // time = profiling.ttime;
          // Text("${_cpu0freqChecked}"),


          // oldgraph(_cpu0Freq_temp),
          // oldgraph(_cpu4Freq_temp),
          // oldgraph(_cpu7Freq_temp),
          // oldgraph(_temperature0_temp),
        ],
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

}


class trackData{
  trackData(this.xAxis, this.yAxis);
  final int? xAxis;
  final int? yAxis;
}