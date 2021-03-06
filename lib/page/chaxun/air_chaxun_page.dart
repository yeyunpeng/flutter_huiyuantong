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
    String jsontext='{"msg":"success","code":200,"data":[{"deviceType":4,"alarmCount":"99","regionName":"??????0003","deviceTypeName":"??????","updateTime":"2021-12-28 17:20:04","indexData":"[NH???, C???H???N, H???S, CH???S, C???H???S, C???H???S???, CS???, C???H???, OU]","sn":"300090024","deviceName":"??????04"},{"deviceType":2,"alarmCount":"91","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"SO2","updateTime":"2021-12-28 17:16:02","indexData":280.0,"sn":"2581","deviceName":"??????"},{"deviceType":1,"alarmCount":"91","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"NO2","updateTime":"2021-12-28 17:16:03","indexData":195.0,"sn":"608","deviceName":"??????"},{"deviceType":2,"alarmCount":"91","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"PM2.5","updateTime":"2021-12-28 17:16:03","indexData":144.0,"sn":"618","deviceName":"????????????"},{"deviceType":4,"alarmCount":"90","regionName":"??????0004","deviceTypeName":"??????","updateTime":"2021-12-28 17:20:03","indexData":"[NH???, C???H???N, H???S, CH???S, C???H???S, C???H???S???, CS???, C???H???, OU]","sn":"300090020","deviceName":"??????01"},{"deviceType":4,"alarmCount":"90","regionName":"??????0004","deviceTypeName":"??????","updateTime":"2021-12-28 17:20:03","indexData":"[NH???, C???H???N, H???S, CH???S, C???H???S, C???H???S???, CS???, C???H???, OU]","sn":"300090023","deviceName":"??????03"},{"deviceType":1,"alarmCount":"84","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":148.0,"sn":"2595","deviceName":"?????????"},{"deviceType":4,"alarmCount":"81","regionName":"??????0003","deviceTypeName":"??????","updateTime":"2021-12-28 17:20:04","indexData":"[NH???, C???H???N, H???S, CH???S, C???H???S, C???H???S???, CS???, C???H???, OU]","sn":"300090025","deviceName":"??????05"},{"deviceType":2,"alarmCount":"77","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"SO2","updateTime":"2021-12-28 17:16:02","indexData":100.0,"sn":"2578","deviceName":"????????????"},{"deviceType":2,"alarmCount":"77","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":195.0,"sn":"2574","deviceName":"?????????"},{"deviceType":1,"alarmCount":"77","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"PM10","updateTime":"2021-12-28 17:16:02","indexData":134.0,"sn":"2594","deviceName":"??????"},{"deviceType":1,"alarmCount":"77","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"NO2","updateTime":"2021-12-28 17:16:03","indexData":41.0,"sn":"607","deviceName":"????????????"},{"deviceType":1,"alarmCount":"77","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"O3","updateTime":"2021-12-28 17:16:02","indexData":139.0,"sn":"2593","deviceName":"?????????"},{"deviceType":1,"alarmCount":"70","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"PM10","updateTime":"2021-12-28 17:16:02","indexData":192.0,"sn":"2591","deviceName":"??????"},{"deviceType":2,"alarmCount":"70","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":96.0,"sn":"615","deviceName":"?????????"},{"deviceType":2,"alarmCount":"70","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":193.0,"sn":"2588","deviceName":"??????"},{"deviceType":1,"alarmCount":"63","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":95.0,"sn":"612","deviceName":"????????????"},{"deviceType":2,"alarmCount":"63","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"PM2.5","updateTime":"2021-12-28 17:16:03","indexData":99.0,"sn":"616","deviceName":"?????????"},{"deviceType":2,"alarmCount":"63","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"PM2.5","updateTime":"2021-12-28 17:16:03","indexData":94.0,"sn":"614","deviceName":"??????"},{"deviceType":2,"alarmCount":"63","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"SO2","updateTime":"2021-12-28 17:16:03","indexData":294.0,"sn":"613","deviceName":"??????"},{"deviceType":2,"alarmCount":"63","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"PM10","updateTime":"2021-12-28 17:16:02","indexData":138.0,"sn":"2586","deviceName":"??????"},{"deviceType":1,"alarmCount":"63","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"O3","updateTime":"2021-12-28 17:16:03","indexData":98.0,"sn":"2597","deviceName":"??????"},{"deviceType":1,"alarmCount":"63","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":197.0,"sn":"2592","deviceName":"?????????"},{"deviceType":1,"alarmCount":"56","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"NO2","updateTime":"2021-12-28 17:16:02","indexData":149.0,"sn":"2589","deviceName":"??????"},{"deviceType":1,"alarmCount":"56","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":141.0,"sn":"609","deviceName":"?????????"},{"deviceType":2,"alarmCount":"56","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":80.0,"sn":"2587","deviceName":"??????"},{"deviceType":2,"alarmCount":"56","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"O3","updateTime":"2021-12-28 17:16:02","indexData":87.0,"sn":"2577","deviceName":"??????"},{"deviceType":1,"alarmCount":"56","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":143.0,"sn":"611","deviceName":"??????"},{"deviceType":3,"alarmCount":"54","regionName":"??????0003","deviceTypeName":"??????????????????","updateTime":"2021-12-28 17:20:02","indexData":"[H???S, NH???, HCl, Cl???, COCl???, VOC]","sn":"300090017","deviceName":"????????????05"},{"deviceType":1,"alarmCount":"49","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:03","indexData":275.0,"sn":"610","deviceName":"??????"},{"deviceType":1,"alarmCount":"49","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"PM10","updateTime":"2021-12-28 17:16:02","indexData":87.0,"sn":"2596","deviceName":"??????"},{"deviceType":3,"alarmCount":"48","regionName":"??????0003","deviceTypeName":"??????????????????","updateTime":"2021-12-28 17:20:03","indexData":"[H???S, NH???, HCl, Cl???, COCl???, VOC]","sn":"300090018","deviceName":"????????????06"},{"deviceType":4,"alarmCount":"45","regionName":"??????0004","deviceTypeName":"??????","updateTime":"2021-12-28 17:20:03","indexData":"[NH???, C???H???N, H???S, CH???S, C???H???S, C???H???S???, CS???, C???H???, OU]","sn":"300090021","deviceName":"??????02"},{"deviceType":1,"alarmCount":"42","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":34.0,"sn":"2590","deviceName":"??????"},{"deviceType":2,"alarmCount":"42","regionName":"??????0002","deviceTypeName":"?????????","firstPollution":"SO2","updateTime":"2021-12-28 17:16:03","indexData":44.0,"sn":"617","deviceName":"???????????????"},{"deviceType":2,"alarmCount":"42","regionName":"??????0001","deviceTypeName":"?????????","firstPollution":"CO","updateTime":"2021-12-28 17:16:02","indexData":87.0,"sn":"2579","deviceName":"?????????"},{"deviceType":3,"alarmCount":"42","regionName":"??????0004","deviceTypeName":"??????????????????","updateTime":"2021-12-28 17:20:02","indexData":"[H???S, NH???, HCl, Cl???, COCl???, VOC]","sn":"300090013","deviceName":"????????????01"},{"deviceType":3,"alarmCount":"42","regionName":"??????0004","deviceTypeName":"??????????????????","updateTime":"2021-12-28 17:20:02","indexData":"[H???S, NH???, HCl, Cl???, COCl???, VOC]","sn":"300090014","deviceName":"????????????02"},{"deviceType":3,"alarmCount":"42","regionName":"??????0004","deviceTypeName":"??????????????????","updateTime":"2021-12-28 17:20:02","indexData":"[H???S, NH???, HCl, Cl???, COCl???, VOC]","sn":"300090015","deviceName":"????????????03"},{"deviceType":3,"alarmCount":"42","regionName":"??????0003","deviceTypeName":"??????????????????","updateTime":"2021-12-28 17:20:03","indexData":"[H???S, NH???, HCl, Cl???, COCl???, VOC]","sn":"300090019","deviceName":"????????????07"}]}';
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
          title: Text('????????????',style: TextStyle(
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
                      fillColor: const Color.fromRGBO(185, 233, 255, 0.05),//?????????
                      filled: true,//????????????????????????true???fillColor?????????
                      isCollapsed: true,//?????????????????????????????????????????????????????????true???????????????????????????????????????
                      contentPadding: const EdgeInsets.all(12),//??????????????????????????????
                      hintText: '??????????????????',


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
                  child:  Text('??????',style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(28)),),
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
                        return  const Text('??????????????????');
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
                                    Text('????????????',
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
                                  crossAxisAlignment: WrapCrossAlignment.start,//run??????????????????run????????????????????????????????????????????????????????????????????????run??????????????????????????????
                                  runSpacing : Adapt.px(24),//run????????????
                                  children: wateritems(lishiList),
                                ),



                              ],);

                          }else{if(AirSiteList.isEmpty){
                            return Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image: const AssetImage('images/nulldata.png'), width: Adapt.px(80), height: Adapt.px(80),),
                                Text('?????????????????????', style: TextStyle(
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
                                  Text('?????????????????????', style: TextStyle(
                                      color:  Color.fromRGBO(185, 233, 255, 0.45),
                                      fontSize: Adapt.px(32)),
                                  ),
                                ],
                              ),);
                            }else{
                            return ListView.separated(
                                itemCount: sousuoSiteList.length,//??????
                                // scrollDirection: Axis.vertical,//????????????
                                primary: false,//false????????????????????????????????????????????? ?????????[primary]???true????????????????????????????????????
                                //????????????
                                shrinkWrap: true,
                                //physics: const NeverScrollableScrollPhysics(),//????????????
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


              //?????????

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
                      Text('???????????????', style: TextStyle(
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
                      Text('??????????????????', style: TextStyle(
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
                Text('???????????????', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(airsitedata.deviceTypeName??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                SizedBox(width:Adapt.px(118)),
                Text('???????????????', style: TextStyle(
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
                Text('???????????????', style: TextStyle(
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
                      Text('????????????', style: TextStyle(
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
                      Text('??????????????????', style: TextStyle(
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
                Text('???????????????', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(airsitedata.deviceTypeName??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                SizedBox(width:Adapt.px(118)),
                Text('???????????????', style: TextStyle(
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
                Text('???????????????', style: TextStyle(
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
        // ?????????
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

