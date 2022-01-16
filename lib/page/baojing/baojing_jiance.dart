class BaojingJiance {
  late String msg;
  late int code;
  late Data data;

  BaojingJiance({required this.msg, required this.code, required this.data});

  BaojingJiance.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
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
  late int airAlarmTotal;
  late int pollutionAlarmTotal;
  late int waterAlarmTotal;

  Data({required this.airAlarmTotal, required this.pollutionAlarmTotal, required this.waterAlarmTotal});

  Data.fromJson(Map<String, dynamic> json) {
    airAlarmTotal = json['airAlarmTotal'];
    pollutionAlarmTotal = json['pollutionAlarmTotal'];
    waterAlarmTotal = json['waterAlarmTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['airAlarmTotal'] = this.airAlarmTotal;
    data['pollutionAlarmTotal'] = this.pollutionAlarmTotal;
    data['waterAlarmTotal'] = this.waterAlarmTotal;
    return data;
  }
}
