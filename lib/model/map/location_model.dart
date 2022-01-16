class LocationModel {
  late String msg;
  late int code;
  late List<Area> data;
  late CenterZuobiao center;

  LocationModel({required this.msg, required this.code, required this.data, required this.center});

  LocationModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <Area>[];
      json['data'].forEach((v) {
        data.add( Area.fromJson(v));
      });
    }
    center =
    (json['center'] != null ? CenterZuobiao.fromJson(json['center']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.center != null) {
      data['center'] = this.center.toJson();
    }
    return data;
  }
}

class Area {

  late String longitude;
  late String latitude;


  Area(
      {
        required this.longitude,
        required this.latitude,
        });

  Area.fromJson(Map<String, dynamic> json) {

    longitude = json['longitude'];
    latitude = json['latitude'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;

    return data;
  }
}

class CenterZuobiao {
  late int ? id;
  late String ? name;
  late String ? longitude;
  late String ? latitude;
  late String ? parkCoordinate;


  CenterZuobiao(
      {this.id,
        this.name,
        this.longitude,
        this.latitude,
        this.parkCoordinate,
        });

  CenterZuobiao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    parkCoordinate = json['parkCoordinate'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['parkCoordinate'] = this.parkCoordinate;

    return data;
  }
}
