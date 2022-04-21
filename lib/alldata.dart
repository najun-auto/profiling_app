

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled2/data/database2.dart';

import 'data/profiling.dart';

class GetAllDataPage extends StatefulWidget{

  final int testCounter;

  const GetAllDataPage({Key? key, required this.testCounter}) : super(key: key);

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

  @override
  void initState() {
    // TODO: implement initState
    getAllProfilingData();
    testCounter = widget.testCounter;

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


    for(var profiling in profilings){
      if(profiling.count == testCounter){
        _cpuUsage_temp.add(trackData(profiling.time, profiling.CPUusage));
        _gpuUsage_temp.add(trackData(profiling.time, profiling.GPUusage));
        // _cpu0Freq_temp.add(trackData(profiling.time, profiling.CPU0Freq));
        // _cpu4Freq_temp.add(trackData(profiling.time, profiling.CPU4Freq));
        // _cpu7Freq_temp.add(trackData(profiling.time, profiling.CPU7Freq));
        _temperature0_temp.add(trackData(profiling.time, profiling.Temp0));
      }

    }

    return profilings.isEmpty ? Container() : Container(
      child: ListView(
        children: [
          oldgraph(_cpuUsage_temp),
          oldgraph(_gpuUsage_temp),
          // oldgraph(_cpu0Freq_temp),
          // oldgraph(_cpu4Freq_temp),
          // oldgraph(_cpu7Freq_temp),
          oldgraph(_temperature0_temp),
          Text("${testCounter}")

        ],
      ),
    );
  }

  Widget oldgraph(List<trackData> chartData){
    // _tooltipBehavior =  TooltipBehavior(enable: true);

    return Container(
        height: 200,
        child: SfCartesianChart(
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