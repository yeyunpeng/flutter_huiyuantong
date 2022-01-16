class PollutionParaHistoryModel {
  late String msg;
  late int code;
  late PPHData ? data;

  PollutionParaHistoryModel({required this.msg, required this.code, this.data});

  PollutionParaHistoryModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? PPHData.fromJson(json['data']) : null;
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

class PPHData {
  late int ? totalCount;
  late int ? pageSize;
  late int ? totalPage;
  late int ? currPage;
  late List<PollutionXiang> list;

  PPHData(
      {this.totalCount,
        this.pageSize,
        this.totalPage,
        this.currPage,
        required this.list});

  PPHData.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    currPage = json['currPage'];
    if (json['list'] != null) {
      list = <PollutionXiang>[];
      json['list'].forEach((v) {
        list.add(PollutionXiang.fromJson(v));
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

class PollutionXiang {
  late String ? dataTime;
  late List<PollDayIndexData> ? dayIndexData;

  PollutionXiang({this.dataTime, this.dayIndexData});

  PollutionXiang.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    if (json['dayIndexData'] != null) {
      dayIndexData = <PollDayIndexData>[];
      json['dayIndexData'].forEach((v) {
        dayIndexData!.add(PollDayIndexData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataTime'] = this.dataTime;
    if (this.dayIndexData != null) {
      data['dayIndexData'] = dayIndexData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PollDayIndexData {
  late String ? unit;
  late String ? data;
  late String ? indexName;

  PollDayIndexData({this.unit, this.data, this.indexName});

  PollDayIndexData.fromJson(Map<String, dynamic> json) {
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
