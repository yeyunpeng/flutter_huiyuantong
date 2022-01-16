class PollutionIndexModel {
  late String msg;
  late int code;
  late DropDownPollutionIndexData data;

  PollutionIndexModel({required this.msg, required this.code, required this.data});

  PollutionIndexModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = (json['data'] != null ? DropDownPollutionIndexData.fromJson(json['data']) : null)!;
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

class DropDownPollutionIndexData {
  late List<PollutionIndexAir> air;
  late List<PollutionIndexWater> water;

  DropDownPollutionIndexData({required this.air, required this.water});

  DropDownPollutionIndexData.fromJson(Map<String, dynamic> json) {
    if (json['air'] != null) {
      air = <PollutionIndexAir>[];
      json['air'].forEach((v) {
        air.add( PollutionIndexAir.fromJson(v));
      });
    }
    if (json['water'] != null) {
      water = <PollutionIndexWater>[];
      json['water'].forEach((v) {
        water.add(PollutionIndexWater.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.air != null) {
      data['air'] = this.air.map((v) => v.toJson()).toList();
    }
    if (this.water != null) {
      data['water'] = this.water.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PollutionIndexAir {
 late int ? id;
 late String ? name;
  PollutionIndexAir(
      {this.id,
        this.name,
       });

 PollutionIndexAir.fromJson(Map<String, dynamic> json) {
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

class PollutionIndexWater {
  late int id;
  late String name;


  PollutionIndexWater(
      {required this.id,
        required this.name,
       });

  PollutionIndexWater.fromJson(Map<String, dynamic> json) {
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
