import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_huiyuantong/model/airsite_details_model.dart';
import 'package:flutter_huiyuantong/model/baojing/air_index_model.dart';
import 'package:flutter_huiyuantong/model/baojing/water_index.dart';
import 'package:flutter_huiyuantong/model/map/location_model.dart';
import 'package:flutter_huiyuantong/model/map/map_daqi_model.dart';
import 'package:flutter_huiyuantong/model/map/map_pollution_model.dart';
import 'package:flutter_huiyuantong/model/map/map_water_model.dart';
import 'package:flutter_huiyuantong/model/pollution_outlet_details_model.dart';
import 'package:flutter_huiyuantong/model/water_section_details_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:flutter_huiyuantong/util/poprote.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'map/const_config.dart';
import 'package:http/http.dart' as http;

import 'map/dropdown/dropdown_map_air.dart';
import 'map/dropdown/dropdown_map_pollution.dart';
import 'map/dropdown/dropdown_map_water.dart';

class MapPage extends StatefulWidget{
  @override
  _MapPageState createState()=>_MapPageState();
}
class _MapPageState extends State<MapPage>with SingleTickerProviderStateMixin{
  bool _isShow=true;
  late LocationModel locationModel;
  var firstlatitude= 39.828809;
  var firstlongitude= 116.360364;
  bool _daqibiaoshi=true;
  bool _waterbiaoshi=false;
  bool _wuranbiaoshi=false;
  TextStyle textStyle2 = TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28));
  TextStyle textStyle1 = TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(28));
  BoxDecoration boxDecoration2 =BoxDecoration(
      borderRadius: BorderRadius.circular(Adapt.px(12)),
      color:  Colors.transparent
  );
  BoxDecoration boxDecoration1 =BoxDecoration(
      borderRadius: BorderRadius.circular(Adapt.px(28)),
      color: const Color.fromRGBO(46, 228, 149, 1)
  );
  //地图

   CustomStyleOptions _customStyleOptions = CustomStyleOptions(false);
  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  //定位监听
  late StreamSubscription<Map<String, Object>> _locationListener;
  //定位结果
  Map<String, Object> _locationResult = {};
  //地图控制器
  var _mapController;
  //区域范围
  Map<String, Polygon> _polygons = <String, Polygon>{};
  //点标记
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};
  var widgetsBinding;
  //大气选择选项
  var leixing='1';
  var kpi='aqi';
  late MapDaQiModel mapDaQiModel;
  late List<MapDaQi> mapDaQiList;
  //水质地图选择选项
  var indexId='-1';
  late MapWaterModel mapWaterModel;
  late List<MapWaterAllData> mapWaterList;
  //污染选择选项
  late MapPollutionModel mapPollutionModel;
  late List<MapPollution> mapPollutionList;
  //大气筛选选择数据
  late AirIndexModel airIndexModel;
  List<AirIndexData> airIndexList=[];
  //水质筛选选择数据
  late WaterIndexModel waterIndexModel;
  List<IndexData> waterIndexList =[];
  @override
  void initState(){

    super.initState();
    _chushiquanxian();
    locationPost();
    daqiPost();
    _loadCustomData();
    _waterIndexGet();
     _indexGet1('1');

  }
  //大气请求
  late String airimagepath1;
  late String airimagepath2;
  List<bool> airimagebool=[];
  void daqiPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/airQuality/getRankList?devType=$leixing&kpi=$kpi&sort=false');
    // var result=await http.get(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    //
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    //  print('${HttpUtil.url}/api/airQuality/getRankList?devType=$leixing&kpi=$kpi&sort=false');
String text='{"msg":"success","code":200,"data":[{"value":299.0,"valueCompare":null,"name":"农展馆","grade":"重度","level":5,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"609","devLongitude":"116.225183","devLatitude":"39.773337","status":null,"devStatus":5,"devType":1,"kpiName":null},{"value":291.0,"valueCompare":null,"name":"通州","grade":"重度","level":5,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2594","devLongitude":"116.132621","devLatitude":"39.845613","status":null,"devStatus":5,"devType":1,"kpiName":null},{"value":194.0,"valueCompare":null,"name":"永定门","grade":"中度","level":4,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2592","devLongitude":"116.256228","devLatitude":"39.867768","status":null,"devStatus":4,"devType":1,"kpiName":null},{"value":190.0,"valueCompare":null,"name":"房山","grade":"中度","level":4,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2590","devLongitude":"116.220008","devLatitude":"39.892131","status":null,"devStatus":4,"devType":1,"kpiName":null},{"value":148.0,"valueCompare":null,"name":"西直门","grade":"轻度","level":3,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2593","devLongitude":"116.163667","devLatitude":"39.862895","status":null,"devStatus":3,"devType":1,"kpiName":null},{"value":147.0,"valueCompare":null,"name":"东四","grade":"轻度","level":3,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"608","devLongitude":"116.053283","devLatitude":"39.779104","status":null,"devStatus":3,"devType":1,"kpiName":null},{"value":142.0,"valueCompare":null,"name":"昌平","grade":"轻度","level":3,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2591","devLongitude":"116.111924","devLatitude":"39.918698","status":null,"devStatus":3,"devType":1,"kpiName":null},{"value":136.0,"valueCompare":null,"name":"天坛","grade":"轻度","level":3,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"611","devLongitude":"116.31142","devLatitude":"39.840295","status":null,"devStatus":3,"devType":1,"kpiName":null},{"value":96.0,"valueCompare":null,"name":"门头沟","grade":"良","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2595","devLongitude":"116.24358","devLatitude":"39.835419","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":95.0,"valueCompare":null,"name":"怀柔","grade":"良","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2589","devLongitude":"116.152743","devLatitude":"39.90143","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":90.0,"valueCompare":null,"name":"奥体中心","grade":"良","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"612","devLongitude":"116.282674","devLatitude":"39.854919","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":87.0,"valueCompare":null,"name":"古城","grade":"良","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"610","devLongitude":"116.080879","devLatitude":"39.808376","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":82.0,"valueCompare":null,"name":"顺义","grade":"良","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2596","devLongitude":"116.103875","devLatitude":"39.846499","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":null,"valueCompare":null,"name":"香山","grade":"离线","level":0,"sort":null,"time":null,"dataTime":null,"data":null,"sn":"2597","devLongitude":"116.239555","devLatitude":"39.834089","status":null,"devStatus":0,"devType":1,"kpiName":null},{"value":null,"valueCompare":null,"name":"万寿西宫","grade":"离线","level":0,"sort":null,"time":null,"dataTime":null,"data":null,"sn":"607","devLongitude":"116.161942","devLatitude":"39.762244","status":null,"devStatus":0,"devType":1,"kpiName":null}]}';
    mapDaQiModel=MapDaQiModel.fromJson(json.decode(text));
    mapDaQiList=mapDaQiModel.data;
    _initMarkerMap.clear();
    airimagebool.clear();
    for(int i=0;i<mapDaQiList.length;i++){
      airimagebool.add(false);}
