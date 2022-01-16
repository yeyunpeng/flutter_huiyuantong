import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/login_model.dart';
import 'package:flutter_huiyuantong/navigator/tab_navigator.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
class MyLogin extends StatefulWidget{
  const MyLogin({Key? key}) : super(key: key);

  @override
  _myloginState createState()=>_myloginState();

}
class _myloginState extends State<MyLogin>{
  late double firstlatitude ;
  late double firstlongitude ;

  bool _mapCreated = false;
  CustomStyleOptions _customStyleOptions = CustomStyleOptions(false);

  Map<String, Object> _locationResult = {};

  late StreamSubscription<Map<String, Object>> _locationListener;

  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();

  var loginmodel;
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey _formKey  = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    requestPermission();
    myMethod();
    /// 动态申请定位权限


    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }


    firstlatitude = 39.909187;
    firstlongitude = 116.397451;
  }
  void myMethod() async{
    final prefs = await SharedPreferences.getInstance();
      if(prefs.getString('username')!=null&&prefs.getString('password')!=null){
        _unameController.text=prefs.getString('username').toString();
        _pwdController.text=prefs.getString('password').toString();
        print(_pwdController.text+_unameController.text);
      }
  }
  _loginPost() async{
    // var url = Uri.parse('http://39.105.58.216:13001/api/user/login');
    // var result=await http.post(url,body: {'account':_unameController.text,'password':_pwdController.text});
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // loginmodel=LoginModel.fromJson(json.decode(utf8decoder.convert(result.bodyBytes)));
    if(_unameController.text=='admin'&&_pwdController.text=='admin'){
      // print(loginmodel.data.user.busiParkId);
      // print(loginmodel.data.token);
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setString('busiParkId', loginmodel.data.user.busiParkId.toString());
      // prefs.setString('authorization', loginmodel.data.token.toString());
      //  if(prefs.getString('username')!=null&&prefs.getString('password')!=null){
      //    _unameController.text=prefs.getString('username').toString();
      //    _pwdController.text=prefs.getString('password').toString();
      //    print(_pwdController.text+_unameController.text);
      //  }else{
      //    prefs.setString('username', _unameController.text);
      //    prefs.setString('password', _pwdController.text);
      //  }



      Fluttertoast.showToast(
          msg: '登陆成功',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>TabNavigator()));
    }else{
      Fluttertoast.showToast(
          msg: '账号密码错误',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0
      );
      print(loginmodel.code);
      print(loginmodel.msg);
    }

  }

  ///获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
    await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
      // _startLocation();
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();

    ///移除定位监听
    _locationListener.cancel();

    ///销毁定位
    _locationPlugin.destroy();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width, // 屏幕宽度
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: ExactAssetImage('images/bg.png'),
          fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
            child:  Column(
              children: [
                const SizedBox(height: 124,),
                SizedBox(
                  height: Adapt.px(230),
                  child: const Image(image: AssetImage('images/logo.png')),
                ),
                const SizedBox(height: 4.5,),
                const Text('慧园通APP',
                  style: TextStyle(
                      color:  Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 24),
                ),
                const SizedBox(height: 100,),
                //用户名
                SizedBox(
                  width: Adapt.px(542),
                  height: Adapt.px(88),
                  child: TextField(
                    controller: _unameController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        borderSide:const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0),
                          width: 1.0,
                        ),
                      ),
                      fillColor: const Color.fromRGBO(0, 0, 0, 0.1),//背景色
                      filled: true,//重点，必须设置为true，fillColor才有效
                      isCollapsed: true,//重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                      contentPadding: const EdgeInsets.all(12),//内容内边距，影响高度
                      hintText: '请输入账号',
                      prefixIcon: Visibility(
                        visible: true,
                        child: Container(
                            padding:  const EdgeInsets.only(left: 24,top: 10,bottom: 10),
                            child: const ImageIcon(
                                AssetImage('images/user.png'),
                                size: 12.0,
                                color: Color.fromRGBO(46, 228, 149, 1))),
                      ),

                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(185, 233, 255, 1),
                        fontSize: 12,
                      ),

                    ),
                  ),
                ),
                const SizedBox(height: 32,),
                //密码
                SizedBox(
                  width: Adapt.px(542),
                  height: Adapt.px(88),
                  child: TextField(
                    controller: _pwdController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0),
                          width: 1.0,
                        ),
                      ),
                      fillColor: const Color.fromRGBO(0, 0, 0, 0.1),
                      filled: true,//重点，必须设置为true，fillColor才有效
                      isCollapsed: true,//重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                      contentPadding: const EdgeInsets.all(12),//内容内边距，影响高度
                      hintText: '请输入密码',

                      prefixIcon: Visibility(
                        visible: true,
                        child: Container(
                            padding:  const EdgeInsets.only(left: 24,top: 10,bottom: 10),
                            child: const ImageIcon(
                                AssetImage('images/lock.png'),
                                size: 12.0,
                                color: Color.fromRGBO(46, 228, 149, 1))),
                      ),

                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(185, 233, 255, 1),
                        fontSize: 12,
                      ),

                    ),
                    obscureText: true,
                  ),
                ),
                const SizedBox(height: 44,),
                Container(
                    width: Adapt.px(542),
                    height: Adapt.px(88),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(colors:[Color.fromRGBO(46, 228, 149, 1),Color.fromRGBO(91, 243, 199, 1)])
                    ),
                    child:  TextButton(
                      //设置按钮是否自动获取焦点
                      autofocus: false,
                      child:  const Text('登录',style: TextStyle(color: Colors.white,fontSize: 16),),
                      onPressed: (){
                        _loginPost();
                        // ignore: avoid_print
                        print(_pwdController.text+_unameController.text);
                      },
                    )
                ),
              ],
            ))

      ),
    );
  }
}
