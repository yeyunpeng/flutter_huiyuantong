class AirModel {
  late String msg;
  late int code;
  late Data data;

  AirModel({required this.msg, required this.code, required this.data});

  AirModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
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

class Data {
  Null id;
  Null sn;
  late num ? aqi;
  Null synthesisGrade;
  late num ? pm10;
  late num ? pm25;
  late num ? so2;
  late num ? no2;
  late num ? co;
  late num ? o3;
  Null o38h;
  Null windSpeed;
  late String ? windDirection;
  late num ? temp;
  late num ? humidity;
  late num ? airPressure;
  Null nmhc;
  late String ? major;
  late String ? dataTime;
  Null tvoc;
  Null regionId;
  Null area;

  Data(
      {this.id,
        this.sn,
        this.aqi,
        this.synthesisGrade,
        this.pm10,
        this.pm25,
        this.so2,
        this.no2,
        this.co,
        this.o3,
        this.o38h,
        this.windSpeed,
        this.windDirection,
        this.temp,
        this.humidity,
        this.airPressure,
        this.nmhc,
        this.major,
        this.dataTime,
        this.tvoc,
        this.regionId,
        this.area});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sn = json['sn'];
    aqi = json['aqi'];
    synthesisGrade = json['synthesisGrade'];
    pm10 = json['pm10'];
    pm25 = json['pm25'];
    so2 = json['so2'];
    no2 = json['no2'];
    co = json['co'];
    o3 = json['o3'];
    o38h = json['o38h'];
    windSpeed = json['windSpeed'];
    windDirection = json['windDirection'];
    temp = json['temp'];
    humidity = json['humidity'];
    airPressure = json['airPressure'];
    nmhc = json['nmhc'];
    major = json['major'];
    dataTime = json['dataTime'];
    tvoc = json['tvoc'];
    regionId = json['regionId'];
    area = json['area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sn'] = this.sn;
    data['aqi'] = this.aqi;
    data['synthesisGrade'] = this.synthesisGrade;
    data['pm10'] = this.pm10;
    data['pm25'] = this.pm25;
    data['so2'] = this.so2;
    data['no2'] = this.no2;
    data['co'] = this.co;
    data['o3'] = this.o3;
    data['o38h'] = this.o38h;
    data['windSpeed'] = this.windSpeed;
    data['windDirection'] = this.windDirection;
    data['temp'] = this.temp;
    data['humidity'] = this.humidity;
    data['airPressure'] = this.airPressure;
    data['nmhc'] = this.nmhc;
    data['major'] = this.major;
    data['dataTime'] = this.dataTime;
    data['tvoc'] = this.tvoc;
    data['regionId'] = this.regionId;
    data['area'] = this.area;
    return data;
  }
}
