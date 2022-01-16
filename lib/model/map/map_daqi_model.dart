class MapDaQiModel {
  late String msg;
  late int code;
  late List<MapDaQi> data;

  MapDaQiModel({required this.msg, required this.code, required this.data});

  MapDaQiModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <MapDaQi>[];
      json['data'].forEach((v) {
        data.add( MapDaQi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MapDaQi {

  String ? name;

  String ? dataTime;

  late String  devLongitude;
  late String  devLatitude;
  late String sn;
  int ? devType;
  late int devStatus;
  MapDaQi(
      {
        this.name,

        this.dataTime,

        required this.devLongitude,
        required this.devLatitude,
        required this.sn,
        this.devType,
        required this.devStatus});

  MapDaQi.fromJson(Map<String, dynamic> json) {

    name = json['name'];

    dataTime = json['dataTime'];

    devLongitude = json['devLongitude'];
    devLatitude = json['devLatitude'];
    sn = json['sn'];
    devType = json['devType'];
    devStatus = json['devStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['name'] = this.name;

    data['dataTime'] = this.dataTime;

    data['devLongitude'] = this.devLongitude;
    data['devLatitude'] = this.devLatitude;
    data['sn'] = this.sn;
    data['devType'] = this.devType;
    data['devStatus'] = this.devStatus;
    return data;
  }
}
