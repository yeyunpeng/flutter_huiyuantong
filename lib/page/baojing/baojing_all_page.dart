import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'baojing_jiance.dart';
class BaojingAllPage extends StatefulWidget{
  @override
  _BaojingAllPageState createState()=>_BaojingAllPageState();
}
class _BaojingAllPageState extends State<BaojingAllPage>{
   var baojingJiance;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    //初始化方法里面添加监听器

  }
  Future<BaojingJiance> _alarmjianceGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/alarmOverview/getRealtimeStatistic');
    // var result=await http.get(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization},
    // );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
String text='{"msg":"success","code":200,"data":{"airAlarmTotal":2347,"pollutionAlarmTotal":196,"waterAlarmTotal":2177}}';
      baojingJiance=BaojingJiance.fromJson(json.decode(text)) ;
      return baojingJiance;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration:  const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color.fromRGBO(1, 20, 43, 1),width: 0.0)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0,0.5,1],
                colors: [ Color.fromRGBO(6, 36, 66, 1),Color.fromRGBO(16, 56, 95, 1),Color.fromRGBO(1, 20, 43, 1)]
            ),

        ),
        child:SingleChildScrollView(
          padding: EdgeInsets.only(left: Adapt.px(32),right: Adapt.px(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Adapt.px(32),),
              Text('实时报警管控统计',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28))),
              SizedBox(height: Adapt.px(16),),
              FutureBuilder(future: _alarmjianceGet(),
                  builder: (BuildContext context, AsyncSnapshot<BaojingJiance> snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return const Text('网络连接失败');
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      case  ConnectionState.active:
                        return const Text('111');
                      case ConnectionState.done:
                        if(snapshot.hasError){
                          return Text(
                            '${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          );
                        }else{
                          return Row(children: [
                            Container(
                              decoration:  BoxDecoration(
                                  color: const Color.fromRGBO(185, 233, 255, 0.05),
                                  borderRadius: BorderRadius.all(Radius.circular(Adapt.px(32)))
                              ),
                              padding: EdgeInsets.only(left: Adapt.px(24),top: Adapt.px(32)),
                              width: Adapt.px(213),
                              height: Adapt.px(224),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(image: const AssetImage('images/airbaojing.png'),width: Adapt.px(64),
                                    height: Adapt.px(64),),
                                  SizedBox(height: Adapt.px(28),),
                                  SizedBox(
                                    width: Adapt.px(165),
                                    height: Adapt.px(28),
                                    child: Text('大气监测报警',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 0.75),fontSize: Adapt.px(20))),
                                  ),
                                  SizedBox(height: Adapt.px(4),),
                                  SizedBox(
                                    width: Adapt.px(124),
                                    height: Adapt.px(64),
                                    child: Text(baojingJiance.data.airAlarmTotal.toString(),style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(42)),overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: Adapt.px(24),),
                            Container(
                              decoration:  BoxDecoration(
                                  color: const Color.fromRGBO(185, 233, 255, 0.05),
                                  borderRadius: BorderRadius.all(Radius.circular(Adapt.px(32)))
                              ),
                              padding: EdgeInsets.only(left: Adapt.px(24),top: Adapt.px(32)),
                              width: Adapt.px(212),
                              height: Adapt.px(224),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(image: const AssetImage('images/airbaojing.png'),width: Adapt.px(64),
                                    height: Adapt.px(64),),
                                  SizedBox(height: Adapt.px(28),),
                                  SizedBox(
                                    width: Adapt.px(165),
                                    height: Adapt.px(28),
                                    child: Text('水质监测报警',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 0.75),fontSize: Adapt.px(20))),
                                  ),
                                  SizedBox(height: Adapt.px(4),),
                                  SizedBox(
                                    width: Adapt.px(124),
                                    height: Adapt.px(64),
                                    child: Text(baojingJiance.data.waterAlarmTotal.toString(),style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(42)),overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: Adapt.px(24),),
                            Container(
                              decoration:  BoxDecoration(
                                  color: const Color.fromRGBO(185, 233, 255, 0.05),
                                  borderRadius: BorderRadius.all(Radius.circular(Adapt.px(32)))
                              ),
                              padding: EdgeInsets.only(left: Adapt.px(24),top: Adapt.px(32)),
                              width: Adapt.px(213),
                              height: Adapt.px(224),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(image: const AssetImage('images/airbaojing.png'),width: Adapt.px(64),
                                    height: Adapt.px(64),),
                                  SizedBox(height: Adapt.px(28),),
                                  SizedBox(
                                    width: Adapt.px(165),
                                    height: Adapt.px(28),
                                    child: Text('污染源监测报警',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 0.75),fontSize: Adapt.px(20))),
                                  ),
                                  SizedBox(height: Adapt.px(4),),
                                  SizedBox(
                                    width: Adapt.px(124),
                                    height: Adapt.px(64),
                                    child: Text(baojingJiance.data.pollutionAlarmTotal.toString(),style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(42)),overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              ),
                            ),
                          ],);
                        }
                    }
                  }
              ),
              SizedBox(height: Adapt.px(32),),
              Text('近30天超标报警趋势',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28))),
              SizedBox(height: Adapt.px(16),),
              Container(
                decoration:  BoxDecoration(
                    color: const Color.fromRGBO(185, 233, 255, 0.05),
                    borderRadius: BorderRadius.all(Radius.circular(Adapt.px(32)))
                ),
                padding: EdgeInsets.only(left: Adapt.px(24),top: Adapt.px(32)),
                width: Adapt.px(686),
                height: Adapt.px(440),),
              SizedBox(height: Adapt.px(32),),
              Text('当月站点名排排名TOP10',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28))),
              SizedBox(height: Adapt.px(16),),
              Container(
                decoration:  BoxDecoration(
                    color: const Color.fromRGBO(185, 233, 255, 0.05),
                    borderRadius: BorderRadius.all(Radius.circular(Adapt.px(32)))
                ),
                padding: EdgeInsets.only(left: Adapt.px(24),top: Adapt.px(32)),
                width: Adapt.px(686),
                height: Adapt.px(440),),
            ],
          ),
        ),
      )

    );
  }

}