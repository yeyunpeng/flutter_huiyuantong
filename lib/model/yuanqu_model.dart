class YuanQuModel{
  late  String ? msg;
  late  int ? code;
  late  Data ? data;

  YuanQuModel({this.msg, this.code, this.data});

  YuanQuModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int ? count1;
  int ? count2;
  int ? count3;
  int ? count4;
  int ? count5;
  int ? count6;

  Data(
      {this.count1,
        this.count2,
        this.count3,
        this.count4,
        this.count5,
        this.count6});

  Data.fromJson(Map<String, dynamic> json) {
    count1 = json['count1'];
    count2 = json['count2'];
    count3 = json['count3'];
    count4 = json['count4'];
    count5 = json['count5'];
    count6 = json['count6'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count1'] = this.count1;
    data['count2'] = this.count2;
    data['count3'] = this.count3;
    data['count4'] = this.count4;
    data['count5'] = this.count5;
    data['count6'] = this.count6;
    return data;
  }
}