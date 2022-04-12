

class Profiling {
  final int? id;
  final int? count;
  final int? time;
  final int? CPUusage;
  final int? GPUusage;
  final int? CPU0Freq;
  final int? CPU4Freq;
  final int? CPU7Freq;
  final int? GPUFreq;
  final int? FPS;
  final int? Network;
  final int? Temp0;


  Profiling({
    this.id,
    this.count,
    this.time,
    this.CPUusage,
    this.GPUusage,
    this.CPU0Freq,
    this.CPU4Freq,
    this.CPU7Freq,
    this.GPUFreq,
    this.FPS,
    this.Network,
    this.Temp0,
  });

  Map<String, dynamic> toMap() => {
    'count': this.count,
    'time': this.time,
    'CPUUsage': this.CPUusage,
    'GPUUsage': this.GPUusage,
    'CPU0Freq': this.CPU0Freq,
    'CPU4Freq': this.CPU4Freq,
    'CPU7Freq': this.CPU7Freq,
    'GPUFreq': this.GPUFreq,
    'FPS': this.FPS,
    'Network': this.Network,
    'Temp0': this.Temp0,
  };
}