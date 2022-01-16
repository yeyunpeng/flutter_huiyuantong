class WaterParaHistoryModel {
  late String msg;
  late int code;
  late WPHData ? data;

  WaterParaHistoryModel({required this.msg, required this.code, this.data});

  WaterParaHistoryModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? WPHData.fromJson(json['data']) : null;
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

class WPHData {
  late int ? totalCount;
  late int ? pageSize;
  late int ? totalPage;
  late int ? currPage;
  late List<WaterXiang> ? list;

  WPHData(
      {this.totalCount,
        this.pageSize,
        this.totalPage,
        this.currPage,
        required this.list});

  WPHData.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    currPage = json['currPage'];
    if (json['list'] != null) {
      list = <WaterXiang>[];
      json['list'].forEach((v) {
        list!.add(WaterXiang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['pageSize'] = this.pageSize;
    data['totalPage'] = this.totalPage;
    data['currPage'] = this.currPage;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaterXiang {
  late String ? dataTime;
  late List<WPHistoryData> ? historyData;

  WaterXiang({this.dataTime, this.historyData});

  WaterXiang.fromJson(Map<String, dynamic> json) {
    dataTime = json['dataTime'];
    if (json['historyData'] != null) {
      historyData = <WPHistoryData>[];
      json['historyData'].forEach((v) {
        historyData!.add(WPHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dataTime'] = dataTime;
    if (historyData != null) {
      data['historyData'] = historyData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WPHistoryData {
  late String ? unit;
  late String ? data;
  late String ? indexName;

  WPHistoryData({this.unit, this.data, this.indexName});

  WPHistoryData.fromJson(Map<String, dynamic> json) {
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
