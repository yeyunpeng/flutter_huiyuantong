import 'dart:ffi';

class AirSiteDetailsModel {
  late String msg;
  late int code;
  late Data ? data;

  AirSiteDetailsModel({required this.msg, required this.code, this.data});

  AirSiteDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  late DeviceData ? deviceData;
  late List<AlarmData> ? alarmData;
  late List<RealtimeData> ? realtimeData;

  Data({this.deviceData,  this.alarmData, this.realtimeData});

  Data.fromJson(Map<String, dynamic> json) {
    deviceData = json['deviceData'] != null
        ? new DeviceData.fromJson(json['deviceData'])
        : null;
    if (json['alarmData'] != null) {
      alarmData = <AlarmData>[];
      json['alarmData'].forEach((v) {
        alarmData!.add(new AlarmData.fromJson(v));
      });
    }
    if (json['realtimeData'] != null) {
      realtimeData = <RealtimeData>[];
      json['realtimeData'].forEach((v) {
        realtimeData!.add(RealtimeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deviceData != null) {
      data['deviceData'] = deviceData!.toJson();
    }
    if (this.alarmData != null) {
      data['alarmData'] = alarmData!.map((v) => v.toJson()).toList();
    }
    if (this.realtimeData != null) {
      data['realtimeData'] = realtimeData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeviceData {

 late String ? name;

  late int ? devType;
  late String ? devLongitude;
  late String ? devLatitude;
  late int ? status;
  late int ? useStatus;
  Null remark;
  Null createUser;
  Null createTime;
  Null updateUser;
  late String ? updateTime;
  late int ? delStatus;
  Null busiParkId;
  late String ? typeName;
  late String ? regionName;
  Null pollutantData;
  Null countryDataDayList;
  Null griddingDataDayList;
  Null countryDataHourList;
  Null compareResult;
  Null griddingDataHourList;

  DeviceData(
      {
        this.name,

        this.devType,
        this.devLongitude,
        this.devLatitude,
        this.status,
        this.useStatus,
        this.remark,
        this.createUser,
        this.createTime,
        this.updateUser,
        this.updateTime,
        this.delStatus,
        this.busiParkId,
        this.typeName,
        this.regionName,
        this.pollutantData,
        this.countryDataDayList,
        this.griddingDataDayList,
        this.countryDataHourList,
        this.compareResult,
        this.griddingDataHourList});

  DeviceData.fromJson(Map<String, dynamic> json) {

    name = json['name'];

    devType = json['devType'];
    devLongitude = json['devLongitude'];
    devLatitude = json['devLatitude'];
    status = json['status'];
    useStatus = json['useStatus'];
    remark = json['remark'];
    createUser = json['createUser'];
    createTime = json['createTime'];
    updateUser = json['updateUser'];
    updateTime = json['updateTime'];
    delStatus = json['delStatus'];
    busiParkId = json['busiParkId'];
    typeName = json['typeName'];
    regionName = json['regionName'];
    pollutantData = json['pollutantData'];
    countryDataDayList = json['countryDataDayList'];
    griddingDataDayList = json['griddingDataDayList'];
    countryDataHourList = json['countryDataHourList'];
    compareResult = json['compareResult'];
    griddingDataHourList = json['griddingDataHourList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;

    data['devType'] = this.devType;
    data['devLongitude'] = this.devLongitude;
    data['devLatitude'] = this.devLatitude;
    data['status'] = this.status;
    data['useStatus'] = this.useStatus;
    data['remark'] = this.remark;
    data['createUser'] = this.createUser;
    data['createTime'] = this.createTime;
    data['updateUser'] = this.updateUser;
    data['updateTime'] = this.updateTime;
    data['delStatus'] = this.delStatus;
    data['busiParkId'] = this.busiParkId;
    data['typeName'] = this.typeName;
    data['regionName'] = this.regionName;
    data['pollutantData'] = this.pollutantData;
    data['countryDataDayList'] = this.countryDataDayList;
    data['griddingDataDayList'] = this.griddingDataDayList;
    data['countryDataHourList'] = this.countryDataHourList;
    data['compareResult'] = this.compareResult;
    data['griddingDataHourList'] = this.griddingDataHourList;
    return data;
  }
}

class AlarmData {
  Null id;
  late String ? deviceId;
  late String ? deviceName;
  Null indexId;
  late String ? indexName;
  int ? alarmType;
  int ? alarmGrade;
   Null limitValue;
   Null alarmValue;
  late String ? alarmContent;
  late String ? createTime;
  Null busiParkId;
  Null dataTime;
  late String ? alarmMultiple;
  Null data;

  AlarmData(
      {this.id,
        this.deviceId,
        this.deviceName,
        this.indexId,
        this.indexName,
        this.alarmType,
        this.alarmGrade,
        this.limitValue,
        this.alarmValue,
        this.alarmContent,
        this.createTime,
        this.busiParkId,
        this.dataTime,
        this.alarmMultiple,
        this.data});

  AlarmData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    indexId = json['indexId'];
    indexName = json['indexName'];
    alarmType = json['alarmType'];
    alarmGrade = json['alarmGrade'];
    limitValue = json['limitValue'];
    alarmValue = json['alarmValue'];
    alarmContent = json['alarmContent'];
    createTime = json['createTime'];
    busiParkId = json['busiParkId'];
    dataTime = json['dataTime'];
    alarmMultiple = json['alarmMultiple'].toString();
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deviceId'] = this.deviceId;
    data['deviceName'] = this.deviceName;
    data['indexId'] = this.indexId;
    data['indexName'] = this.indexName;
    data['alarmType'] = this.alarmType;
    data['alarmGrade'] = this.alarmGrade;
    data['limitValue'] = this.limitValue;
    data['alarmValue'] = this.alarmValue;
    data['alarmContent'] = this.alarmContent;
    data['createTime'] = this.createTime;
    data['busiParkId'] = this.busiParkId;
    data['dataTime'] = this.dataTime;
    data['alarmMultiple'] = this.alarmMultiple;
    data['data'] = this.data;
    return data;
  }
}

class RealtimeData {
  late String ? unit;
  late String ? data;
  late String ? indexName;

  RealtimeData({this.unit, this.data, this.indexName});

  RealtimeData.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    data = json['data'].toString();
    indexName = json['indexName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit'] = this.unit;
    data['data'] = this.data;
    data['indexName'] = this.indexName;
    return data;
  }
}
