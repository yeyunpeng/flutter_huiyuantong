import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'air_site_details.dart';
import 'chaxun/air_chaxun_page.dart';
class AirSite extends StatefulWidget{
  const AirSite({Key? key}) : super(key: key);
  @override
  _AirSiteState createState()=>_AirSiteState();
}
class _AirSiteState extends State<AirSite>{
  final GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();
  final List<SortCondition> _areasList = [];
  final List<SortCondition> _typesList = [];
  late SortCondition _selectBrandSortCondition;
  late SortCondition _selectDistanceSortCondition;
  var airsitemodel;

  late List<AirSiteData> AirSiteList ;
    String ? typecheckitem;
  String ? areacheckitem;
  String  devType='-1';
  String  regionId='-1';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _typesList.add(SortCondition(name: '全部站点',devType: '-1', isSelected: false));
      _areasList.add(SortCondition(name: '全部区域',devType: '-1', isSelected: false));
    });

    _typeDownPost();
    _areaDownGet();


  }
  //类型下拉数据
  Future<void> _typeDownPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('http://39.105.58.216:13001/api/devicetype/findAllPollutantType');
    // var result=await http.post(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //  );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"","code":200,"data":[{"id":1,"name":"国标站","delStatus":0,"data":null,"busiParkId":1},{"id":2,"name":"网格站","delStatus":0,"data":null,"busiParkId":1},{"id":3,"name":"有毒有害气体","delStatus":0,"data":null,"busiParkId":1},{"id":4,"name":"恶臭","delStatus":0,"data":null,"busiParkId":1}]}';
    Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(text));
    print(data['data'].toList());
    List<dynamic> list=data['data'].toList();
