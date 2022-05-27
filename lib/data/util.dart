
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Utils {

  static int getFormatTime(DateTime date){
    return int.parse("${date.year}${makeTwoDigit(date.month)}${makeTwoDigit(date.day)}${makeTwoDigit(date.hour)}${makeTwoDigit(date.minute)}");
  }

  static DateTime numTwoDateTime(int date){
    String _d = date.toString();
    int year = int.parse(_d.substring(0,4));
    int month = int.parse(_d.substring(4,6));
    int day = int.parse(_d.substring(6,8));

    return DateTime(year, month, day);
  }

  static String makeTwoDigit(int num){
    return num.toString().padLeft(2, "0");
  }

  static Image imageFromBase64String(Uint8List? base64String) {
    // return Container(
    //   height: 40,
    //   width: 200,
    //   Image.memory(base64Decode(base64String!),
    //     fit: BoxFit,)
    // );

    // String temp = (num.tryParse(base64String)).toString();

    // String temp = "";
    // if(base64String != null) {
    //   temp = base64String;
    // }
    // print(base64)
    return Image.memory(
      // base64Decode(base64String), //base64String),
      base64String!,
      fit: BoxFit.fill,
      width: 150,
      height: 300,
      alignment: Alignment.center,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(List<int> data) {
    return base64Encode(data);
  }

}