setState(() {
  daqimapMaker(mapDaQiList);

});
  }
  void daqimapMaker(List<MapDaQi> mapDaQiList){
    _initMarkerMap.clear();
    for(int i=0;i<mapDaQiList.length;i++){
      if(mapDaQiList[i].devStatus==1){
        airimagepath1='images/youc.png';
        airimagepath2='images/youj.png';

      }else if(mapDaQiList[i].devStatus==2){
        airimagepath1='images/liangc.png';
        airimagepath2='images/liangj.png';

      }else if(mapDaQiList[i].devStatus==3){
        airimagepath1='images/qingduc.png';
        airimagepath2='images/qingduj.png';

      }else if(mapDaQiList[i].devStatus==4){
        airimagepath1='images/zhongzduc.png';
        airimagepath2='images/zhongzduj.png';

      }else if(mapDaQiList[i].devStatus==5){
        airimagepath1='images/zhongduc.png';
        airimagepath2='images/zhongduj.png';

      }else if(mapDaQiList[i].devStatus==6){
        airimagepath1='images/yanzhongc.png';
        airimagepath2='images/yanzhongj.png';

      }else{
        airimagepath1='images/lixianc.png';
        airimagepath2='images/lixianj.png';
      }
      LatLng position = LatLng(double.parse(mapDaQiList[i].devLatitude) , double.parse(mapDaQiList[i].devLongitude));
      Marker marker = Marker(
        position: position,
        icon: airimagebool[i]?BitmapDescriptor.fromIconPath(airimagepath2):BitmapDescriptor.fromIconPath(airimagepath1),
        onTap: (markerId){

          firstlatitude=double.parse(mapDaQiList[i].devLatitude);
          firstlongitude=double.parse(mapDaQiList[i].devLongitude);
          setState(() {
            for(int j=0;j<mapDaQiList.length;j++){
              airimagebool[j]=false;
            }
            airimagebool[i]=true;

            daqimapMaker(mapDaQiList);
          });

          daqidetailsPost(mapDaQiList[i].sn);

        },
      );
      _initMarkerMap[marker.id] = marker;
    }

  }
  var airsitedetailsmodel;
  late List<RealtimeData> RealtimeDataList ;
  void daqidetailsPost(String sn) async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/countryDataDay/appQryDevDetail?sn=$sn');
    // var result=await http.get(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // //print(json.decode(utf8decoder.convert(result.bodyBytes)));
    String text='{"msg":"success","code":200,"data":{"deviceData":{"sn":null,"name":"农展馆","regionId":2,"devType":1,"devLongitude":"116.225183","devLatitude":"39.773337","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":"2021-12-29 11:16:03","delStatus":0,"busiParkId":null,"typeName":"国标站","regionName":"区域0002","pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},"alarmData":[{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[458.0]超过标准值(160.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[458.0]超过标准值(200.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[65.42]超过标准值(10.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[1235.0]超过标准值(200.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[1411.0]超过标准值(500.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[176.0]超过标准值(75.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[419.0]超过标准值(150.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[184.0]超过标准值(160.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[278.0]超过标准值(200.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[28.41]超过标准值(10.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[642.0]超过标准值(200.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[513.0]超过标准值(500.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[107.0]超过标准值(75.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[156.0]超过标准值(150.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[262.0]超过标准值(160.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[306.0]超过标准值(200.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[42.46]超过标准值(10.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[982.0]超过标准值(200.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[701.0]超过标准值(500.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[123.0]超过标准值(75.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[325.0]超过标准值(150.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[200.0]超过标准值(160.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[296.0]超过标准值(200.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[30.81]超过标准值(10.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[625.0]超过标准值(200.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[511.0]超过标准值(500.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[85.0]超过标准值(75.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[228.0]超过标准值(150.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[208.0]超过标准值(160.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[279.0]超过标准值(200.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[26.21]超过标准值(10.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[653.0]超过标准值(200.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[584.0]超过标准值(500.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[77.0]超过标准值(75.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[223.0]超过标准值(150.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[213.0]超过标准值(160.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[236.0]超过标准值(200.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[34.72]超过标准值(10.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[463.0]超过标准值(200.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[527.0]超过标准值(500.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[109.0]超过标准值(75.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[179.0]超过标准值(150.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[181.0]超过标准值(160.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[216.0]超过标准值(200.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[34.61]超过标准值(10.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[245.0]超过标准值(200.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[580.0]超过标准值(500.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[86.0]超过标准值(75.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[185.0]超过标准值(150.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[202.0]超过标准值(160.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[231.0]超过标准值(200.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[28.35]超过标准值(10.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[474.0]超过标准值(200.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[510.0]超过标准值(500.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[89.0]超过标准值(75.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[181.0]超过标准值(150.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃_8H","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"O₃_8H的监测值[573.0]超过标准值(160.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"O₃","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"O₃的监测值[756.0]超过标准值(200.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CO的监测值[85.28]超过标准值(10.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"NO₂","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"NO₂的监测值[1654.0]超过标准值(200.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[1132.0]超过标准值(500.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₂.₅","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"PM₂.₅的监测值[239.0]超过标准值(75.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"农展馆","indexId":null,"indexName":"PM₁₀","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"PM₁₀的监测值[418.0]超过标准值(150.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null}],"realtimeData":[{"unit":"µg/m³","data":176,"indexName":"PM₂.₅"},{"unit":"µg/m³","data":419,"indexName":"PM₁₀"},{"unit":"µg/m³","data":1235,"indexName":"NO₂"},{"unit":"µg/m³","data":1411,"indexName":"SO₂"},{"unit":"mg/m³","data":65.42,"indexName":"CO"},{"unit":"µg/m³","data":458,"indexName":"O₃"},{"unit":"µg/m³","data":458,"indexName":"O₃_8H最大"},{"unit":"µg/m³","data":458,"indexName":"O₃_8H"},{"unit":"µg/m³","data":"-","indexName":"NMHC"}]}}';
    airsitedetailsmodel=AirSiteDetailsModel.fromJson(json.decode(text));
    RealtimeDataList=airsitedetailsmodel.data.realtimeData;
    Navigator.push(context, PopRoute(
        DropDownMapAir(sn,airsitedetailsmodel,RealtimeDataList)));

  }
  Future<void> _indexGet1(String typeId) async {
    // print('111111111111111111111:::$typeId');
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId') ?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/pollutantIndex/getPollutantIndexByType/$typeId');
    // var result = await http.get(url,
    //     headers: {
    //       'busiParkId': busiParkId,
    //       'authorization': authorization
    //     });
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"PM₂.₅","code":"pm25","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":2,"name":"PM₁₀","code":"pm10","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":3,"name":"NO₂","code":"no2","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":4,"name":"SO₂","code":"so2","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":5,"name":"CO","code":"co","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":6,"name":"O₃","code":"o3","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":7,"name":"O₃_8H最大","code":"o3_8h_max","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":8,"name":"O₃_8H","code":"o3_8h","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":9,"name":"NMHC","code":"nmhc","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]}]}';
    airIndexModel = AirIndexModel.fromJson(
        json.decode(text));
    AirIndexData s=AirIndexData();
    s.id=-1;
    s.name='AQI';
    s.code='aqi';
    setState(() {
      airIndexList=airIndexModel.data!;
      if(typeId=='1'||typeId=='2'){
        airIndexList.insert(0, s);
      }
    });

    // for(int i=0;i<airIndexList.length;i++){
    //   gbichecks.add(false);
    // }
  }
  //水质请求
  late String waterimagepath1;
  late String waterimagepath2;
  List<bool> waterimagebool=[];
  void waterPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/generalOverview/getShowData?indexId=$indexId');
    // var result=await http.post(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    //
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // print('${HttpUtil.url}/api/generalOverview/getShowData?indexId=$indexId');
String text='{"msg":"success","code":200,"data":{"allData":[{"id":1,"name":"东店","type":3,"riverId":null,"areaId":null,"longitude":"116.162804","latitude":"39.904752","status":null,"remark":null,"delStatus":null,"onLineState":2,"busiParkId":null,"rivName":"北京市_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":2,"name":"南大荒桥","type":3,"riverId":null,"areaId":null,"longitude":"116.197587","latitude":"39.886816","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"北京市_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":3,"name":"古北口","type":3,"riverId":null,"areaId":null,"longitude":"116.082601","latitude":"39.90607","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"北京市_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":4,"name":"后城","type":3,"riverId":null,"areaId":null,"longitude":"116.062002","latitude":"39.893427","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"北京市_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":20,"name":"辛庄桥","type":3,"riverId":null,"areaId":null,"longitude":"116.121397","latitude":"39.939509","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"北京市_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":21,"name":"鼓楼外大街","type":3,"riverId":null,"areaId":null,"longitude":"116.122083","latitude":"39.940035","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"北京市_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":22,"name":"八间房漫水桥","type":3,"riverId":null,"areaId":null,"longitude":"116.137876","latitude":"39.922396","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"北京市_淮河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":23,"name":"万家码头","type":3,"riverId":null,"areaId":null,"longitude":"116.149892","latitude":"39.909493","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"天津市_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":24,"name":"三岔口","type":3,"riverId":null,"areaId":null,"longitude":"116.152639","latitude":"39.905543","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"天津市_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":25,"name":"于桥水库出口","type":3,"riverId":null,"areaId":null,"longitude":"116.158475","latitude":"39.896061","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"天津市_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":32,"name":"塘汉公路桥","type":3,"riverId":null,"areaId":null,"longitude":"116.208944","latitude":"39.867081","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"天津市_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":33,"name":"大套桥","type":3,"riverId":null,"areaId":null,"longitude":"116.208944","latitude":"39.868399","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"天津市_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":49,"name":"黄白桥","type":3,"riverId":null,"areaId":null,"longitude":"116.209974","latitude":"39.866291","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"天津市_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":50,"name":"黎河桥","type":3,"riverId":null,"areaId":null,"longitude":"116.248769","latitude":"39.775318","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"天津市_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":51,"name":"齐家务","type":3,"riverId":null,"areaId":null,"longitude":"116.256322","latitude":"39.787454","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"天津市_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":52,"name":"26#大桥","type":3,"riverId":null,"areaId":null,"longitude":"116.254606","latitude":"39.801172","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"河北省_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":53,"name":"三小营","type":3,"riverId":null,"areaId":null,"longitude":"116.250829","latitude":"39.793258","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"河北省_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":54,"name":"三河东大桥","type":3,"riverId":null,"areaId":null,"longitude":"116.249456","latitude":"39.772151","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"河北省_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":55,"name":"三河东大桥(老)","type":3,"riverId":null,"areaId":null,"longitude":"116.225183","latitude":"39.830322","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"河北省_海河流域","indexId":null,"code":null,"pollutantType":6,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":56,"name":"上二道河子","type":3,"riverId":null,"areaId":null,"longitude":"116.223363","latitude":"39.83967","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"河北省_海河流域","indexId":null,"code":null,"pollutantType":5,"outGauge":"是","cwqiValue":0.0,"waterDataList":null,"areaName":null}],"compare":55.0,"onLineCompare":95.0,"badFive":11,"allNum":20}}';
    mapWaterModel=MapWaterModel.fromJson(json.decode(text));
    // print(json.decode(utf8decoder.convert(result.bodyBytes)));
    mapWaterList=mapWaterModel.data.allData;
    _initMarkerMap.clear();
    waterimagebool.clear();
    for(int i=0;i<mapWaterList.length;i++){
      waterimagebool.add(false);}
    setState(() {
      watermapMaker(mapWaterList);
    });

  }
  void watermapMaker(List<MapWaterAllData> mapWaterList){
    _initMarkerMap.clear();
    for(int i=0;i<mapWaterList.length;i++){
      if(mapWaterList[i].onLineState==2){
        waterimagepath1='images/lixianc.png';
        waterimagepath2='images/lixianj.png';
      }else {
      if(mapWaterList[i].pollutantType==1){
        waterimagepath1='images/yileic.png';
        waterimagepath2='images/yileij.png';

      }else if(mapWaterList[i].pollutantType==2){
        waterimagepath1='images/erleic.png';
        waterimagepath2='images/erleij.png';

      }else if(mapWaterList[i].pollutantType==3){
        waterimagepath1='images/sanleic.png';
        waterimagepath2='images/sanleij.png';

      }else if(mapWaterList[i].pollutantType==4){
        waterimagepath1='images/sileic.png';
        waterimagepath2='images/sileij.png';

      }else if(mapWaterList[i].pollutantType==5){
        waterimagepath1='images/wuleic.png';
        waterimagepath2='images/wuleij.png';

      }else if(mapWaterList[i].pollutantType==6){
        waterimagepath1='images/liuleic.png';
        waterimagepath2='images/liuleij.png';

      }else {
        waterimagepath1='images/wushujuc.png';
        waterimagepath2='images/wushujuj.png';

      }
      }
      LatLng position = LatLng(double.parse(mapWaterList[i].latitude) , double.parse(mapWaterList[i].longitude));
      Marker marker = Marker(
        position: position,
        icon: waterimagebool[i]?BitmapDescriptor.fromIconPath(waterimagepath2):BitmapDescriptor.fromIconPath(waterimagepath1),
        onTap: (markerId){

          firstlatitude=double.parse(mapWaterList[i].latitude);
          firstlongitude=double.parse(mapWaterList[i].longitude);
          setState(() {
            for(int j=0;j<mapWaterList.length;j++){
              waterimagebool[j]=false;
            }
            waterimagebool[i]=true;

            watermapMaker(mapWaterList);
          });

          waterdetailsPost(mapWaterList[i].id.toString());

        },
      );
      _initMarkerMap[marker.id] = marker;
    }

  }
  var waterdetailsmodel;
  late List<WaterRealtimeData> WaterDataList ;
  void waterdetailsPost(String id) async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/appWater/qryWaterFraDetail?fraId=$id');
    // var result=await http.get(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // print('${HttpUtil.url}/api/appWater/qryWaterFraDetail?fraId=$id');
    String text='{"msg":"success","code":200,"data":{"latitude":"39.904752","alarmData":[{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(2.04)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.27)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.5)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(12.99)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(792.52)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(328.67)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(11.62)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(499.6)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(897.1)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(8.09)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"水温(8.1)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(7.12)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(204.73)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(665.45)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(9.84)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"水温(9.4)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(2.04)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.31)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.14)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(11.5)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(952.22)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(464.52)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(7.2)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(1.39)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(12.61)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(371.17)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(336.67)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(9.27)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(1.14)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.99)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(6.77)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(98.4)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(794.06)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"水温(5.6)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.38)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.5)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(117.92)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(571.9)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(5.53)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(7.0)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.36)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(631.83)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(742.17)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(7.93)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(6.5)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(2.04)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(15.07)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(995.36)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(778.64)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(6.7)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.35)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(662.45)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(204.35)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(7.06)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"水温(9.5)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.24)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(14.57)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(278.69)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(264.18)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(2.43)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(17.0)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(233.0)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(862.51)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(8.06)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"水温(8.2)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.25)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(762.33)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.27)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(2.45)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(461.82)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(331.88)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(6.1)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(12.47)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(801.55)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"水温(5.6)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(6.95)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(859.76)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(5.91)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(2.13)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.23)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(502.43)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(620.77)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"水温(8.6)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.31)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.94)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(11.12)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(843.27)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(449.81)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(5.99)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"水温(5.3)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.25)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(2.49)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(595.55)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(466.9)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(9.88)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"东店","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(8.0)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null}],"realtimeData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":["总氮(1.04)","总磷(4.4)","高锰酸盐指数(1.17)"],"indexName":"pollutionIndexName"},{"unit":"℃","data":1.1,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":2.75,"indexName":"溶解氧"},{"unit":"μs/cm","data":328.67,"indexName":"电导率"},{"unit":"NTU","data":792.52,"indexName":"浊度"},{"unit":"mg/L","data":12.99,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":1.5,"indexName":"氨氮"},{"unit":"mg/L","data":0.27,"indexName":"总磷"},{"unit":"mg/L","data":2.04,"indexName":"总氮"}],"updateTime":"2021-12-29 14:00:00","type":3,"riverName":"北京市_海河流域","fraName":"东店","longitude":"116.162804"}}';
    waterdetailsmodel=WaterDetailsModel.fromJson(json.decode(text));
    WaterDataList=waterdetailsmodel.data.realtimeData;
    Navigator.push(context, PopRoute(
        DropDownMapWater(id,waterdetailsmodel,WaterDataList)));

  }
  Future<void> _waterIndexGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/waterIndex/getIndexList?status=1');
    // var result=await http.get(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization},
    // );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // // print('11111'+json.decode(result.body));
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"水温","code":"water_temp","unit":"℃","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":2,"name":"PH","code":"ph","unit":"无量纲","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":3,"name":"溶解氧","code":"do","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":4,"name":"电导率","code":"ec","unit":"μs/cm","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":5,"name":"浊度","code":"turbidity","unit":"NTU","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":6,"name":"高锰酸盐指数","code":"kmno4","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":7,"name":"氨氮","code":"nh3","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":8,"name":"总磷","code":"allp","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":9,"name":"总氮","code":"alln","unit":"mg/L","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":10,"name":"化学需氧量","code":"cod","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":11,"name":"五日生化需氧量","code":"bod5","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":12,"name":"铜","code":"cu","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":13,"name":"锌","code":"zn","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":14,"name":"氟化物","code":"f","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":15,"name":"硒","code":"se","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":16,"name":"砷","code":"as","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":17,"name":"汞","code":"hg","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":18,"name":"镉","code":"cd","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":19,"name":"铬","code":"cr","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":20,"name":"铅","code":"pb","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":21,"name":"氰化物","code":"hcn","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":22,"name":"挥发酚","code":"phenol","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":23,"name":"石油类","code":"oil","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":24,"name":"阴离子表面活性剂","code":"negion","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":25,"name":"硫化物","code":"sox","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":26,"name":"粪大肠菌群","code":"coliform","unit":"mg/L","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null}]}';
    waterIndexModel=WaterIndexModel.fromJson(json.decode(text) ) ;

    waterIndexList=waterIndexModel.data!;
    IndexData all=IndexData();
    all.id=-1;
    all.name='全部指标';
    waterIndexList.insert(0, all);
  }
  //污染请求
  late String imagepath1;
  late String imagepath2;
   List<bool> imagebool=[];
  void pollutionGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/appPollution/qryAllOutlet');
    // var result=await http.get(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    //
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // print('${HttpUtil.url}/api/appPollution/qryAllOutlet');
String text='{"msg":"success","code":200,"data":[{"id":1,"name":"废气1-南村小区街道","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.189825","latitude":"39.874413","remark":null,"companyId":null,"delStatus":0,"onLineState":2,"busiParkId":null,"outType":3,"comName":null,"comId":0,"waterTypeName":null},{"id":2,"name":"废气2","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.20621","latitude":"39.86223","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":3,"name":"废气3","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.219433","latitude":"39.880615","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":4,"name":"废气4","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.222021","latitude":"39.854476","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":5,"name":"废气5","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.188388","latitude":"39.889031","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":6,"name":"废水1","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.178327","latitude":"39.892574","remark":null,"companyId":null,"delStatus":0,"onLineState":2,"busiParkId":null,"outType":3,"comName":null,"comId":0,"waterTypeName":null},{"id":7,"name":"废水2","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.178327","latitude":"39.892574","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":8,"name":"废水3","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.233231","latitude":"39.835197","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":9,"name":"废水4","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.209085","latitude":"39.889695","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":10,"name":"废水5","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.167404","latitude":"39.904752","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null}]}';
    mapPollutionModel=MapPollutionModel.fromJson(json.decode(text));
    // print(json.decode(utf8decoder.convert(result.bodyBytes)));
    mapPollutionList=mapPollutionModel.data;
    _initMarkerMap.clear();
    for(int i=0;i<mapPollutionList.length;i++){
      imagebool.add(false);}
    setState(() {
      pollutionmapMaker(mapPollutionList);
    });

  }
  void pollutionmapMaker(List<MapPollution> mapPollutionList){
    _initMarkerMap.clear();
    for(int i=0;i<mapPollutionList.length;i++){
      if(mapPollutionList[i].outType==1){
        imagepath1='images/zhengchangc.png';
        imagepath2='images/zhengchangj.png';

      }else if(mapPollutionList[i].outType==2){
        imagepath1='images/chaobiaoc.png';
        imagepath2='images/chaobiaoj.png';

      }else{
        imagepath1='images/lixianc.png';
        imagepath2='images/lixianj.png';
      }
      LatLng position = LatLng(double.parse(mapPollutionList[i].latitude) , double.parse(mapPollutionList[i].longitude));
      Marker marker = Marker(
        position: position,
        icon: imagebool[i]?BitmapDescriptor.fromIconPath(imagepath2):BitmapDescriptor.fromIconPath(imagepath1),
        onTap: (markerId){

          firstlatitude=double.parse(mapPollutionList[i].latitude);
          firstlongitude=double.parse(mapPollutionList[i].longitude);
          setState(() {
            for(int j=0;j<mapPollutionList.length;j++){
              imagebool[j]=false;
            }
            imagebool[i]=true;

            pollutionmapMaker(mapPollutionList);
          });

          pollutiondetailsPost(mapPollutionList[i].id.toString());

        },
      );
      _initMarkerMap[marker.id] = marker;
    }

  }
  var pollutionDetailsModel;
  late List<PollRealtimeData> PollutionDataList ;
  void pollutiondetailsPost(String outletId) async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/appPollution/outletDetailData?outId=$outletId');
    // var result=await http.get(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":{"outletName":"废气1-南村小区街道","outletId":1,"latitude":"39.874413","alarmData":[{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[408.90]超过标准值(400.0)","createTime":"2021-12-29 14:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[403.50]超过标准值(400.0)","createTime":"2021-12-29 13:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[409.56]超过标准值(400.0)","createTime":"2021-12-29 12:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[402.84]超过标准值(400.0)","createTime":"2021-12-29 12:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[401.42]超过标准值(400.0)","createTime":"2021-12-29 11:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"PM","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM的监测值[86.43]超过标准值(80.0)","createTime":"2021-12-29 11:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[400.26]超过标准值(400.0)","createTime":"2021-12-29 10:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[408.56]超过标准值(400.0)","createTime":"2021-12-29 09:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"PM","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM的监测值[83.02]超过标准值(80.0)","createTime":"2021-12-29 08:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[404.84]超过标准值(400.0)","createTime":"2021-12-29 07:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[400.65]超过标准值(400.0)","createTime":"2021-12-29 07:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[406.73]超过标准值(400.0)","createTime":"2021-12-29 06:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[407.76]超过标准值(400.0)","createTime":"2021-12-29 05:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[408.36]超过标准值(400.0)","createTime":"2021-12-29 04:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[404.73]超过标准值(400.0)","createTime":"2021-12-29 02:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[410.28]超过标准值(400.0)","createTime":"2021-12-29 01:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null}],"updateTime":"2021-12-29 14:00:00","realtimeData":[{"unit":"µg/m 3","data":"354.97","indexName":"SO₂"},{"unit":"µg/m 3","data":"408.90","indexName":"NOx"},{"unit":"µg/m 3","data":"76.56","indexName":"PM"}],"comName":"大安化工南村街道分公司","type":1,"longitude":"116.189825"}}';
    pollutionDetailsModel=PollutionDetailsModel.fromJson(json.decode(text));
    PollutionDataList=pollutionDetailsModel.data.realtimeData;
    Navigator.push(context, PopRoute(
        DropDownMapPollution(outletId,pollutionDetailsModel,PollutionDataList)));

  }
  void locationPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/overview/getMapAreaList?areaId=$busiParkId');
    // var result=await http.post(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    //
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // print('${HttpUtil.url}/overview/getMapAreaList?areaId=$busiParkId');
    String text='{"msg":"success","code":200,"data":[{"id":null,"areaId":null,"name":null,"longitude":"116.102151","latitude":"39.98286","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.007865","latitude":"39.893016","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.00499","latitude":"39.785758","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.179189","latitude":"39.738723","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.360863","latitude":"39.8168","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.325793","latitude":"39.924453","busiParkId":null}],"center":{"id":1,"name":"园区1","longitude":"116.175165","latitude":"39.897002","parkCoordinate":"","remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"areaList":null}}';
    locationModel=LocationModel.fromJson(json.decode(text));



      setState(() {
        final List<LatLng> points = <LatLng>[];
        for(int i=0;i<locationModel.data.length;i++){
          points.add(LatLng(double.parse(locationModel.data[i].latitude.toString()), double.parse(locationModel.data[i].longitude.toString())));
          //print(double.parse(locationModel.data[i].latitude.toString()));
        }

        final  Polygon polygon = Polygon(
          strokeColor: const Color.fromRGBO(46, 228, 149, 0.6),
          fillColor: const Color.fromRGBO(46, 228, 149, 0.15),
          strokeWidth: Adapt.px(2),
          points: points,
        );

        _polygons ={};
        _polygons[polygon.id]=polygon;
        firstlatitude =double.parse(locationModel.center.latitude.toString());
        // double.parse(_locationResult['latitude'].toString());
        print(firstlatitude);
        firstlongitude = double.parse(locationModel.center.longitude.toString());
        print(firstlongitude);

      });





  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final AMapWidget map = AMapWidget(
      privacyStatement: ConstConfig.amapPrivacyStatement,
      apiKey: ConstConfig.amapApiKeys,
      onMapCreated: _onMapCreated,
      customStyleOptions: _customStyleOptions,
      polygons: Set<Polygon>.of(_polygons.values),
      markers: Set<Marker>.of(_initMarkerMap.values),
      // 定位小蓝点配置
      myLocationStyleOptions: MyLocationStyleOptions(true),
      initialCameraPosition: CameraPosition(
        target: LatLng(firstlatitude, firstlongitude),
        zoom: 11.0,
      ),

    );
    _mapController?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(firstlatitude,firstlongitude),
      zoom: 11,
    )),
    );
       if(_daqibiaoshi==true){
         return Scaffold(
           appBar: PreferredSize(
               child:  Container(
                 height: MediaQueryData.fromWindow(window).padding.top,
                 color: const Color.fromRGBO(6, 36, 66, 1),
               ),
               preferredSize: Size.fromHeight(MediaQueryData.fromWindow(window).padding.top)),
           body: Column(
             children: <Widget>[
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: Adapt.px(86),
                 color: const Color.fromRGBO(6, 36, 66, 1),
                 alignment: Alignment.centerLeft,
                 padding: EdgeInsets.only(left: 16.5),
                 child: Row(children: [
                   SizedBox(width: Adapt.px(32),),
                   InkWell(
                     onTap: (){
                       daqiPost();
                       setState(() {
                         _daqibiaoshi=true;
                         _waterbiaoshi=false;
                         _wuranbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       decoration: _daqibiaoshi?boxDecoration1:boxDecoration2,
                       alignment: Alignment.center,
                       child: Text('大气',style: _daqibiaoshi?textStyle1:textStyle2),),
                   ),
                   InkWell(
                     onTap: (){
                       waterPost();
                       setState(() {
                         indexId='-1';
                         _waterbiaoshi=true;
                         _daqibiaoshi=false;
                         _wuranbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       alignment: Alignment.center,
                       decoration: _waterbiaoshi?boxDecoration1:boxDecoration2,
                       child: Text('水质',style: _waterbiaoshi?textStyle1:textStyle2),),
                   ),
                   InkWell(
                     onTap: (){
                       pollutionGet();
                       setState(() {
                         _wuranbiaoshi=!_wuranbiaoshi;
                         _daqibiaoshi=false;
                         _waterbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       alignment: Alignment.center,
                       decoration: _wuranbiaoshi?boxDecoration1:boxDecoration2,
                       child: Text('污染源',style: _wuranbiaoshi?textStyle1:textStyle2),),
                   ),


                 ],),
               ),
               Expanded(
                 child: Stack(
                   alignment: Alignment.center,
                   children: [
                     Container(
                       height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width,
                       child: map,
                     ),
                     Positioned(
                       left: Adapt.px(64),
                       bottom: Adapt.px(20),
                       child: Image(image: const AssetImage('images/03djbz.png'),width: Adapt.px(622),height: Adapt.px(80),),
                     ),
                     Positioned(
                         right: Adapt.px(20),
                         top: Adapt.px(43),
                         child: InkWell(
                           onTap: (){
                             setState(() {
                               _isShow=!_isShow;
                             });
                           },
                           child: Container(
                             width: Adapt.px(80),
                             height: Adapt.px(80),
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                               color: const Color.fromRGBO(0, 26, 63, 0.75),
                               borderRadius: BorderRadius.circular(Adapt.px(40)),
                             ),
                             child: Image(image: const AssetImage('images/tuceng.png'),width: Adapt.px(32),height: Adapt.px(32),),
                           ),
                         )

                     ),
                     Positioned(
                       right: Adapt.px(116),
                       top: Adapt.px(43),
                       child: Offstage(
                         offstage: _isShow,
                         child: Container(
                           width: Adapt.px(317),
                           height: Adapt.px(291),
                           color:  const Color.fromRGBO(0, 26, 63, 0.75),
                           child: Column(children: [
                             InkWell(
                               onTap: (){
                                 setState(() {
                                   leixing='1';
                                   _indexGet1('1');
                                   _isShow=true;

                                 });
                               },
                               child: Container(
                                 width: Adapt.px(317),
                                 height: Adapt.px(72),
                                 alignment: Alignment.centerLeft,
                                 child: Text('   国标站',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),),),
                             InkWell(
                               onTap: (){

                                 setState(() {
                                   leixing='2';
                                   _indexGet1('2');
                                   _isShow=true;
                                 });
                               },
                               child: Container(
                                 width: Adapt.px(317),
                                 height: Adapt.px(72),
                                 alignment: Alignment.centerLeft,
                                 child: Text('   网格站',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),),),
                             InkWell(
                               onTap: (){

                                 setState(() {
                                   leixing='3';
                                   _indexGet1('3');
                                   _isShow=true;
                                 });
                               },
                               child: Container(
                                 width: Adapt.px(317),
                                 height: Adapt.px(72),
                                 alignment: Alignment.centerLeft,
                                 child: Text('   有毒有害',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),),),
                             InkWell(
                               onTap: (){

                                 setState(() {

                                   leixing='4';
                                   _indexGet1('4');
                                   _isShow=true;
                                 });
                               },
                               child: Container(
                                 width: Adapt.px(317),
                                 height: Adapt.px(72),
                                 alignment: Alignment.centerLeft,
                                 child: Text('   恶臭',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),),),
                           ],),
                         ),
                       ),

                     ),
                     Positioned(
                       right: Adapt.px(20),
                       top: Adapt.px(143),
                       child: Container(
                         width: Adapt.px(80),
                         height: MediaQuery.of(context).size.height/2,
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                           color: const Color.fromRGBO(0, 26, 63, 0.75),
                           borderRadius: BorderRadius.circular(Adapt.px(56)),
                         ),
                         child: ListView.builder(
                             itemCount: airIndexList.length,//个数
                             // scrollDirection: Axis.vertical,//滑动方向
                             primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                             //内容适配
                             shrinkWrap: true,
                             itemBuilder:(BuildContext context,int index){
                               return getAirIndexListViewItem(airIndexList[index]);
                             }),
                       ),

                     ),
                     Positioned(
                         right: Adapt.px(20),
                         bottom: Adapt.px(206),
                         child: InkWell(
                           onTap: (){
                             // setState(() {
                             //   _isShow=!_isShow;
                             // });
                           },
                           child: Container(
                             width: Adapt.px(80),
                             height: Adapt.px(80),
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                               color: const Color.fromRGBO(0, 26, 63, 0.75),
                               borderRadius: BorderRadius.circular(Adapt.px(40)),
                             ),
                             child: Image(image: const AssetImage('images/dingwei.png'),width: Adapt.px(32),height: Adapt.px(32),),
                           ),
                         )

                     ),
                   ],
                 ),
               ),
             ],
           ),


         );
       }
       else if(_waterbiaoshi==true){
         return Scaffold(
           appBar: PreferredSize(
               child:  Container(
                 height: MediaQueryData.fromWindow(window).padding.top,
                 color: const Color.fromRGBO(6, 36, 66, 1),
               ),
               preferredSize: Size.fromHeight(MediaQueryData.fromWindow(window).padding.top)),
           body: Column(
             children: <Widget>[
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: Adapt.px(86),
                 color: const Color.fromRGBO(6, 36, 66, 1),
                 alignment: Alignment.centerLeft,
                 padding: EdgeInsets.only(left: 16.5),
                 child: Row(children: [
                   SizedBox(width: Adapt.px(32),),
                   InkWell(
                     onTap: (){
                       daqiPost();
                       setState(() {
                         _daqibiaoshi=true;
                         _waterbiaoshi=false;
                         _wuranbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       decoration: _daqibiaoshi?boxDecoration1:boxDecoration2,
                       alignment: Alignment.center,
                       child: Text('大气',style: _daqibiaoshi?textStyle1:textStyle2),),
                   ),
                   InkWell(
                     onTap: (){
                       waterPost();
                       setState(() {
                         indexId='-1';
                         _waterbiaoshi=true;
                         _daqibiaoshi=false;
                         _wuranbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       alignment: Alignment.center,
                       decoration: _waterbiaoshi?boxDecoration1:boxDecoration2,
                       child: Text('水质',style: _waterbiaoshi?textStyle1:textStyle2),),
                   ),
                   InkWell(
                     onTap: (){
                       pollutionGet();
                       setState(() {
                         _wuranbiaoshi=!_wuranbiaoshi;
                         _daqibiaoshi=false;
                         _waterbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       alignment: Alignment.center,
                       decoration: _wuranbiaoshi?boxDecoration1:boxDecoration2,
                       child: Text('污染源',style: _wuranbiaoshi?textStyle1:textStyle2),),
                   ),
                 ],),
               ),
               Expanded(
                 child: Stack(
                   alignment: Alignment.center,
                   children: [
                     Container(
                       height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width,
                       child: map,
                     ),

                     Positioned(
                       left: Adapt.px(64),
                       bottom: Adapt.px(20),
                       child: Image(image: const AssetImage('images/03djbzwater.png'),width: Adapt.px(622),height: Adapt.px(80),),
                     ),
                     Positioned(
                         right: Adapt.px(20),
                         top: Adapt.px(143),
                         child: Container(
                           width: Adapt.px(80),
                           height: MediaQuery.of(context).size.height/2,
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                             color: const Color.fromRGBO(0, 26, 63, 0.75),
                             borderRadius: BorderRadius.circular(Adapt.px(56)),
                           ),
                           child: ListView.builder(
                               itemCount: waterIndexList.length,//个数

                               // scrollDirection: Axis.vertical,//滑动方向
                               primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                               //内容适配
                               shrinkWrap: true,


                               itemBuilder:(BuildContext context,int index){
                                 return getwaterIndexListViewItem(waterIndexList[index]);
                               }),
                         ),

                     ),
                     Positioned(
                         right: Adapt.px(20),
                         bottom: Adapt.px(206),
                         child: InkWell(
                           onTap: (){
                             setState(() {
                               _isShow=!_isShow;
                             });
                           },
                           child: Container(
                             width: Adapt.px(80),
                             height: Adapt.px(80),
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                               color: const Color.fromRGBO(0, 26, 63, 0.75),
                               borderRadius: BorderRadius.circular(Adapt.px(40)),
                             ),
                             child: Image(image: const AssetImage('images/dingwei.png'),width: Adapt.px(32),height: Adapt.px(32),),
                           ),
                         )

                     ),
                   ],
                 ),
               ),
             ],
           ),


         );
       }else {
         return Scaffold(
           appBar: PreferredSize(
               child:  Container(
                 height: MediaQueryData.fromWindow(window).padding.top,
                 color: const Color.fromRGBO(6, 36, 66, 1),
               ),
               preferredSize: Size.fromHeight(MediaQueryData.fromWindow(window).padding.top)),
           body: Column(
             children: <Widget>[
               Container(
                 width: MediaQuery.of(context).size.width,
                 height: Adapt.px(86),
                 color: const Color.fromRGBO(6, 36, 66, 1),
                 alignment: Alignment.centerLeft,
                 padding: EdgeInsets.only(left: 16.5),
                 child: Row(children: [
                   SizedBox(width: Adapt.px(32),),
                   InkWell(
                     onTap: (){
                       daqiPost();
                       setState(() {
                         _daqibiaoshi=true;
                         _waterbiaoshi=false;
                         _wuranbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       decoration: _daqibiaoshi?boxDecoration1:boxDecoration2,
                       alignment: Alignment.center,
                       child: Text('大气',style: _daqibiaoshi?textStyle1:textStyle2),),
                   ),
                   InkWell(
                     onTap: (){
                       waterPost();
                       setState(() {
                         indexId='-1';
                         _waterbiaoshi=true;
                         _daqibiaoshi=false;
                         _wuranbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       alignment: Alignment.center,
                       decoration: _waterbiaoshi?boxDecoration1:boxDecoration2,
                       child: Text('水质',style: _waterbiaoshi?textStyle1:textStyle2),),
                   ),
                   InkWell(
                     onTap: (){
                       pollutionGet();
                       setState(() {
                         _wuranbiaoshi=!_wuranbiaoshi;
                         _daqibiaoshi=false;
                         _waterbiaoshi=false;
                       });

                     },
                     child: Container(
                       width: Adapt.px(104),
                       height: Adapt.px(56),
                       alignment: Alignment.center,
                       decoration: _wuranbiaoshi?boxDecoration1:boxDecoration2,
                       child: Text('污染源',style: _wuranbiaoshi?textStyle1:textStyle2),),
                   ),
                 ],),
               ),
               Expanded(
                 child: Stack(
                   alignment: Alignment.center,
                   children: [
                     Container(
                       height: MediaQuery.of(context).size.height,
                       width: MediaQuery.of(context).size.width,
                       child: map,
                     ),

                     Positioned(
                       left: Adapt.px(64),
                       bottom: Adapt.px(20),
                       child: Image(image: const AssetImage('images/03djbzwuran.png'),width: Adapt.px(622),height: Adapt.px(80),),
                     ),
                     Positioned(
                         right: Adapt.px(20),
                         bottom: Adapt.px(206),
                         child: InkWell(
                           onTap: (){
                             setState(() {
                               _isShow=!_isShow;
                             });
                           },
                           child: Container(
                             width: Adapt.px(80),
                             height: Adapt.px(80),
                             alignment: Alignment.center,
                             decoration: BoxDecoration(
                               color: const Color.fromRGBO(0, 26, 63, 0.75),
                               borderRadius: BorderRadius.circular(Adapt.px(40)),
                             ),
                             child: Image(image: const AssetImage('images/dingwei.png'),width: Adapt.px(32),height: Adapt.px(32),),
                           ),
                         )

                     ),
                   ],
                 ),
               ),
             ],
           ),


         );
       }

  }

  Widget getAirIndexListViewItem(AirIndexData indexData) {
    return InkWell(
      onTap: (){
        kpi=indexData.code.toString();
        daqiPost();
      },
      child: Container(
          height: Adapt.px(70),
          width: Adapt.px(70),
          alignment: Alignment.center,
          child: Text(indexData.name.toString(), style: TextStyle(color:  const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(20),),maxLines:2,textAlign: TextAlign.center,)
      ),
    );
  }
  Widget getwaterIndexListViewItem(IndexData indexData) {
    return InkWell(
      onTap: (){
          indexId=indexData.id.toString();
          waterPost();

      },
      child: Container(
          height: Adapt.px(70),
          width: Adapt.px(70),
          alignment: Alignment.center,
          child: Text(indexData.name.toString(), style: TextStyle(color:  const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(20),),maxLines:2,textAlign: TextAlign.center,)
      ),
    );
  }
  void _onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });


    // _controller?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
    //   target: LatLng(double.parse(_locationResult['latitude'].toString()), double.parse(_locationResult['longitude'].toString())),
    //   zoom: 15.0,
    // ))
    // );
  }
//加载自定义地图样式
  void _loadCustomData() async {
    _customStyleOptions ??= CustomStyleOptions(false);
    ByteData styleByteData = await rootBundle.load('assets/style.data');
    _customStyleOptions.styleData = styleByteData.buffer.asUint8List();
    ByteData styleExtraByteData =
    await rootBundle.load('assets/style_extra.data');
    _customStyleOptions.styleExtraData =
        styleExtraByteData.buffer.asUint8List();
    //如果需要加载完成后直接展示自定义地图，可以通过setState修改CustomStyleOptions的enable为true
   setState(() {
      _customStyleOptions.enabled = true;

   });
  }
  void _chushiquanxian() async {
    AMapFlutterLocation.setApiKey(
        '787dc18adfa7c2705eb11ab4994061c5', "a57d31271de2c454cc30206974e0ace2");

    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 动态申请定位权限
    requestPermission();

    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      // setState(() {
      //   _locationResult = result;
      //   // firstlatitude =double.parse(_locationResult['latitude'].toString());
      //   // firstlongitude = double.parse(_locationResult['longitude'].toString());

      //   // _controller?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //   //   target: LatLng(double.parse(_locationResult['latitude'].toString()), double.parse(_locationResult['longitude'].toString())),
      //   //   zoom: 15.0,
      //   // ))
      //   // );
      // });
    });
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
      //_startLocation();
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
  ///设置定位参数
  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = true;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    locationOption.locationInterval = 2000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);
  }

  ///开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  ///停止定位
  void _stopLocation() {
    _locationPlugin.stopLocation();
  }


}