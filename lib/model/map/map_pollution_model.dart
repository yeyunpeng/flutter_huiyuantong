class MapPollutionModel {
  late String msg;
  late int code;
  late List<MapPollution> data;

  MapPollutionModel({required this.msg, required this.code, required this.data});

  MapPollutionModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <MapPollution>[];
      json['data'].forEach((v) {
        data.add( MapPollution.fromJson(v));
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

class MapPollution {
  late int id;
  late String name;
  late String longitude;
  late String latitude;
  late int outType;
  MapPollution(
      {required this.id,
        required this.name,
        required this.longitude,
        required this.latitude,
        required this.outType});

  MapPollution.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    outType = json['outType'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['outType'] = this.outType;
    return data;
  }
}
