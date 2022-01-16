class MapWaterModel {
  late String msg;
  late int code;
  late MapWater data;

  MapWaterModel({required this.msg, required this.code, required this.data});

  MapWaterModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = (json['data'] != null ? MapWater.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class MapWater {
  late List<MapWaterAllData> allData;


  MapWater(
      {required this.allData,
        });

  MapWater.fromJson(Map<String, dynamic> json) {
    if (json['allData'] != null) {
      allData =  <MapWaterAllData>[];
      json['allData'].forEach((v) {
        allData.add( MapWaterAllData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allData != null) {
      data['allData'] = this.allData.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class MapWaterAllData {
  late int id;
  late String name;
  late int type;
  late String longitude;
  late String latitude;
  late int onLineState;
  late String rivName;
  late int pollutantType;
   String ? outGauge;
   String ? cwqiValue;
  MapWaterAllData(
      {required this.id,
        required this.name,
        required this.type,

        required this.longitude,
        required this.latitude,

        required this.onLineState,

        required this.rivName,

        required this.pollutantType,
         this.outGauge,
         this.cwqiValue
       });

  MapWaterAllData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];

    longitude = json['longitude'];
    latitude = json['latitude'];


    onLineState = json['onLineState'];

    rivName = json['rivName'];

    pollutantType = json['pollutantType'];
    outGauge = json['outGauge'];
    cwqiValue = json['cwqiValue'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;

    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;


    data['onLineState'] = this.onLineState;

    data['rivName'] = this.rivName;
    data['pollutantType'] = this.pollutantType;
    data['outGauge'] = this.outGauge;
    data['cwqiValue'] = this.cwqiValue;

    return data;
  }
}
