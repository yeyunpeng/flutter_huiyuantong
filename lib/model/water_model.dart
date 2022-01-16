class WaterModel {
  late String msg;
  late int code;
  late Data ? data;

  WaterModel({required this.msg, required this.code, required this.data});

  WaterModel.fromJson(  Map<String, dynamic>  json) {
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
  late List<AllData> ? allData;
  late num ? compare;
  late num ? onLineCompare;
  late num ? badFive;
  late num ? allNum;

  Data(
      {this.allData,
        this.compare,
        this.onLineCompare,
        this.badFive,
        this.allNum});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['allData'] != null) {
      allData = <AllData>[];
      json['allData'].forEach((v) {
        allData!.add(AllData.fromJson(v));
      });
    }
    compare = json['compare'];
    onLineCompare = json['onLineCompare'];
    badFive = json['badFive'];
    allNum = json['allNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allData != null) {
      data['allData'] = this.allData!.map((v) => v.toJson()).toList();
    }
    data['compare'] = this.compare;
    data['onLineCompare'] = this.onLineCompare;
    data['badFive'] = this.badFive;
    data['allNum'] = this.allNum;
    return data;
  }
}

class AllData {
  late int ? id;
  late String ? name;
  late int ? type;
  late String ?  riverId;
  late String ?  areaId;
  late String ? longitude;
  late String ? latitude;
  late String ?  status;
  late String ?  remark;
  late String ?  delStatus;
  late int ? onLineState;
  late String ?  busiParkId;
  late String ? rivName;
  late String ?  indexId;
  late String ?  code;
  late int ? pollutantType;
  late String ?  outGauge;
  late num ? cwqiValue;
  late String ?  waterDataList;
  late String ?  areaName;

  AllData(
      {this.id,
        this.name,
        this.type,
        this.riverId,
        this.areaId,
        this.longitude,
        this.latitude,
        this.status,
        this.remark,
        this.delStatus,
        this.onLineState,
        this.busiParkId,
        this.rivName,
        this.indexId,
        this.code,
        this.pollutantType,
        this.outGauge,
        this.cwqiValue,
        this.waterDataList,
        this.areaName});

  AllData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    riverId = json['riverId'];
    areaId = json['areaId'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    status = json['status'];
    remark = json['remark'];
    delStatus = json['delStatus'];
    onLineState = json['onLineState'];
    busiParkId = json['busiParkId'];
    rivName = json['rivName'];
    indexId = json['indexId'];
    code = json['code'];
    pollutantType = json['pollutantType'];
    outGauge = json['outGauge'];
    cwqiValue = json['cwqiValue'];
    waterDataList = json['waterDataList'];
    areaName = json['areaName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['riverId'] = this.riverId;
    data['areaId'] = this.areaId;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['status'] = this.status;
    data['remark'] = this.remark;
    data['delStatus'] = this.delStatus;
    data['onLineState'] = this.onLineState;
    data['busiParkId'] = this.busiParkId;
    data['rivName'] = this.rivName;
    data['indexId'] = this.indexId;
    data['code'] = this.code;
    data['pollutantType'] = this.pollutantType;
    data['outGauge'] = this.outGauge;
    data['cwqiValue'] = this.cwqiValue;
    data['waterDataList'] = this.waterDataList;
    data['areaName'] = this.areaName;
    return data;
  }
}
