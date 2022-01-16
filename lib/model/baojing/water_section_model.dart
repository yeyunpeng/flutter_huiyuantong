class WaterSectionModel {
  late String msg;
  late int code;
  late List<WaterSection> ? data;

  WaterSectionModel({required this.msg, required this.code, this.data});

  WaterSectionModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <WaterSection>[];
      json['data'].forEach((v) {
        data!.add(WaterSection.fromJson(v));
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

class WaterSection {
  late int ? id;
  late String ? name;


  WaterSection(
      { this.id,
        this.name
     });

  WaterSection.fromJson(Map<String, dynamic> json) {
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