setState(() {
  for(int i=0;i<list.length;i++){
    _typesList.add(SortCondition(name: list[i]['name'].toString(),devType: list[i]['id'].toString(), isSelected: false));
  }
});







  }
  //类型下拉数据
  Future<void> _areaDownGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('http://39.105.58.216:13001/api/region/findAllRegionName');
    // var result=await http.get(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    // );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"区域0001","longitude":"123.416","latitude":"124.432","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0},{"id":2,"name":"区域0002","longitude":"123.426","latitude":"124.432","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0},{"id":3,"name":"区域0003","longitude":"123.436","latitude":"124.432","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0},{"id":4,"name":"区域0004","longitude":"123.446","latitude":"124.432","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0}]}';
    Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(text));
    print(data['data'].toList());
    List<dynamic> list=data['data'].toList();
    setState(() {
      for(int i=0;i<list.length;i++){
        _areasList.add(SortCondition(name: list[i]['name'].toString(),devType: list[i]['id'].toString(), isSelected: false));
      }
    });







  }
  Future<AirSiteModel> alarmRealTimedGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('http://39.105.58.216:13001/api/countryDataDay/appQryStationType');
    // var result=await http.post(url,headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //     body: jsonEncode({'devType':devType,'regionId':regionId}));
    // Utf8Decoder utf8decoder = const Utf8Decoder();
   // print(json.decode(utf8decoder.convert(result.bodyBytes)));
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
       actions: [
         IconButton(icon: const Icon(Icons.search),color: const Color.fromRGBO(185, 233, 255, 1), onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> AirChaXunPage()));
         }),
       ],
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
            Expanded(child: Stack(
              key: _stackKey,
              children: [
                Column(
                  children: [
                    Container(

                      child: GZXDropDownHeader(
                        items: [
                          GZXDropDownHeaderItem(
                            typecheckitem??"全部站点",
                          style: TextStyle(color: Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28)),
                          iconData: Icons.keyboard_arrow_down_sharp,
                          iconDropDownData: Icons.keyboard_arrow_up_sharp,
                        ),
                          GZXDropDownHeaderItem(
                            areacheckitem??"全部区域",
                            style: TextStyle(color: Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28)),
                            iconData: Icons.keyboard_arrow_down_sharp,
                            iconDropDownData: Icons.keyboard_arrow_up_sharp,
                          ),
                        ],
                        controller: _dropdownMenuController,
                        stackKey: _stackKey,
                        // 头部的高度
                        height: Adapt.px(70),
//                         // 头部背景颜色
                         color: Color.fromRGBO(185, 233, 255, 0.3),
//                         // 头部边框宽度
                        borderWidth: 0,
                        // 头部边框颜色
                        borderColor:Color.fromRGBO(185, 233, 255, 0),
//                         // 分割线高度
                         dividerHeight: Adapt.px(88),
//                         // 分割线颜色
                        dividerColor: Color.fromRGBO(185, 233, 255, 0),
                        style: TextStyle(color:Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(28)),
//                // 下拉时文字样式
                        dropDownStyle: TextStyle(
                          fontSize: Adapt.px(28),
                          color: Color.fromRGBO(185, 233, 255, 1),
                        ),
                        // 文字样式

                      ),),
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
                                if(AirSiteList.isEmpty){
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
                                      itemCount: AirSiteList.length,//个数
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
                                        return getAlarmListViewItem(AirSiteList[index], context);
                                      });
                                }

                              }
                          }
                        }
                    ),),
                  ],
                ),

                GZXDropDownMenu(
                  // controller用于控制menu的显示或隐藏
                  controller: _dropdownMenuController,
                  // 下拉菜单显示或隐藏动画时长
                  animationMilliseconds: 300,
                  // 下拉后遮罩颜色
                  maskColor: Colors.transparent,
                  // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
                  menus: [
                    GZXDropdownMenuBuilder(
                        dropDownHeight: Adapt.px(88) * _typesList.length,
                        dropDownWidget: _buildConditionListWidget(_typesList, (value) {
                          _selectDistanceSortCondition = value;
                          typecheckitem = _selectDistanceSortCondition.name;
                          _dropdownMenuController.hide();
                           setState(() {
                             print(value.name);
                             devType=value.devType;});
                        })),
                    GZXDropdownMenuBuilder(
                        dropDownHeight: Adapt.px(88) * _areasList.length,
                        dropDownWidget: _buildConditionListWidget(_areasList, (value) {
                          _selectBrandSortCondition = value;
                          areacheckitem = _selectBrandSortCondition.name;
                          _dropdownMenuController.hide();
                          setState(() {
                            print(value.name);
                            regionId=value.devType;});
                        })),
                  ],
                ),

              ],
            ),),


            //列表页

          ],
        ),

        // Column(
        //   children: [
        //     SizedBox(height: Adapt.px(8),),
        //     Row(children: [
        //
        //       Container(
        //         width:  Adapt.px(327),
        //         height:  Adapt.px(70),
        //         decoration: BoxDecoration(
        //           border: Border.all(color: Color.fromRGBO(185, 233, 255, 0.05),width: 0),
        //           borderRadius: BorderRadius.circular(Adapt.px(24)),
        //           color: Color.fromRGBO(185, 233, 255, 0.05),
        //
        //         ),
        //         child:
        //         DropdownButton<String>(
        //           isExpanded: true,
        //           isDense: false,
        //           hint: Container(
        //             padding: EdgeInsets.only(left: Adapt.px(24)),
        //             child: Text('站点数据',style: TextStyle(
        //             color: Color.fromRGBO(185, 233, 255, 1),
        //             fontSize: Adapt.px(28),)),),
        //           underline: Container(height: 0),
        //
        //           items: <String>['A', 'B', 'C', 'D'].map((String value) {
        //             return new DropdownMenuItem<String>(
        //
        //               value: value,
        //               child: new Text(value),
        //             );
        //           }).toList(),
        //           onChanged: (_) {},
        //         ),
        //       ),
        //
        //     ],),
        //     SizedBox(height: Adapt.px(24),),
        //     // ListView.builder(
        //     //     itemBuilder: (BuildContext context,int index){
        //     //   return getSiteListViewItem(AlarmList[index]);},
        //     //   itemCount: 10,//个数
        //     //   itemExtent: Adapt.px(284),
        //     //
        //     // )
        //   ],
        // ),

      )
   );
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=> AirSiteDetails('300090024')));
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
class SortCondition {
  String name;
  String devType;

  bool isSelected;

  SortCondition({
    required this.name,
    required this.devType,
    required this.isSelected,
  });
}
_buildConditionListWidget(items, void itemOnTap(SortCondition sortCondition)) {
  return Container(
    color: const Color.fromRGBO(6, 36, 66, 1),
    child: ListView.separated(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: items.length,
    // item 的个数
    separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
    // 添加分割线
    itemBuilder: (BuildContext context, int index) {
      return gestureDetector(items, index, itemOnTap, context);
    },
  ),);

}
GestureDetector gestureDetector(items, int index, void itemOnTap(SortCondition sortCondition), BuildContext context) {
  SortCondition goodsSortCondition = items[index];
  return GestureDetector(
    onTap: () {
      for (var value in items) {
        value.isSelected = false;
      }
      goodsSortCondition.isSelected = true;

      itemOnTap(goodsSortCondition);
    },
    child: Container(
      color: Color.fromRGBO(6, 36, 66, 1),
      height: 40,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Text(
              goodsSortCondition.name,
              style: TextStyle(
                color: goodsSortCondition.isSelected ? const Color.fromRGBO(46, 228, 149, 1): const Color.fromRGBO(184, 233, 255, 0.75),
              ),
            ),
          ),
          goodsSortCondition.isSelected
              ? Icon(
            Icons.check,
            color: const Color.fromRGBO(46, 228, 149, 1),
            size: Adapt.px(32),
          )
              : SizedBox(),

        ],
      ),
    ),
  );
}