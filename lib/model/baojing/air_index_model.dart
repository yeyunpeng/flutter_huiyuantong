class AirIndexModel {
  late String msg;
  late int code;
  late List<AirIndexData> ? data;

  AirIndexModel({required this.msg, required this.code,  this.data});

  AirIndexModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <AirIndexData>[];
      json['data'].forEach((v) {
        data!.add(AirIndexData.fromJson(v));
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

class AirIndexData {
  late int ? id;
  late String ? name;
  late String ? code;

  AirIndexData(
      {this.id,
        this.name,
        this.code
      });

  AirIndexData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
