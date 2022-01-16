class PollutionOutletModel {
  late String msg;
  late int code;
  late List<OutletData>  data;

  PollutionOutletModel({required this.msg, required this.code, required this.data});

  PollutionOutletModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    if (json['data'] != null) {
      data =  <OutletData>[];
      json['data'].forEach((v) {
        data!.add(new OutletData.fromJson(v));
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

class OutletData {
  late int ? id;
  late String ? name;
  late List<OutletList>  outletList;
  late int ? comType;
  OutletData(
      {this.id,
        this.name,
        required this.outletList,
        this.comType});

  OutletData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    if (json['outletList'] != null) {
      outletList = <OutletList>[];
      json['outletList'].forEach((v) {
        outletList!.add(OutletList.fromJson(v));
      });
    }
    comType = json['comType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    if (this.outletList != null) {
      data['outletList'] = this.outletList!.map((v) => v.toJson()).toList();
    }
    data['comType'] = this.comType;

    return data;
  }
}

class OutletList {
  late int ? id;
  late String ? name;


  OutletList(
      {this.id,
        this.name});

  OutletList.fromJson(Map<String, dynamic> json) {
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
