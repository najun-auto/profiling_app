/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Profiling type in your schema. */
@immutable
class Profiling extends Model {
  static const classType = const _ProfilingModelType();
  final String id;
  final int? _count;
  final int? _time;
  final int? _CPUusage;
  final int? _GPUusage;
  final int? _CPU0Freq;
  final int? _CPU4Freq;
  final int? _CPU7Freq;
  final int? _GPUFreq;
  final int? _FPS_Value;
  final int? _Network_Value;
  final int? _Temp0;
  final int? _Temp1;
  final int? _Temp2;
  final int? _Temp3;
  final int? _Temp8;
  final int? _ttime;
  final String? _textf;
  final int? _ddrclk;
  final String? _capimg;
  final int? _currentNow;
  final int? _memBuffer;
  final int? _memCached;
  final int? _memSwapCached;
  final String? _deviceName;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  int get count {
    try {
      return _count!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get time {
    return _time;
  }
  
  int? get CPUusage {
    return _CPUusage;
  }
  
  int? get GPUusage {
    return _GPUusage;
  }
  
  int? get CPU0Freq {
    return _CPU0Freq;
  }
  
  int? get CPU4Freq {
    return _CPU4Freq;
  }
  
  int? get CPU7Freq {
    return _CPU7Freq;
  }
  
  int? get GPUFreq {
    return _GPUFreq;
  }
  
  int? get FPS_Value {
    return _FPS_Value;
  }
  
  int? get Network_Value {
    return _Network_Value;
  }
  
  int? get Temp0 {
    return _Temp0;
  }
  
  int? get Temp1 {
    return _Temp1;
  }
  
  int? get Temp2 {
    return _Temp2;
  }
  
  int? get Temp3 {
    return _Temp3;
  }
  
  int? get Temp8 {
    return _Temp8;
  }
  
  int? get ttime {
    return _ttime;
  }
  
  String? get textf {
    return _textf;
  }
  
  int? get ddrclk {
    return _ddrclk;
  }
  
  String? get capimg {
    return _capimg;
  }
  
  int? get currentNow {
    return _currentNow;
  }
  
  int? get memBuffer {
    return _memBuffer;
  }
  
  int? get memCached {
    return _memCached;
  }
  
  int? get memSwapCached {
    return _memSwapCached;
  }
  
  String? get deviceName {
    return _deviceName;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Profiling._internal({required this.id, required count, time, CPUusage, GPUusage, CPU0Freq, CPU4Freq, CPU7Freq, GPUFreq, FPS_Value, Network_Value, Temp0, Temp1, Temp2, Temp3, Temp8, ttime, textf, ddrclk, capimg, currentNow, memBuffer, memCached, memSwapCached, deviceName, createdAt, updatedAt}): _count = count, _time = time, _CPUusage = CPUusage, _GPUusage = GPUusage, _CPU0Freq = CPU0Freq, _CPU4Freq = CPU4Freq, _CPU7Freq = CPU7Freq, _GPUFreq = GPUFreq, _FPS_Value = FPS_Value, _Network_Value = Network_Value, _Temp0 = Temp0, _Temp1 = Temp1, _Temp2 = Temp2, _Temp3 = Temp3, _Temp8 = Temp8, _ttime = ttime, _textf = textf, _ddrclk = ddrclk, _capimg = capimg, _currentNow = currentNow, _memBuffer = memBuffer, _memCached = memCached, _memSwapCached = memSwapCached, _deviceName = deviceName, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Profiling({String? id, required int count, int? time, int? CPUusage, int? GPUusage, int? CPU0Freq, int? CPU4Freq, int? CPU7Freq, int? GPUFreq, int? FPS_Value, int? Network_Value, int? Temp0, int? Temp1, int? Temp2, int? Temp3, int? Temp8, int? ttime, String? textf, int? ddrclk, String? capimg, int? currentNow, int? memBuffer, int? memCached, int? memSwapCached, String? deviceName}) {
    return Profiling._internal(
      id: id == null ? UUID.getUUID() : id,
      count: count,
      time: time,
      CPUusage: CPUusage,
      GPUusage: GPUusage,
      CPU0Freq: CPU0Freq,
      CPU4Freq: CPU4Freq,
      CPU7Freq: CPU7Freq,
      GPUFreq: GPUFreq,
      FPS_Value: FPS_Value,
      Network_Value: Network_Value,
      Temp0: Temp0,
      Temp1: Temp1,
      Temp2: Temp2,
      Temp3: Temp3,
      Temp8: Temp8,
      ttime: ttime,
      textf: textf,
      ddrclk: ddrclk,
      capimg: capimg,
      currentNow: currentNow,
      memBuffer: memBuffer,
      memCached: memCached,
      memSwapCached: memSwapCached,
      deviceName: deviceName);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profiling &&
      id == other.id &&
      _count == other._count &&
      _time == other._time &&
      _CPUusage == other._CPUusage &&
      _GPUusage == other._GPUusage &&
      _CPU0Freq == other._CPU0Freq &&
      _CPU4Freq == other._CPU4Freq &&
      _CPU7Freq == other._CPU7Freq &&
      _GPUFreq == other._GPUFreq &&
      _FPS_Value == other._FPS_Value &&
      _Network_Value == other._Network_Value &&
      _Temp0 == other._Temp0 &&
      _Temp1 == other._Temp1 &&
      _Temp2 == other._Temp2 &&
      _Temp3 == other._Temp3 &&
      _Temp8 == other._Temp8 &&
      _ttime == other._ttime &&
      _textf == other._textf &&
      _ddrclk == other._ddrclk &&
      _capimg == other._capimg &&
      _currentNow == other._currentNow &&
      _memBuffer == other._memBuffer &&
      _memCached == other._memCached &&
      _memSwapCached == other._memSwapCached &&
      _deviceName == other._deviceName;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Profiling {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("count=" + (_count != null ? _count!.toString() : "null") + ", ");
    buffer.write("time=" + (_time != null ? _time!.toString() : "null") + ", ");
    buffer.write("CPUusage=" + (_CPUusage != null ? _CPUusage!.toString() : "null") + ", ");
    buffer.write("GPUusage=" + (_GPUusage != null ? _GPUusage!.toString() : "null") + ", ");
    buffer.write("CPU0Freq=" + (_CPU0Freq != null ? _CPU0Freq!.toString() : "null") + ", ");
    buffer.write("CPU4Freq=" + (_CPU4Freq != null ? _CPU4Freq!.toString() : "null") + ", ");
    buffer.write("CPU7Freq=" + (_CPU7Freq != null ? _CPU7Freq!.toString() : "null") + ", ");
    buffer.write("GPUFreq=" + (_GPUFreq != null ? _GPUFreq!.toString() : "null") + ", ");
    buffer.write("FPS_Value=" + (_FPS_Value != null ? _FPS_Value!.toString() : "null") + ", ");
    buffer.write("Network_Value=" + (_Network_Value != null ? _Network_Value!.toString() : "null") + ", ");
    buffer.write("Temp0=" + (_Temp0 != null ? _Temp0!.toString() : "null") + ", ");
    buffer.write("Temp1=" + (_Temp1 != null ? _Temp1!.toString() : "null") + ", ");
    buffer.write("Temp2=" + (_Temp2 != null ? _Temp2!.toString() : "null") + ", ");
    buffer.write("Temp3=" + (_Temp3 != null ? _Temp3!.toString() : "null") + ", ");
    buffer.write("Temp8=" + (_Temp8 != null ? _Temp8!.toString() : "null") + ", ");
    buffer.write("ttime=" + (_ttime != null ? _ttime!.toString() : "null") + ", ");
    buffer.write("textf=" + "$_textf" + ", ");
    buffer.write("ddrclk=" + (_ddrclk != null ? _ddrclk!.toString() : "null") + ", ");
    buffer.write("capimg=" + "$_capimg" + ", ");
    buffer.write("currentNow=" + (_currentNow != null ? _currentNow!.toString() : "null") + ", ");
    buffer.write("memBuffer=" + (_memBuffer != null ? _memBuffer!.toString() : "null") + ", ");
    buffer.write("memCached=" + (_memCached != null ? _memCached!.toString() : "null") + ", ");
    buffer.write("memSwapCached=" + (_memSwapCached != null ? _memSwapCached!.toString() : "null") + ", ");
    buffer.write("deviceName=" + "$_deviceName" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Profiling copyWith({String? id, int? count, int? time, int? CPUusage, int? GPUusage, int? CPU0Freq, int? CPU4Freq, int? CPU7Freq, int? GPUFreq, int? FPS_Value, int? Network_Value, int? Temp0, int? Temp1, int? Temp2, int? Temp3, int? Temp8, int? ttime, String? textf, int? ddrclk, String? capimg, int? currentNow, int? memBuffer, int? memCached, int? memSwapCached, String? deviceName}) {
    return Profiling._internal(
      id: id ?? this.id,
      count: count ?? this.count,
      time: time ?? this.time,
      CPUusage: CPUusage ?? this.CPUusage,
      GPUusage: GPUusage ?? this.GPUusage,
      CPU0Freq: CPU0Freq ?? this.CPU0Freq,
      CPU4Freq: CPU4Freq ?? this.CPU4Freq,
      CPU7Freq: CPU7Freq ?? this.CPU7Freq,
      GPUFreq: GPUFreq ?? this.GPUFreq,
      FPS_Value: FPS_Value ?? this.FPS_Value,
      Network_Value: Network_Value ?? this.Network_Value,
      Temp0: Temp0 ?? this.Temp0,
      Temp1: Temp1 ?? this.Temp1,
      Temp2: Temp2 ?? this.Temp2,
      Temp3: Temp3 ?? this.Temp3,
      Temp8: Temp8 ?? this.Temp8,
      ttime: ttime ?? this.ttime,
      textf: textf ?? this.textf,
      ddrclk: ddrclk ?? this.ddrclk,
      capimg: capimg ?? this.capimg,
      currentNow: currentNow ?? this.currentNow,
      memBuffer: memBuffer ?? this.memBuffer,
      memCached: memCached ?? this.memCached,
      memSwapCached: memSwapCached ?? this.memSwapCached,
      deviceName: deviceName ?? this.deviceName);
  }
  
  Profiling.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _count = (json['count'] as num?)?.toInt(),
      _time = (json['time'] as num?)?.toInt(),
      _CPUusage = (json['CPUusage'] as num?)?.toInt(),
      _GPUusage = (json['GPUusage'] as num?)?.toInt(),
      _CPU0Freq = (json['CPU0Freq'] as num?)?.toInt(),
      _CPU4Freq = (json['CPU4Freq'] as num?)?.toInt(),
      _CPU7Freq = (json['CPU7Freq'] as num?)?.toInt(),
      _GPUFreq = (json['GPUFreq'] as num?)?.toInt(),
      _FPS_Value = (json['FPS_Value'] as num?)?.toInt(),
      _Network_Value = (json['Network_Value'] as num?)?.toInt(),
      _Temp0 = (json['Temp0'] as num?)?.toInt(),
      _Temp1 = (json['Temp1'] as num?)?.toInt(),
      _Temp2 = (json['Temp2'] as num?)?.toInt(),
      _Temp3 = (json['Temp3'] as num?)?.toInt(),
      _Temp8 = (json['Temp8'] as num?)?.toInt(),
      _ttime = (json['ttime'] as num?)?.toInt(),
      _textf = json['textf'],
      _ddrclk = (json['ddrclk'] as num?)?.toInt(),
      _capimg = json['capimg'],
      _currentNow = (json['currentNow'] as num?)?.toInt(),
      _memBuffer = (json['memBuffer'] as num?)?.toInt(),
      _memCached = (json['memCached'] as num?)?.toInt(),
      _memSwapCached = (json['memSwapCached'] as num?)?.toInt(),
      _deviceName = json['deviceName'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'count': _count, 'time': _time, 'CPUusage': _CPUusage, 'GPUusage': _GPUusage, 'CPU0Freq': _CPU0Freq, 'CPU4Freq': _CPU4Freq, 'CPU7Freq': _CPU7Freq, 'GPUFreq': _GPUFreq, 'FPS_Value': _FPS_Value, 'Network_Value': _Network_Value, 'Temp0': _Temp0, 'Temp1': _Temp1, 'Temp2': _Temp2, 'Temp3': _Temp3, 'Temp8': _Temp8, 'ttime': _ttime, 'textf': _textf, 'ddrclk': _ddrclk, 'capimg': _capimg, 'currentNow': _currentNow, 'memBuffer': _memBuffer, 'memCached': _memCached, 'memSwapCached': _memSwapCached, 'deviceName': _deviceName, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "profiling.id");
  static final QueryField COUNT = QueryField(fieldName: "count");
  static final QueryField TIME = QueryField(fieldName: "time");
  static final QueryField CPUUSAGE = QueryField(fieldName: "CPUusage");
  static final QueryField GPUUSAGE = QueryField(fieldName: "GPUusage");
  static final QueryField CPU0FREQ = QueryField(fieldName: "CPU0Freq");
  static final QueryField CPU4FREQ = QueryField(fieldName: "CPU4Freq");
  static final QueryField CPU7FREQ = QueryField(fieldName: "CPU7Freq");
  static final QueryField GPUFREQ = QueryField(fieldName: "GPUFreq");
  static final QueryField FPS_VALUE = QueryField(fieldName: "FPS_Value");
  static final QueryField NETWORK_VALUE = QueryField(fieldName: "Network_Value");
  static final QueryField TEMP0 = QueryField(fieldName: "Temp0");
  static final QueryField TEMP1 = QueryField(fieldName: "Temp1");
  static final QueryField TEMP2 = QueryField(fieldName: "Temp2");
  static final QueryField TEMP3 = QueryField(fieldName: "Temp3");
  static final QueryField TEMP8 = QueryField(fieldName: "Temp8");
  static final QueryField TTIME = QueryField(fieldName: "ttime");
  static final QueryField TEXTF = QueryField(fieldName: "textf");
  static final QueryField DDRCLK = QueryField(fieldName: "ddrclk");
  static final QueryField CAPIMG = QueryField(fieldName: "capimg");
  static final QueryField CURRENTNOW = QueryField(fieldName: "currentNow");
  static final QueryField MEMBUFFER = QueryField(fieldName: "memBuffer");
  static final QueryField MEMCACHED = QueryField(fieldName: "memCached");
  static final QueryField MEMSWAPCACHED = QueryField(fieldName: "memSwapCached");
  static final QueryField DEVICENAME = QueryField(fieldName: "deviceName");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Profiling";
    modelSchemaDefinition.pluralName = "Profilings";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.COUNT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.TIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.CPUUSAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.GPUUSAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.CPU0FREQ,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.CPU4FREQ,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.CPU7FREQ,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.GPUFREQ,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.FPS_VALUE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.NETWORK_VALUE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.TEMP0,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.TEMP1,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.TEMP2,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.TEMP3,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.TEMP8,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.TTIME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.TEXTF,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.DDRCLK,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.CAPIMG,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.CURRENTNOW,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.MEMBUFFER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.MEMCACHED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.MEMSWAPCACHED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profiling.DEVICENAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _ProfilingModelType extends ModelType<Profiling> {
  const _ProfilingModelType();
  
  @override
  Profiling fromJson(Map<String, dynamic> jsonData) {
    return Profiling.fromJson(jsonData);
  }
}