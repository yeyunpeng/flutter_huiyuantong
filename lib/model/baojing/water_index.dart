class WaterIndexModel {
  late String msg;
  late int code;
 late List<IndexData> ? data;

  WaterIndexModel({required this.msg, required this.code,  this.data});

  WaterIndexModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <IndexData>[];
      json['data'].forEach((v) {
        data!.add(IndexData.fromJson(v));
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

class IndexData {
  late int ? id;
  late String ? name;


  IndexData(
      {this.id,
        this.name
    });

  IndexData.fromJson(Map<String, dynamic> json) {
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
