class AlarmModel {
  late String msg;
  late int code;
  late List<AlarmData> ? data;

  AlarmModel({required this.msg,  required this.code,  this.data});

  AlarmModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = <AlarmData>[];
      json['data'].forEach((v) {
        data!.add(new AlarmData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AlarmData {
  int ? id;
  String ? deviceId;
  String ? deviceName;
  int ? indexId;
  String ? indexName;
  int ? alarmType;
  int ? alarmGrade;
  double ? limitValue;
  double ? alarmValue;
  String ? alarmContent;
  String ? createTime;
  int ? ecologyType;
  String ? ecologyTypeName;
  String ? dataTime;

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
        this.ecologyType,
        this.ecologyTypeName,
        this.dataTime});

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
    ecologyType = json['ecologyType'];
    ecologyTypeName = json['ecologyTypeName'];
    dataTime = json['dataTime'];
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
    data['ecologyType'] = this.ecologyType;
    data['ecologyTypeName'] = this.ecologyTypeName;
    data['dataTime'] = this.dataTime;
    return data;
  }
}
