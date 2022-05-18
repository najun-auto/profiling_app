



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/database2.dart';
import 'data/profiling.dart';
import 'data/util.dart';

class getAllPicturePage extends StatefulWidget{

  final List<String?> capresult;

  getAllPicturePage({Key? key, required this.capresult}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _getAllPicturePageState();
  }

}

class _getAllPicturePageState extends State<getAllPicturePage>{

  List<String?> capResult = [];

  @override
  void initState() {
    // TODO: implement initState
    // getCounterProfilinig();
    capResult = widget.capresult;
    print(capResult);

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
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.arrow_back),
      //   onPressed: () {
      //     Navigator.of(context).pop();
      //   },
      // ),
    );
  }

  Widget getAllPicture(){
    int temp = 0;
    return Container(
      // margin: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
      child: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(capResult.length, (_idx){
          return Container(
            // width: 500,
            margin: EdgeInsets.symmetric(vertical: 22, horizontal: 16),
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Time : ${_idx}"),
                Utils.imageFromBase64String(capResult[_idx]),
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

