//
//
// import 'dart:typed_data';
//
// class Profiling {
//   final int? id;
//   final int? count;
//   final int? time;
//   final int? CPUusage;
//   final int? GPUusage;
//   final int? CPU0Freq;
//   final int? CPU4Freq;
//   final int? CPU7Freq;
//   final int? GPUFreq;
//   final int? FPS;
//   final int? Network;
//   final int? Temp0;
//   final int? Temp1;
//   final int? Temp2;
//   final int? Temp3;
//   final int? Temp8;
//   final int? ttime;
//   final String? textf;
//   final int? ddrclk;
//   // final Uint8List? capimg;
//   final String? capimg;
//   final int? currentNow;
//   final int? memBuffer;
//   final int? memCached;
//   final int? memSwapCached;
//   final String? deviceName;
//
//
//
//   Profiling({
//     this.id,
//     this.count,
//     this.time,
//     this.CPUusage,
//     this.GPUusage,
//     this.CPU0Freq,
//     this.CPU4Freq,
//     this.CPU7Freq,
//     this.GPUFreq,
//     this.FPS,
//     this.Network,
//     this.Temp0,
//     this.Temp1,
//     this.Temp2,
//     this.Temp3,
//     this.Temp8,
//     this.ttime,
//     this.textf,
//     this.ddrclk,
//     required this.capimg,
//     this.currentNow,
//     this.memBuffer,
//     this.memCached,
//     this.memSwapCached,
//     this.deviceName,
//   });
//
//   Map<String, dynamic> toMap() => {
//     'count': this.count,
//     'time': this.time,
//     'CPUUsage': this.CPUusage,
//     'GPUUsage': this.GPUusage,
//     'CPU0Freq': this.CPU0Freq,
//     'CPU4Freq': this.CPU4Freq,
//     'CPU7Freq': this.CPU7Freq,
//     'GPUFreq': this.GPUFreq,
//     'FPS': this.FPS,
//     'Network': this.Network,
//     'Temp0': this.Temp0,
//     'Temp1': this.Temp1,
//     'Temp2': this.Temp2,
//     'Temp3': this.Temp3,
//     'Temp8': this.Temp8,
//     'ttime': this.ttime,
//     'textf': this.textf,
//     'ddrclk': this.ddrclk,
//     'capimg': this.capimg,
//     'currentNow': this.currentNow,
//     'memBuffer': this.memBuffer,
//     'memCached': this.memCached,
//     'memSwapCached': this.memSwapCached,
//     'deviceName': this.deviceName,
//   };
// }