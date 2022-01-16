class LoginModel {
 late String ? msg;
 late int ? code;
 late Data ? data;

  LoginModel({this.msg, this.code, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
 late User ?user;
 late String ?token;
 late String ?username;

  Data({this.user, this.token, this.username});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = this.token;
    data['username'] = this.username;
    return data;
  }
}

class User {
  late int id;
  late String account;
  late String password;
  late String username;
  late String regTime;
  late String jobNumber;
  late Null phone;
  late Null email;
  late int busiParkId;
  late int status;
  late int isDelete;
  late Null roleIdList;
  late Null roleIdLists;
  late Null parkName;
  late Null roleNameList;
  late Null roleNameLists;
  late Null roleName;
  late Null callSeriousLevel;
  late Null callLevel;
  late Null startTime;
  late Null endTime;
  late Null pageIndex;
  late Null pageSize;
  late Null regDate;
  late Null state;

  User(
      {required this.id,
        required this.account,
        required this.password,
        required this.username,
        required this.regTime,
        required this.jobNumber,
        this.phone,
        this.email,
        required this.busiParkId,
        required this.status,
        required this.isDelete,
        this.roleIdList,
        this.roleIdLists,
        this.parkName,
        this.roleNameList,
        this.roleNameLists,
        this.roleName,
        this.callSeriousLevel,
        this.callLevel,
        this.startTime,
        this.endTime,
        this.pageIndex,
        this.pageSize,
        this.regDate,
        this.state});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    account = json['account'];
    password = json['password'];
    username = json['username'];
    regTime = json['regTime'];
    jobNumber = json['jobNumber'];
    phone = json['phone'];
    email = json['email'];
    busiParkId = json['busiParkId'];
    status = json['status'];
    isDelete = json['isDelete'];
    roleIdList = json['roleIdList'];
    roleIdLists = json['roleIdLists'];
    parkName = json['parkName'];
    roleNameList = json['roleNameList'];
    roleNameLists = json['roleNameLists'];
    roleName = json['roleName'];
    callSeriousLevel = json['callSeriousLevel'];
    callLevel = json['callLevel'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    regDate = json['regDate'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account'] = this.account;
    data['password'] = this.password;
    data['username'] = this.username;
    data['regTime'] = this.regTime;
    data['jobNumber'] = this.jobNumber;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['busiParkId'] = this.busiParkId;
    data['status'] = this.status;
    data['isDelete'] = this.isDelete;
    data['roleIdList'] = this.roleIdList;
    data['roleIdLists'] = this.roleIdLists;
    data['parkName'] = this.parkName;
    data['roleNameList'] = this.roleNameList;
    data['roleNameLists'] = this.roleNameLists;
    data['roleName'] = this.roleName;
    data['callSeriousLevel'] = this.callSeriousLevel;
    data['callLevel'] = this.callLevel;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['regDate'] = this.regDate;
    data['state'] = this.state;
    return data;
  }
}
