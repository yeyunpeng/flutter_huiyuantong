class PollutionAlarmHistoryModel {
  late String msg;
  late int code;
  late Data ? data;

  PollutionAlarmHistoryModel({required this.msg, required this.code, this.data});

  PollutionAlarmHistoryModel.fromJson(Map<String, dynamic> json) {
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
  late int ? totalCount;
  late int ? pageSize;
  late int ? totalPage;
  late int ? currPage;
  late List<PollutionAlarm> list;

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
      list =  <PollutionAlarm>[];
      json['list'].forEach((v) {
        list.add( PollutionAlarm.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageSize'] = this.pageSize;
    data['totalPage'] = this.totalPage;
    data['currPage'] = this.currPage;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PollutionAlarm {
  late String ? indexName;
  late int ? alarmType;
  late int ? alarmGrade;

  late String ? alarmContent;
  late String ? createTime;
  late int ? alarmCount;
  late String ? outfallName;
  PollutionAlarm(
      {
        this.indexName,
        this.alarmType,
        this.alarmGrade,

        this.alarmContent,
        this.createTime,
        this.alarmCount,
        this.outfallName
     });

  PollutionAlarm.fromJson(Map<String, dynamic> json) {

    indexName = json['indexName'];
    alarmType = json['alarmType'];
    alarmGrade = json['alarmGrade'];

    alarmContent = json['alarmContent'];
    createTime = json['createTime'];

    alarmCount = json['alarmCount'];
    outfallName = json['outfallName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['indexName'] = this.indexName;
    data['alarmType'] = this.alarmType;
    data['alarmGrade'] = this.alarmGrade;

    data['alarmContent'] = this.alarmContent;
    data['createTime'] = this.createTime;

    data['alarmCount'] = this.alarmCount;
    data['outfallName'] = this.outfallName;
    return data;
  }
}
