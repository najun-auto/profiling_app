



import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/database2.dart';
import 'data/profiling.dart';
import 'data/util.dart';

class getAllPicturePage extends StatefulWidget{

  final List<Uint8List> capresult;
  final int counting;

  getAllPicturePage({Key? key, required this.capresult, required this.counting}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _getAllPicturePageState();
  }

}

class _getAllPicturePageState extends State<getAllPicturePage>{

  List<Uint8List> capResult = [];
  int counting = 0;
  // final countingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // getCounterProfilinig();
    capResult = widget.capresult;
    counting = widget.counting;
    // print(capResult);

    super.initState();
  }

  // void getCounterProfilinig() async{
  //   profilings = await dbHelper.getCounterProfilinig(0);
  //   print(profilings);
  //   setState(() {
  //
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: getAllPicture()),
      floatingActionButton: FloatingActionButton(
        // heroTag: Text("${capResult.length?}"),
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget getAllPicture(){
    int temp = 0;

    int imgCounterStart = capResult.length < counting ? capResult.length : counting;
    int imgCounterLast = capResult.length-imgCounterStart > 50 ? 50 : capResult.length-imgCounterStart;
    // Uint8List temp2 = Uint8List(0);
    // print("capresult length : ${capResult.length}");
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(imgCounterLast, (_idx){
          return Container(
            // width: 500,
            margin: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Time : ${_idx+imgCounterStart}"),
                // Container(
                //   // margin: EdgeInsets.all(8),
                //   child: TextField(
                //     controller: countingController,
                //   ),
                // ),
                Utils.imageFromBase64String(capResult[_idx+imgCounterStart]),
              ],

            ),

          );
            // Utils.imageFromBase64String(capResult[_idx]);
          // return Container(
          //   height: 70,
          //   width: 700,
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   child: Text("${_idx}"),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.blue),
          //     // borderRadius: BorderRadius.circular(50)
          //   ),
          // );
        }),
      ),
    );

  }

}

