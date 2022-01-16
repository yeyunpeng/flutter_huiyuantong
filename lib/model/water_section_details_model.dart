class WaterDetailsModel {
  late String msg;
  late int code;
  late Data ? data;

  WaterDetailsModel({required this.msg, required this.code,  this.data});

  WaterDetailsModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  late String ? latitude;
  late List<WaterAlarmData> ? alarmData;
  late List<WaterRealtimeData> ? realtimeData;
  late String ? updateTime;
  late String ? type;
  late String ? riverName;
  late String ? fraName;
  late String ? longitude;

  Data(
      { this.latitude,
         this.alarmData,
         this.realtimeData,
         this.updateTime,
         this.type,
         this.riverName,
         this.fraName,
         this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'].toString();
    if (json['alarmData'] != null) {
      alarmData = <WaterAlarmData>[];
      json['alarmData'].forEach((v) {
        alarmData!.add(WaterAlarmData.fromJson(v));
      });
    }
    if (json['realtimeData'] != null) {
      realtimeData = <WaterRealtimeData>[];
      json['realtimeData'].forEach((v) {
        realtimeData!.add(WaterRealtimeData.fromJson(v));
      });
    }
    updateTime = json['updateTime'].toString();
    type = json['type'].toString();
    riverName = json['riverName'].toString();
    fraName = json['fraName'].toString();
    longitude = json['longitude'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['alarmData'] = alarmData!.map((v) => v.toJson()).toList();
    data['realtimeData'] = realtimeData!.map((v) => v.toJson()).toList();
    data['updateTime'] = updateTime;
    data['type'] = type;
    data['riverName'] = riverName;
    data['fraName'] = fraName;
    data['longitude'] = longitude;
    return data;
  }
}

class WaterAlarmData {

  late String ? fractureId;
  late String ? fractureName;

  late String ? indexName;
  late String ? alarmType;
  late String ? alarmGrade;

  late String ? alarmContent;
  late String ? createTime;

  late String ? alarmCount;


  WaterAlarmData(
      {
        this.fractureId,
        this.fractureName,

        this.indexName,
        this.alarmType,
        this.alarmGrade,

        this.alarmContent,
        this.createTime,

        this.alarmCount,
        });

  WaterAlarmData.fromJson(Map<String, dynamic> json) {

    fractureId = json['fractureId'].toString();
    fractureName = json['fractureName'].toString();

    indexName = json['indexName'].toString();
    alarmType = json['alarmType'].toString();
    alarmGrade = json['alarmGrade'].toString();

    alarmContent = json['alarmContent'].toString();
    createTime = json['createTime'].toString();

    alarmCount = json['alarmCount'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['fractureId'] = this.fractureId;
    data['fractureName'] = this.fractureName;

    data['indexName'] = this.indexName;
    data['alarmType'] = this.alarmType;
    data['alarmGrade'] = this.alarmGrade;

    data['alarmContent'] = this.alarmContent;
    data['createTime'] = this.createTime;

    data['alarmCount'] = this.alarmCount;

    return data;
  }
}

class WaterRealtimeData {
  late String ? unit;
  late String ? data;
  late String ? indexName;

  WaterRealtimeData({this.unit, this.data, this.indexName});

  WaterRealtimeData.fromJson(Map<String, dynamic> json) {
    unit = json['unit'].toString();
    data = json['data'].toString();
    indexName = json['indexName'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['unit'] = this.unit.toString();
    data['data'] = this.data.toString();
    data['indexName'] = this.indexName.toString();
    return data;
  }
}
