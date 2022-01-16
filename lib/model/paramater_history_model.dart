class ParaHistoryModel {
  late String msg;
  late int code;
  late MyData1 ? data;

  ParaHistoryModel({required this.msg, required this.code, this.data});

  ParaHistoryModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = (json['data'] != null ? MyData1.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}

class MyData1 {
  late int totalCount;
  late int pageSize;
  late int totalPage;
  late int currPage;
  late List<Xiang> list;

  MyData1(
      {required this.totalCount,
        required this.pageSize,
        required this.totalPage,
        required this.currPage,
        required this.list});

  MyData1.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    currPage = json['currPage'];
    if (json['list'] != null) {
      list = <Xiang>[];
      json['list'].forEach((v) {
        list.add(Xiang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['pageSize'] = pageSize;
    data['totalPage'] = totalPage;
    data['currPage'] = currPage;
    data['list'] = list.map((v) => v.toJson()).toList();
    return data;
  }
}

class Xiang {
  late String ? dataTime;
  late List<DayIndexData> ? dayIndexData;

  Xiang({this.dataTime, this.dayIndexData});

  Xiang.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    if (json['dayIndexData'] != null) {
      dayIndexData =  <DayIndexData>[];
      json['dayIndexData'].forEach((v) {
        dayIndexData!.add(DayIndexData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataTime'] = dataTime;
    if (dayIndexData != null) {
      data['dayIndexData'] = dayIndexData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DayIndexData {
  String ? unit;
  String ? data;
  String ? indexName;

  DayIndexData({this.unit, this.data, this.indexName});

  DayIndexData.fromJson(Map<String, dynamic> json) {
    unit = json['unit'];
    data = json['data'].toString();
    indexName = json['indexName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unit'] = unit;
    data['data'] = this.data;
    data['indexName'] = indexName;
    return data;
  }
}
