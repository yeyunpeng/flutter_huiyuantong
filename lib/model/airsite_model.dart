class AirSiteModel {
  late String msg;
  late int code;
  late List<AirSiteData> ? data;

  AirSiteModel({required this.msg, required this.code,  this.data});

  AirSiteModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data = <AirSiteData>[];
      json['data'].forEach((v) {
        data!.add(AirSiteData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['code'] = code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AirSiteData {
  late  int ? deviceType;
  late  String ? alarmCount;
  late  String ? regionName;
  late  String ? deviceTypeName;
  late  String ? firstPollution;
  late String  ? updateTime;
  late String ? indexData;
  late String ? sn;
  late String ? deviceName;

  AirSiteData(
      {this.deviceType,
        this.alarmCount,
        this.regionName,
        this.deviceTypeName,
        this.firstPollution,
        this.updateTime,
        this.indexData,
        this.sn,
        this.deviceName});

  AirSiteData.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    alarmCount = json['alarmCount'];
    regionName = json['regionName'];
    deviceTypeName = json['deviceTypeName'];
    firstPollution = json['firstPollution'];
    updateTime = json['updateTime'];
    indexData = json['indexData'].toString();
    sn = json['sn'].toString();
    deviceName = json['deviceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceType'] = deviceType;
    data['alarmCount'] = alarmCount;
    data['regionName'] = regionName;
    data['deviceTypeName'] = deviceTypeName;
    data['firstPollution'] = firstPollution;
    data['updateTime'] = updateTime;
    data['indexData'] = indexData;
    data['sn'] = sn;
    data['deviceName'] = deviceName;
    return data;
  }
}
