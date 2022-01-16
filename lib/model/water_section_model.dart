class WaterSectionModel {
  late String msg;
  late int code;
  late List<WaterData> ? data;

  WaterSectionModel({required this.msg, required this.code, this.data});

  WaterSectionModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = <WaterData>[];
      json['data'].forEach((v) {
        data!.add( WaterData.fromJson(v));
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

class WaterData {
  late String ? pollutionIndexName;
  late String ? alarmCount;
  late int  fraId;
  late int  riverId;
  late String ? updateTime;
  late String ? waterType;
  late String ? riverName;
  late String ? fraName;

  WaterData(
      {this.pollutionIndexName,
        this.alarmCount,
        required this.fraId,
        required this.riverId,
        this.updateTime,
        this.waterType,
        this.riverName,
        this.fraName});

  WaterData.fromJson(Map<String, dynamic> json) {
    pollutionIndexName = json['pollutionIndexName'];
    alarmCount = json['alarmCount'].toString();
    fraId = json['fraId'];
    riverId = json['riverId'];
    updateTime = json['updateTime'];
    waterType = json['waterType'].toString();
    riverName = json['riverName'];
    fraName = json['fraName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pollutionIndexName'] = this.pollutionIndexName;
    data['alarmCount'] = this.alarmCount;
    data['fraId'] = this.fraId;
    data['riverId'] = this.riverId;
    data['updateTime'] = this.updateTime;
    data['waterType'] = waterType;
    data['riverName'] = this.riverName;
    data['fraName'] = this.fraName;
    return data;
  }
}
