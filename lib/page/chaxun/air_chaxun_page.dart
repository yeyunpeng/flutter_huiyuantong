import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../air_site_details.dart';

class AirChaXunPage extends StatefulWidget{
  const AirChaXunPage({Key? key}) : super(key: key);
  @override
  _AirChaXunPageState createState()=>_AirChaXunPageState();
}
class _AirChaXunPageState extends State<AirChaXunPage>{

  var airsitemodel;
  final TextEditingController _unameController = TextEditingController();
  late List<AirSiteData> AirSiteList ;
  List<AirSiteData> sousuoSiteList=[] ;
  List<String>  lishiList=[];
  String  devType='-1';
  String  regionId='-1';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMethod();
  }
  void myMethod() async{
    final prefs = await SharedPreferences.getInstance();
if(prefs.getStringList('lishiList')!=null) {
  lishiList = prefs.getStringList('lishiList')!;
}

  }
  void myMethod2(List<String> lishiList) async{
    final prefs = await SharedPreferences.getInstance();
   prefs.setStringList('lishiList', lishiList);

    }
  void myMethodremove() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('lishiList');

  }
  Future<AirSiteModel> alarmRealTimedGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('http://39.105.58.216:13001/api/countryDataDay/appQryStationType');
    // var result=await http.post(url,headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //     body: jsonEncode({'devType':devType,'regionId':regionId}));
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // // print(json.decode(utf8decoder.convert(result.bodyBytes)));
    // airsitemodel=AirSiteModel.fromJson(json.decode(utf8decoder.convert(result.bodyBytes)));
    String jsontext='{"msg":"success","code":200,"data":[{"deviceType":4,"alarmCount":"99","regionName":"区域0003","deviceTypeName":"恶臭","updateTime":"2021-12-28 17:20:04","indexData":"[NH₃, C₃H₉N, H₂S, CH₄S, C₂H₆S, C₂H₆S₂, CS₂, C₈H₈, OU]","sn":"300090024","deviceName":"恶臭04"},{"deviceType":2,"alarmCount":"91","regionName":"区域0001","deviceTypeName":"网格站","firstPollution":"SO2","updateTime":"2021-12-28 17:16:02","indexData":280.0,"sn":"2581","deviceName":"大兴"},{"deviceType":1,"alarmCount":"91","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"NO2","updateTime":"2021-12-28 17:16:03","indexData":195.0,"sn":"608","deviceName":"东四"},{"deviceType":2,"alarmCount":"91","regionName":"区域0002","deviceTypeName":"网格站","firstPollution":"PM2.5","updateTime":"2021-12-28 17:16:03","indexData":144.0,"sn":"618","deviceName":"顺义新城"},{"deviceType":4,"alarmCount":"90","regionName":"区域0004","deviceTypeName":"恶臭","updateTime":"2021-12-28 17:20:03","indexData":"[NH₃, C₃H₉N, H₂S, CH₄S, C₂H₆S, C₂H₆S₂, CS₂, C₈H₈, OU]","sn":"300090020","deviceName":"恶臭01"},{"deviceType":4,"alarmCount":"90","regionName":"区域0004","deviceTypeName":"恶臭","updateTime":"2021-12-28 17:20:03","indexData":"[NH₃, C₃H₉N, H₂S, CH₄S, C₂H₆S, C₂H₆S₂, CS₂, C₈H₈, OU]","sn":"300090023","deviceName":"恶臭03"},{"deviceType":1,"alarmCount":"84","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":148.0,"sn":"2595","deviceName":"门头沟"},{"deviceType":4,"alarmCount":"81","regionName":"区域0003","deviceTypeName":"恶臭","updateTime":"2021-12-28 17:20:04","indexData":"[NH₃, C₃H₉N, H₂S, CH₄S, C₂H₆S, C₂H₆S₂, CS₂, C₈H₈, OU]","sn":"300090025","deviceName":"恶臭05"},{"deviceType":2,"alarmCount":"77","regionName":"区域0001","deviceTypeName":"网格站","firstPollution":"SO2","updateTime":"2021-12-28 17:16:02","indexData":100.0,"sn":"2578","deviceName":"北部新区"},{"deviceType":2,"alarmCount":"77","regionName":"区域0001","deviceTypeName":"网格站","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":195.0,"sn":"2574","deviceName":"京西北"},{"deviceType":1,"alarmCount":"77","regionName":"区域0001","deviceTypeName":"国标站","firstPollution":"PM10","updateTime":"2021-12-28 17:16:02","indexData":134.0,"sn":"2594","deviceName":"通州"},{"deviceType":1,"alarmCount":"77","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"NO2","updateTime":"2021-12-28 17:16:03","indexData":41.0,"sn":"607","deviceName":"万寿西宫"},{"deviceType":1,"alarmCount":"77","regionName":"区域0001","deviceTypeName":"国标站","firstPollution":"O3","updateTime":"2021-12-28 17:16:02","indexData":139.0,"sn":"2593","deviceName":"西直门"},{"deviceType":1,"alarmCount":"70","regionName":"区域0001","deviceTypeName":"国标站","firstPollution":"PM10","updateTime":"2021-12-28 17:16:02","indexData":192.0,"sn":"2591","deviceName":"昌平"},{"deviceType":2,"alarmCount":"70","regionName":"区域0002","deviceTypeName":"网格站","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":96.0,"sn":"615","deviceName":"怀柔镇"},{"deviceType":2,"alarmCount":"70","regionName":"区域0001","deviceTypeName":"网格站","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":193.0,"sn":"2588","deviceName":"延庆"},{"deviceType":1,"alarmCount":"63","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":95.0,"sn":"612","deviceName":"奥体中心"},{"deviceType":2,"alarmCount":"63","regionName":"区域0002","deviceTypeName":"网格站","firstPollution":"PM2.5","updateTime":"2021-12-28 17:16:03","indexData":99.0,"sn":"616","deviceName":"昌平镇"},{"deviceType":2,"alarmCount":"63","regionName":"区域0002","deviceTypeName":"网格站","firstPollution":"PM2.5","updateTime":"2021-12-28 17:16:03","indexData":94.0,"sn":"614","deviceName":"定陵"},{"deviceType":2,"alarmCount":"63","regionName":"区域0002","deviceTypeName":"网格站","firstPollution":"SO2","updateTime":"2021-12-28 17:16:03","indexData":294.0,"sn":"613","deviceName":"官园"},{"deviceType":2,"alarmCount":"63","regionName":"区域0001","deviceTypeName":"网格站","firstPollution":"PM10","updateTime":"2021-12-28 17:16:02","indexData":138.0,"sn":"2586","deviceName":"密云"},{"deviceType":1,"alarmCount":"63","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"O3","updateTime":"2021-12-28 17:16:03","indexData":98.0,"sn":"2597","deviceName":"香山"},{"deviceType":1,"alarmCount":"63","regionName":"区域0001","deviceTypeName":"国标站","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":197.0,"sn":"2592","deviceName":"永定门"},{"deviceType":1,"alarmCount":"56","regionName":"区域0001","deviceTypeName":"国标站","firstPollution":"NO2","updateTime":"2021-12-28 17:16:02","indexData":149.0,"sn":"2589","deviceName":"怀柔"},{"deviceType":1,"alarmCount":"56","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":141.0,"sn":"609","deviceName":"农展馆"},{"deviceType":2,"alarmCount":"56","regionName":"区域0001","deviceTypeName":"网格站","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":80.0,"sn":"2587","deviceName":"平谷"},{"deviceType":2,"alarmCount":"56","regionName":"区域0001","deviceTypeName":"网格站","firstPollution":"O3","updateTime":"2021-12-28 17:16:02","indexData":87.0,"sn":"2577","deviceName":"前门"},{"deviceType":1,"alarmCount":"56","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":143.0,"sn":"611","deviceName":"天坛"},{"deviceType":3,"alarmCount":"54","regionName":"区域0003","deviceTypeName":"有毒有害气体","updateTime":"2021-12-28 17:20:02","indexData":"[H₂S, NH₃, HCl, Cl₂, COCl₂, VOC]","sn":"300090017","deviceName":"有毒有害05"},{"deviceType":1,"alarmCount":"49","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":275.0,"sn":"610","deviceName":"古城"},{"deviceType":1,"alarmCount":"49","regionName":"区域0002","deviceTypeName":"国标站","firstPollution":"PM10","updateTime":"2021-12-28 17:16:02","indexData":87.0,"sn":"2596","deviceName":"顺义"},{"deviceType":3,"alarmCount":"48","regionName":"区域0003","deviceTypeName":"有毒有害气体","updateTime":"2021-12-28 17:20:03","indexData":"[H₂S, NH₃, HCl, Cl₂, COCl₂, VOC]","sn":"300090018","deviceName":"有毒有害06"},{"deviceType":4,"alarmCount":"45","regionName":"区域0004","deviceTypeName":"恶臭","updateTime":"2021-12-28 17:20:03","indexData":"[NH₃, C₃H₉N, H₂S, CH₄S, C₂H₆S, C₂H₆S₂, CS₂, C₈H₈, OU]","sn":"300090021","deviceName":"恶臭02"},{"deviceType":1,"alarmCount":"42","regionName":"区域0001","deviceTypeName":"国标站","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":34.0,"sn":"2590","deviceName":"房山"},{"deviceType":2,"alarmCount":"42","regionName":"区域0002","deviceTypeName":"网格站","firstPollution":"SO2","updateTime":"2021-12-28 17:16:03","indexData":44.0,"sn":"617","deviceName":"海淀区万柳"},{"deviceType":2,"alarmCount":"42","regionName":"区域0001","deviceTypeName":"网格站","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":87.0,"sn":"2579","deviceName":"南三环"},{"deviceType":3,"alarmCount":"42","regionName":"区域0004","deviceTypeName":"有毒有害气体","updateTime":"2021-12-28 17:20:02","indexData":"[H₂S, NH₃, HCl, Cl₂, COCl₂, VOC]","sn":"300090013","deviceName":"有毒有害01"},{"deviceType":3,"alarmCount":"42","regionName":"区域0004","deviceTypeName":"有毒有害气体","updateTime":"2021-12-28 17:20:02","indexData":"[H₂S, NH₃, HCl, Cl₂, COCl₂, VOC]","sn":"300090014","deviceName":"有毒有害02"},{"deviceType":3,"alarmCount":"42","regionName":"区域0004","deviceTypeName":"有毒有害气体","updateTime":"2021-12-28 17:20:02","indexData":"[H₂S, NH₃, HCl, Cl₂, COCl₂, VOC]","sn":"300090015","deviceName":"有毒有害03"},{"deviceType":3,"alarmCount":"42","regionName":"区域0003","deviceTypeName":"有毒有害气体","updateTime":"2021-12-28 17:20:03","indexData":"[H₂S, NH₃, HCl, Cl₂, COCl₂, VOC]","sn":"300090019","deviceName":"有毒有害07"}]}';
    airsitemodel=AirSiteModel.fromJson(json.decode(jsontext));
    AirSiteList=airsitemodel.data;
    return airsitemodel;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(6, 36, 66, 1),
          title: Text('站点数据',style: TextStyle(
            color: Color.fromRGBO(185, 233, 255, 1),
            fontSize: Adapt.px(32),)),
          centerTitle:true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pop(context);
          }),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [ Color.fromRGBO(6, 36, 66, 1),Color.fromRGBO(16, 56, 95, 1),Color.fromRGBO(1, 20, 43, 1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0,0.5,1],
              )
          ),
          padding: EdgeInsets.only(left: Adapt.px(32),right: Adapt.px(32)),
          child: Column(
            children: [
              SizedBox(height: Adapt.px(8),),
              Row(children: [
                SizedBox(
                  width: Adapt.px(542),
                  height: Adapt.px(70),
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
                      fillColor: const Color.fromRGBO(185, 233, 255, 0.05),//背景色
                      filled: true,//重点，必须设置为true，fillColor才有效
                      isCollapsed: true,//重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                      contentPadding: const EdgeInsets.all(12),//内容内边距，影响高度
                      hintText: '搜索站点名称',


                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(185, 233, 255, 1),
                        fontSize: 12,
                      ),

                    ),
                  ),
                ),
                SizedBox(width: Adapt.px(24),),
                InkWell(child: Container(
                  width: Adapt.px(120),
                  height: Adapt.px(70),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(46, 228, 149, 1),
                    borderRadius: BorderRadius.circular(Adapt.px(35)),
                  ),
                  alignment: Alignment.center,
                  child:  Text('搜索',style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(28)),),
                ),onTap: (){
                  setState(() {
                    if(_unameController.text!=''){if(lishiList.length<10){lishiList.add(_unameController.text);}
                    else{lishiList.add(_unameController.text);lishiList.removeAt(0);}
                    myMethod2(lishiList);
                    print(lishiList.length);}

                  });
                }
                )
              ],),
              Expanded(child: FutureBuilder(future: alarmRealTimedGet(),
                  builder: (BuildContext context, AsyncSnapshot<AirSiteModel> snapshot){
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return  const Text('网络连接失败');
                      case ConnectionState.waiting:
                        return  const Center(child: CircularProgressIndicator());
                      case  ConnectionState.active:
                        return const Text('');
                      case ConnectionState.done:
                        if(snapshot.hasError){
                          return Text(
                            '${snapshot.error}',
                            style: const TextStyle(color: Colors.red),
                          );
                        }else{
                          if(_unameController.text==''||_unameController.text==null){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: Adapt.px(32),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('历史搜索',
                                      style:  TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(32)),
                                    ),
                                    InkWell(child: Image(image: const AssetImage('images/laji.png'),width: Adapt.px(28),height: Adapt.px(28),),onTap: (){
                                      setState(() {
                                        myMethodremove();
                                        lishiList.clear();
                                      });
                                    },),
                                  ],),
                                Wrap(
                                  spacing:Adapt.px(16),
                                  runAlignment : WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,//run的对齐方式。run可以理解为新的行或者列，如果是水平方向布局的话，run可以理解为新的一行。
                                  runSpacing : Adapt.px(24),//run的间距。
                                  children: wateritems(lishiList),
                                ),



                              ],);

                          }else{if(AirSiteList.isEmpty){
                            return Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: const AssetImage('images/nulldata.png'), width: Adapt.px(80), height: Adapt.px(80),),
                                Text('抱歉！暂无数据', style: TextStyle(
                                    color:  Color.fromRGBO(185, 233, 255, 0.45),
                                    fontSize: Adapt.px(32)),
                                ),
                              ],
                            ),);
                          }else{
                            sousuoSiteList.clear();
                            for(int i=0;i<AirSiteList.length;i++){
                              if(AirSiteList[i].deviceName!.contains(_unameController.text)){
                                sousuoSiteList.add(AirSiteList[i]);
                              }
                            }
                            if(sousuoSiteList.isEmpty){
                              return Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(image: const AssetImage('images/nulldata.png'), width: Adapt.px(80), height: Adapt.px(80),),
                                  Text('抱歉！暂无数据', style: TextStyle(
                                      color:  Color.fromRGBO(185, 233, 255, 0.45),
                                      fontSize: Adapt.px(32)),
                                  ),
                                ],
                              ),);
                            }else{
                            return ListView.separated(
                                itemCount: sousuoSiteList.length,//个数
                                // scrollDirection: Axis.vertical,//滑动方向
                                primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                                //内容适配
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),//禁止滚动
                                padding: const EdgeInsets.only(top: 12,bottom: 12),
                                separatorBuilder: (BuildContext context, int index) =>
                                    Container(
                                      height: Adapt.px(24),
                                      color: Colors.transparent,
                                    ),
                                itemBuilder:(BuildContext context,int index){
                                  return getAlarmListViewItem(sousuoSiteList[index], context);
                                });}
                          }}


                        }
                    }
                  }
              ),),


              //列表页

            ],
          ),

        )
    );
  }
  List<Widget> wateritems(List<String> lishiList){
    List<Widget> lis=[];
    for(int i=0;i<lishiList.length;i++){
      lis.add(InkWell(child: Container(

        padding: const EdgeInsets.all(5),

        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(Adapt.px(28)),
          color: const Color.fromRGBO(185, 233, 255, 0.05),
        ),

        child:  Text(lishiList[i],style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),

      ),onTap: (){
        setState(() {
          _unameController.text=lishiList[i];
        });

      },));

    }
    return lis;
  }
}
Widget getAlarmListViewItem(AirSiteData airsitedata,BuildContext context) {
  if(airsitedata.deviceType==2 || airsitedata.deviceType==1){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AirSiteDetails(airsitedata.sn!)));
      },
      child: Container(
        width: Adapt.px(686),
        height: Adapt.px(400),
        decoration:  BoxDecoration(
            color: const Color.fromRGBO(185, 233, 255, 0.05),
            borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
        ),
        child: Column(
          children: [
            SizedBox(height: Adapt.px(32),),
            Row(
              children: [
                SizedBox(width:Adapt.px(32)),
                imageItem(airsitedata),
                SizedBox(width:Adapt.px(25)),
                Text(airsitedata.deviceName??'-'.toString(), style: TextStyle(
                    color:  const Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(32)),
                ),
              ],
            ),
            SizedBox(height: Adapt.px(40),),
            Row(
              children: [
                SizedBox(width:Adapt.px(32)),
                Container(
                  width: Adapt.px(191),
                  height: Adapt.px(104),
                  decoration:  BoxDecoration(
                      color: Color.fromRGBO(185, 233, 255, 0.05),
                      borderRadius: BorderRadius.all(Radius.circular(Adapt.px(8)))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:Adapt.px(8)),
                      Text(airsitedata.indexData??'-'.toString(), style: TextStyle(
                          color:  Color.fromRGBO(255, 255, 255, 1),
                          fontSize: Adapt.px(32)),
                      ),
                      SizedBox(height:Adapt.px(4)),
                      Container(
                        alignment: Alignment.center,
                        height: Adapt.px(36),
                        child:Text('AQI', style: TextStyle(
                            color:  Color.fromRGBO(185, 233, 255, 1),
                            fontSize: Adapt.px(24)),),

                      ),
                    ],
                  ),
                ),
                SizedBox(width:Adapt.px(24)),
                Container(
                  width: Adapt.px(191),
                  height: Adapt.px(104),
                  decoration:  BoxDecoration(
                      color: Color.fromRGBO(185, 233, 255, 0.05),
                      borderRadius: BorderRadius.all(Radius.circular(Adapt.px(8)))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:Adapt.px(8)),
                      Text(airsitedata.firstPollution??'-'.toString(), style: TextStyle(
                          color:  Color.fromRGBO(255, 255, 255, 1),
                          fontSize: Adapt.px(32)),
                      ),
                      SizedBox(height:Adapt.px(4)),
                      Text('首要污染物', style: TextStyle(
                          color:  Color.fromRGBO(185, 233, 255, 1),
                          fontSize: Adapt.px(24)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width:Adapt.px(24)),
                Container(
                  width: Adapt.px(191),
                  height: Adapt.px(104),
                  decoration:  BoxDecoration(
                      color: Color.fromRGBO(185, 233, 255, 0.05),
                      borderRadius: BorderRadius.all(Radius.circular(Adapt.px(8)))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:Adapt.px(8)),
                      Text(airsitedata.alarmCount??'-'.toString(), style: TextStyle(
                          color:  Color.fromRGBO(255, 255, 255, 1),
                          fontSize: Adapt.px(32)),
                      ),
                      SizedBox(height:Adapt.px(4)),
                      Text('当日报警次数', style: TextStyle(
                          color:  Color.fromRGBO(185, 233, 255, 1),
                          fontSize: Adapt.px(24)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Adapt.px(32),),
            Row(
              children: [
                SizedBox(width:Adapt.px(32)),
                Text('站点类型：', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(airsitedata.deviceTypeName??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                SizedBox(width:Adapt.px(118)),
                Text('所属区域：', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(airsitedata.regionName??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),

              ],
            ),
            SizedBox(height: Adapt.px(24),),
            Row(
              children: [
                SizedBox(width:Adapt.px(32)),
                Text('更新时间：', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(airsitedata.updateTime??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),

              ],
            ),
          ],
        ),
      ) ,
    );
  }else{
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AirSiteDetails(airsitedata.sn!)));
      },
      child: Container(
        width: Adapt.px(686),
        height: Adapt.px(400),
        decoration:  BoxDecoration(
            color: const Color.fromRGBO(185, 233, 255, 0.05),
            borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
        ),

        child: Column(
          children: [
            SizedBox(height: Adapt.px(32),),
            Row(
              children: [
                SizedBox(width:Adapt.px(32)),
                imageItem(airsitedata),
                SizedBox(width:Adapt.px(25)),
                Text(airsitedata.deviceName??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(32)),
                ),
              ],
            ),
            SizedBox(height: Adapt.px(40),),
            Row(
              children: [
                SizedBox(width:Adapt.px(32)),
                Container(
                  width: Adapt.px(407),
                  height: Adapt.px(104),
                  decoration:  BoxDecoration(
                      color: Color.fromRGBO(185, 233, 255, 0.05),
                      borderRadius: BorderRadius.all(Radius.circular(Adapt.px(8)))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:Adapt.px(8)),
                      Text(airsitedata.indexData??'-'.toString(), style: TextStyle(
                        color:  Color.fromRGBO(255, 255, 255, 1),
                        fontSize: Adapt.px(32),),
                        maxLines: 1,overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height:Adapt.px(4)),
                      Text('监测指标', style: TextStyle(
                          color:  Color.fromRGBO(185, 233, 255, 1),
                          fontSize: Adapt.px(24)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width:Adapt.px(24)),
                Container(
                  width: Adapt.px(191),
                  height: Adapt.px(104),
                  decoration:  BoxDecoration(
                      color: Color.fromRGBO(185, 233, 255, 0.05),
                      borderRadius: BorderRadius.all(Radius.circular(Adapt.px(8)))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:Adapt.px(8)),
                      Text(airsitedata.alarmCount??'-'.toString(), style: TextStyle(
                          color:  Color.fromRGBO(255, 255, 255, 1),
                          fontSize: Adapt.px(32)),
                      ),
                      SizedBox(height:Adapt.px(4)),
                      Text('当日报警次数', style: TextStyle(
                          color:  Color.fromRGBO(185, 233, 255, 1),
                          fontSize: Adapt.px(24)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Adapt.px(32),),
            Row(
              children: [
                SizedBox(width:Adapt.px(32)),
                Text('站点类型：', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(airsitedata.deviceTypeName??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                SizedBox(width:Adapt.px(118)),
                Text('所属区域：', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(airsitedata.regionName??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),

              ],
            ),
            SizedBox(height: Adapt.px(24),),
            Row(
              children: [
                SizedBox(width:Adapt.px(32)),
                Text('更新时间：', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(airsitedata.updateTime??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),

              ],
            ),
          ],
        ),
        // 下边框
        // decoration: const BoxDecoration(
        //     border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 0.1)))
        // ),
      ),
    );

  }

}

Image imageItem(AirSiteData airsitedata) {
  if(airsitedata.deviceType==4){
    return Image(
      image: const AssetImage('images/siteechou.png'), width: Adapt.px(28), height: Adapt.px(28),);
  }else if(airsitedata.deviceType==3){
    return Image(
      image: const AssetImage('images/siteyouduyouhai.png'), width: Adapt.px(28), height: Adapt.px(28),);
  }else if(airsitedata.deviceType==2){
    return Image(
      image: const AssetImage('images/sitewangge.png'), width: Adapt.px(28), height: Adapt.px(28),);
  }else {
    return Image(
      image: const AssetImage('images/siteguobiao.png'), width: Adapt.px(28), height: Adapt.px(28),);
  }
}

