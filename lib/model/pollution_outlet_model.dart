class PollutionOutletModel {
  late String msg;
  late int code;
  late List<OutletData> ? data;

  PollutionOutletModel({required this.msg, required this.code, this.data});

  PollutionOutletModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <OutletData>[];
      json['data'].forEach((v) {
        data!.add( OutletData.fromJson(v));
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

class OutletData {
  late String ? outletName;
  late String ? alarmCount;
  late int ? outletId;
  late String ? updateTime;
  late List<String> ? indexData;
  late String ? comName;
  late int ? type;

  OutletData(
      {this.outletName,
        this.alarmCount,
        this.outletId,
        this.updateTime,
        this.indexData,
        this.comName,
        this.type});

  OutletData.fromJson(Map<String, dynamic> json) {
    outletName = json['outletName'];
    alarmCount = json['alarmCount'].toString();
    outletId = json['outletId'];
    updateTime = json['updateTime'];
    indexData = json['indexData'].cast<String>();
    comName = json['comName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['outletName'] = this.outletName;
    data['alarmCount'] = this.alarmCount;
    data['outletId'] = this.outletId;
    data['updateTime'] = this.updateTime;
    data['indexData'] = this.indexData;
    data['comName'] = this.comName;
    data['type'] = this.type;
    return data;
  }
}
