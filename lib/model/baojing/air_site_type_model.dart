class AirSiteTypeModel {
  late String msg;
  late int code;
  late List<SiteTypeData> data;

  AirSiteTypeModel({required this.msg, required this.code, required this.data});

  AirSiteTypeModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <SiteTypeData>[];
      json['data'].forEach((v) {
        data.add(SiteTypeData.fromJson(v));
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

class SiteTypeData {
  late int ? id;
  late String ? name;


  SiteTypeData({ this.id,  this.name});

  SiteTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }
}
