class AirSiteModel {
  late String msg;
  late int code;
  late List<Airshebei> ? data;

  AirSiteModel({required this.msg, required this.code, this.data});

  AirSiteModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <Airshebei>[];
      json['data'].forEach((v) {
        data!.add(Airshebei.fromJson(v));
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

class Airshebei {
  late String ? sn;
  late String ? name;
  late int ? devType;
  Airshebei(
      {this.sn,
        this.name,
        this.devType
       });

  Airshebei.fromJson(Map<String, dynamic> json) {
    sn = json['sn'];
    name = json['name'];

    devType = json['devType'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sn'] = this.sn;
    data['name'] = this.name;

    data['devType'] = this.devType;

    return data;
  }
}
