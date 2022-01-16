import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
class MyPage extends StatefulWidget{
  @override
  _MyPageState createState()=>_MyPageState();
}
class _MyPageState extends State<MyPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width, // 屏幕宽度
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color.fromRGBO(6, 36, 66, 1),Color.fromRGBO(16, 56, 95, 1),Color.fromRGBO(1, 20, 43, 1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0,0.5,1],
              )
          ),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),
              SizedBox(height: Adapt.px(19),),
              Text('我的',
                style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(32)),),
              SizedBox(height: Adapt.px(159),),
              Image(image: const AssetImage('images/logo.png'),width: Adapt.px(164),height: Adapt.px(164),),
              SizedBox(height: Adapt.px(45),),
              Text('V.1.0.0',
                style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),),
              SizedBox(height: Adapt.px(56),),
              Row(
                children: [
                  SizedBox(width: Adapt.px(100),),
                  Expanded(child: Text('      慧园通旨在为持续改善环境质量提供数据支撑、技术支撑，为环境质量全方位治理提供环境科学决策支撑。',
                    style: TextStyle(
                        color:  Color.fromRGBO(185, 233, 255, 1),
                        fontSize: Adapt.px(24)),),),
                  SizedBox(width: Adapt.px(100),),
                ],
              ),

              SizedBox(height: Adapt.px(24),),
              Row(
                children: [
                  SizedBox(width: Adapt.px(100),),
                  Expanded(child: Text('      主要功能包括地图展示、超标预警、大气环境质量监控、水环境质量监控、污染源监控。',
                    style: TextStyle(
                        color:  Color.fromRGBO(185, 233, 255, 1),
                        fontSize: Adapt.px(24)),),),
                  SizedBox(width: Adapt.px(100),),
                ],
              ),

              SizedBox(height: Adapt.px(24),),
              Expanded(child: Container()),
              InkWell(
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.remove('username');
                  prefs.remove('password');
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyLogin()));
                },
                child: Container(
                  width: Adapt.px(550),
                  height: Adapt.px(88),
                  alignment: Alignment.center,
                  decoration:  BoxDecoration(
                    border: Border.all(color: const Color.fromRGBO(46, 228, 149, 1),width:Adapt.px(1)),
                    borderRadius: BorderRadius.circular(Adapt.px(44)),),
                  child: Text('退出登录',
                    style: TextStyle(
                        color:  Color.fromRGBO(46, 228, 149, 1),
                        fontSize: Adapt.px(32)),),
                ),
              ),

              SizedBox(height: Adapt.px(96),),
            ],
          ),

      )
    );
  }

}