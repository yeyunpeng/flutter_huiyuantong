class PollutionDetailsModel {
  late String msg;
  late int code;
  late Data ? data;

  PollutionDetailsModel({required this.msg, required this.code, this.data});

  PollutionDetailsModel.fromJson(Map<String, dynamic> json) {
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
  late String ? outletName;
  late int ? outletId;
  late String ? latitude;
  late List<PollAlarmData> ? alarmData;
  late String ? updateTime;
  late List<PollRealtimeData> ? realtimeData;
  late String ? comName;
  late int ? type;
  late String ? longitude;

  Data(
      {this.outletName,
        this.outletId,
        this.latitude,
        this.alarmData,
        this.updateTime,
        this.realtimeData,
        this.comName,
        this.type,
        this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    outletName = json['outletName'];
    outletId = json['outletId'];
    latitude = json['latitude'];
    if (json['alarmData'] != null) {
      alarmData = <PollAlarmData>[];
      json['alarmData'].forEach((v) {
        alarmData!.add(PollAlarmData.fromJson(v));
      });
    }
    updateTime = json['updateTime'];
    if (json['realtimeData'] != null) {
      realtimeData = <PollRealtimeData>[];
      json['realtimeData'].forEach((v) {
        realtimeData!.add(PollRealtimeData.fromJson(v));
      });
    }
    comName = json['comName'];
    type = json['type'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outletName'] = this.outletName;
    data['outletId'] = this.outletId;
    data['latitude'] = this.latitude;
    if (this.alarmData != null) {
      data['alarmData'] = alarmData!.map((v) => v.toJson()).toList();
    }
    data['updateTime'] = this.updateTime;
    if (this.realtimeData != null) {
      data['realtimeData'] = realtimeData!.map((v) => v.toJson()).toList();
    }
    data['comName'] = this.comName;
    data['type'] = this.type;
    data['longitude'] = this.longitude;
    return data;
  }
}

class PollAlarmData {

  late int ? outfallId;

  late String ? indexName;
  late int ? alarmType;
  late int ? alarmGrade;

  late String ? alarmContent;
  late String ? createTime;

  late int ? alarmCount;


  PollAlarmData(
      {
        this.outfallId,

        this.indexName,
        this.alarmType,
        this.alarmGrade,

        this.alarmContent,
        this.createTime,

        this.alarmCount,
       });

  PollAlarmData.fromJson(Map<String, dynamic> json) {

    outfallId = json['outfallId'];

    indexName = json['indexName'];
    alarmType = json['alarmType'];
    alarmGrade = json['alarmGrade'];

    alarmContent = json['alarmContent'];
    createTime = json['createTime'];

    alarmCount = json['alarmCount'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['outfallId'] = this.outfallId;

    data['indexName'] = this.indexName;
    data['alarmType'] = this.alarmType;
    data['alarmGrade'] = this.alarmGrade;

    data['alarmContent'] = this.alarmContent;
    data['createTime'] = this.createTime;

    data['alarmCount'] = this.alarmCount;

    return data;
  }
}

class PollRealtimeData {
  late String ? unit;
  late String ? data;
  late String ? indexName;

  PollRealtimeData({this.unit, this.data, this.indexName});

  PollRealtimeData.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    data = json['data'];
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
