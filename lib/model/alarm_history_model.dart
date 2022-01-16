class AlarmHistoryModel {
  late String msg;
  late int code;
  late Data ? data;

  AlarmHistoryModel({required this.msg, required this.code, this.data});

  AlarmHistoryModel.fromJson(Map<String, dynamic> json) {
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
  late int ? totalCount;
  late int ? pageSize;
  late int ? totalPage;
  late int ? currPage;
  late List<Alarm>  list;

  Data(
      {this.totalCount,
        this.pageSize,
        this.totalPage,
        this.currPage,
        required this.list});

  Data.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    currPage = json['currPage'];
    if (json['list'] != null) {
      list = <Alarm>[];
      json['list'].forEach((v) {
        list.add(Alarm.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageSize'] = this.pageSize;
    data['totalPage'] = this.totalPage;
    data['currPage'] = this.currPage;
    data['list'] = list!.map((v) => v.toJson()).toList();
    return data;
  }
}

class Alarm {
  Null id;
  Null deviceId;
  late String ? deviceName;
  Null indexId;
  late String ? indexName;
  late int ? alarmType;
  late int ? alarmGrade;
  Null limitValue;
  Null alarmValue;
  late String ? alarmContent;
  late String ? createTime;
  Null busiParkId;
  Null dataTime;
  late String ? alarmMultiple;
  Null data;

  Alarm(
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

  Alarm.fromJson(Map<String, dynamic> json) {
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
