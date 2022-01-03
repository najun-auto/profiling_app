import 'dart:async';

import 'package:flutter/material.dart';

import 'package:cli_script/cli_script.dart';

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


  void _start(){
    int temp = 0;
    const oneSec = Duration(seconds:1);
    Timer.periodic(
      oneSec,
      (Timer t) => setState(() {
        wrapMain(() async {
          var pipeline = Script("echo ${temp}");
          temp++;
          kkk = await pipeline.stdout.text;
          print(kkk);
          // print("${await pipeline.stdout.text} instances of waitFor");
        });
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _start();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body: Container(
        child: Text(kkk),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
