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
  //??????

   CustomStyleOptions _customStyleOptions = CustomStyleOptions(false);
  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  //????????????
  late StreamSubscription<Map<String, Object>> _locationListener;
  //????????????
  Map<String, Object> _locationResult = {};
  //???????????????
  var _mapController;
  //????????????
  Map<String, Polygon> _polygons = <String, Polygon>{};
  //?????????
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};
  var widgetsBinding;
  //??????????????????
  var leixing='1';
  var kpi='aqi';
  late MapDaQiModel mapDaQiModel;
  late List<MapDaQi> mapDaQiList;
  //????????????????????????
  var indexId='-1';
  late MapWaterModel mapWaterModel;
  late List<MapWaterAllData> mapWaterList;
  //??????????????????
  late MapPollutionModel mapPollutionModel;
  late List<MapPollution> mapPollutionList;
  //????????????????????????
  late AirIndexModel airIndexModel;
  List<AirIndexData> airIndexList=[];
  //????????????????????????
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
  //????????????
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
String text='{"msg":"success","code":200,"data":[{"value":299.0,"valueCompare":null,"name":"?????????","grade":"??????","level":5,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"609","devLongitude":"116.225183","devLatitude":"39.773337","status":null,"devStatus":5,"devType":1,"kpiName":null},{"value":291.0,"valueCompare":null,"name":"??????","grade":"??????","level":5,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2594","devLongitude":"116.132621","devLatitude":"39.845613","status":null,"devStatus":5,"devType":1,"kpiName":null},{"value":194.0,"valueCompare":null,"name":"?????????","grade":"??????","level":4,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2592","devLongitude":"116.256228","devLatitude":"39.867768","status":null,"devStatus":4,"devType":1,"kpiName":null},{"value":190.0,"valueCompare":null,"name":"??????","grade":"??????","level":4,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2590","devLongitude":"116.220008","devLatitude":"39.892131","status":null,"devStatus":4,"devType":1,"kpiName":null},{"value":148.0,"valueCompare":null,"name":"?????????","grade":"??????","level":3,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2593","devLongitude":"116.163667","devLatitude":"39.862895","status":null,"devStatus":3,"devType":1,"kpiName":null},{"value":147.0,"valueCompare":null,"name":"??????","grade":"??????","level":3,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"608","devLongitude":"116.053283","devLatitude":"39.779104","status":null,"devStatus":3,"devType":1,"kpiName":null},{"value":142.0,"valueCompare":null,"name":"??????","grade":"??????","level":3,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2591","devLongitude":"116.111924","devLatitude":"39.918698","status":null,"devStatus":3,"devType":1,"kpiName":null},{"value":136.0,"valueCompare":null,"name":"??????","grade":"??????","level":3,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"611","devLongitude":"116.31142","devLatitude":"39.840295","status":null,"devStatus":3,"devType":1,"kpiName":null},{"value":96.0,"valueCompare":null,"name":"?????????","grade":"???","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2595","devLongitude":"116.24358","devLatitude":"39.835419","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":95.0,"valueCompare":null,"name":"??????","grade":"???","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2589","devLongitude":"116.152743","devLatitude":"39.90143","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":90.0,"valueCompare":null,"name":"????????????","grade":"???","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"612","devLongitude":"116.282674","devLatitude":"39.854919","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":87.0,"valueCompare":null,"name":"??????","grade":"???","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:03","data":null,"sn":"610","devLongitude":"116.080879","devLatitude":"39.808376","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":82.0,"valueCompare":null,"name":"??????","grade":"???","level":2,"sort":null,"time":null,"dataTime":"2021-12-29 11:16:02","data":null,"sn":"2596","devLongitude":"116.103875","devLatitude":"39.846499","status":null,"devStatus":2,"devType":1,"kpiName":null},{"value":null,"valueCompare":null,"name":"??????","grade":"??????","level":0,"sort":null,"time":null,"dataTime":null,"data":null,"sn":"2597","devLongitude":"116.239555","devLatitude":"39.834089","status":null,"devStatus":0,"devType":1,"kpiName":null},{"value":null,"valueCompare":null,"name":"????????????","grade":"??????","level":0,"sort":null,"time":null,"dataTime":null,"data":null,"sn":"607","devLongitude":"116.161942","devLatitude":"39.762244","status":null,"devStatus":0,"devType":1,"kpiName":null}]}';
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
    String text='{"msg":"success","code":200,"data":{"deviceData":{"sn":null,"name":"?????????","regionId":2,"devType":1,"devLongitude":"116.225183","devLatitude":"39.773337","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":"2021-12-29 11:16:03","delStatus":0,"busiParkId":null,"typeName":"?????????","regionName":"??????0002","pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},"alarmData":[{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[458.0]???????????????(160.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[458.0]???????????????(200.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[65.42]???????????????(10.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[1235.0]???????????????(200.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[1411.0]???????????????(500.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[176.0]???????????????(75.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[419.0]???????????????(150.0)","createTime":"2021-12-29 11:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[184.0]???????????????(160.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[278.0]???????????????(200.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[28.41]???????????????(10.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[642.0]???????????????(200.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[513.0]???????????????(500.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[107.0]???????????????(75.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[156.0]???????????????(150.0)","createTime":"2021-12-29 10:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[262.0]???????????????(160.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[306.0]???????????????(200.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[42.46]???????????????(10.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[982.0]???????????????(200.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[701.0]???????????????(500.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[123.0]???????????????(75.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[325.0]???????????????(150.0)","createTime":"2021-12-29 08:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[200.0]???????????????(160.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[296.0]???????????????(200.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[30.81]???????????????(10.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[625.0]???????????????(200.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[511.0]???????????????(500.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[85.0]???????????????(75.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[228.0]???????????????(150.0)","createTime":"2021-12-29 05:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[208.0]???????????????(160.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[279.0]???????????????(200.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[26.21]???????????????(10.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[653.0]???????????????(200.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[584.0]???????????????(500.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[77.0]???????????????(75.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[223.0]???????????????(150.0)","createTime":"2021-12-29 04:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[213.0]???????????????(160.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[236.0]???????????????(200.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[34.72]???????????????(10.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[463.0]???????????????(200.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[527.0]???????????????(500.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[109.0]???????????????(75.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[179.0]???????????????(150.0)","createTime":"2021-12-29 03:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[181.0]???????????????(160.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[216.0]???????????????(200.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[34.61]???????????????(10.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[245.0]???????????????(200.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[580.0]???????????????(500.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[86.0]???????????????(75.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[185.0]???????????????(150.0)","createTime":"2021-12-29 02:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[202.0]???????????????(160.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[231.0]???????????????(200.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[28.35]???????????????(10.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[474.0]???????????????(200.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[510.0]???????????????(500.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[89.0]???????????????(75.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[181.0]???????????????(150.0)","createTime":"2021-12-29 01:16:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???_8H","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"O???_8H????????????[573.0]???????????????(160.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"O???","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"O???????????????[756.0]???????????????(200.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"CO","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CO????????????[85.28]???????????????(10.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"NO???","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"NO???????????????[1654.0]???????????????(200.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[1132.0]???????????????(500.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM???.???","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"PM???.???????????????[239.0]???????????????(75.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"609","deviceName":"?????????","indexId":null,"indexName":"PM??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"PM??????????????????[418.0]???????????????(150.0)","createTime":"2021-12-29 00:16:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null}],"realtimeData":[{"unit":"??g/m??","data":176,"indexName":"PM???.???"},{"unit":"??g/m??","data":419,"indexName":"PM??????"},{"unit":"??g/m??","data":1235,"indexName":"NO???"},{"unit":"??g/m??","data":1411,"indexName":"SO???"},{"unit":"mg/m??","data":65.42,"indexName":"CO"},{"unit":"??g/m??","data":458,"indexName":"O???"},{"unit":"??g/m??","data":458,"indexName":"O???_8H??????"},{"unit":"??g/m??","data":458,"indexName":"O???_8H"},{"unit":"??g/m??","data":"-","indexName":"NMHC"}]}}';
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
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"PM???.???","code":"pm25","unit":"??g/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":2,"name":"PM??????","code":"pm10","unit":"??g/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":3,"name":"NO???","code":"no2","unit":"??g/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":4,"name":"SO???","code":"so2","unit":"??g/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":5,"name":"CO","code":"co","unit":"mg/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":6,"name":"O???","code":"o3","unit":"??g/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":7,"name":"O???_8H??????","code":"o3_8h_max","unit":"??g/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":8,"name":"O???_8H","code":"o3_8h","unit":"??g/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":9,"name":"NMHC","code":"nmhc","unit":"??g/m??","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]}]}';
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
  //????????????
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
String text='{"msg":"success","code":200,"data":{"allData":[{"id":1,"name":"??????","type":3,"riverId":null,"areaId":null,"longitude":"116.162804","latitude":"39.904752","status":null,"remark":null,"delStatus":null,"onLineState":2,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":2,"name":"????????????","type":3,"riverId":null,"areaId":null,"longitude":"116.197587","latitude":"39.886816","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":3,"name":"?????????","type":3,"riverId":null,"areaId":null,"longitude":"116.082601","latitude":"39.90607","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":4,"name":"??????","type":3,"riverId":null,"areaId":null,"longitude":"116.062002","latitude":"39.893427","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":20,"name":"?????????","type":3,"riverId":null,"areaId":null,"longitude":"116.121397","latitude":"39.939509","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":21,"name":"???????????????","type":3,"riverId":null,"areaId":null,"longitude":"116.122083","latitude":"39.940035","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":22,"name":"??????????????????","type":3,"riverId":null,"areaId":null,"longitude":"116.137876","latitude":"39.922396","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":23,"name":"????????????","type":3,"riverId":null,"areaId":null,"longitude":"116.149892","latitude":"39.909493","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":24,"name":"?????????","type":3,"riverId":null,"areaId":null,"longitude":"116.152639","latitude":"39.905543","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":25,"name":"??????????????????","type":3,"riverId":null,"areaId":null,"longitude":"116.158475","latitude":"39.896061","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":32,"name":"???????????????","type":3,"riverId":null,"areaId":null,"longitude":"116.208944","latitude":"39.867081","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":33,"name":"?????????","type":3,"riverId":null,"areaId":null,"longitude":"116.208944","latitude":"39.868399","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":49,"name":"?????????","type":3,"riverId":null,"areaId":null,"longitude":"116.209974","latitude":"39.866291","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":50,"name":"?????????","type":3,"riverId":null,"areaId":null,"longitude":"116.248769","latitude":"39.775318","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":51,"name":"?????????","type":3,"riverId":null,"areaId":null,"longitude":"116.256322","latitude":"39.787454","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":52,"name":"26#??????","type":3,"riverId":null,"areaId":null,"longitude":"116.254606","latitude":"39.801172","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":53,"name":"?????????","type":3,"riverId":null,"areaId":null,"longitude":"116.250829","latitude":"39.793258","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":54,"name":"???????????????","type":3,"riverId":null,"areaId":null,"longitude":"116.249456","latitude":"39.772151","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":55,"name":"???????????????(???)","type":3,"riverId":null,"areaId":null,"longitude":"116.225183","latitude":"39.830322","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":6,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":56,"name":"???????????????","type":3,"riverId":null,"areaId":null,"longitude":"116.223363","latitude":"39.83967","status":null,"remark":null,"delStatus":null,"onLineState":1,"busiParkId":null,"rivName":"?????????_????????????","indexId":null,"code":null,"pollutantType":5,"outGauge":"???","cwqiValue":0.0,"waterDataList":null,"areaName":null}],"compare":55.0,"onLineCompare":95.0,"badFive":11,"allNum":20}}';
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
    String text='{"msg":"success","code":200,"data":{"latitude":"39.904752","alarmData":[{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(2.04)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.27)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(1.5)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(12.99)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(792.52)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(328.67)","createTime":"2021-12-29 14:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(11.62)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(499.6)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(897.1)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(8.09)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"??????(8.1)","createTime":"2021-12-29 14:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(7.12)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(204.73)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(665.45)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(9.84)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"??????(9.4)","createTime":"2021-12-29 13:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(2.04)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.31)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(1.14)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(11.5)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(952.22)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(464.52)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(7.2)","createTime":"2021-12-29 13:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(1.39)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(12.61)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(371.17)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(336.67)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(9.27)","createTime":"2021-12-29 12:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(1.14)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"??????(1.99)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(6.77)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(98.4)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(794.06)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(5.6)","createTime":"2021-12-29 12:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.38)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(1.5)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(117.92)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(571.9)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(5.53)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(7.0)","createTime":"2021-12-29 11:20:04","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.36)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(631.83)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(742.17)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(7.93)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(6.5)","createTime":"2021-12-29 11:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(2.04)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(15.07)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(995.36)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(778.64)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(6.7)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(1.35)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(662.45)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(204.35)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(7.06)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"??????(9.5)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.24)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(14.57)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(278.69)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(264.18)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(2.43)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(17.0)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(233.0)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(862.51)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(8.06)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"??????(8.2)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.25)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(762.33)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.27)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(2.45)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(461.82)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(331.88)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(6.1)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(12.47)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(801.55)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(5.6)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(6.95)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(859.76)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(5.91)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(2.13)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.23)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(502.43)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(620.77)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"??????(8.6)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.31)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"??????(1.94)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????????????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????????????????(11.12)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(843.27)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(449.81)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(5.99)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(5.3)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"??????(0.25)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(2.49)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"??????(595.55)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(466.9)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"?????????","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"?????????(9.88)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":1,"fractureName":"??????","indexId":null,"indexName":"??????","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"??????(8.0)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null}],"realtimeData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":["??????(1.04)","??????(4.4)","??????????????????(1.17)"],"indexName":"pollutionIndexName"},{"unit":"???","data":1.1,"indexName":"??????"},{"unit":"?????????","data":"-","indexName":"PH"},{"unit":"mg/L","data":2.75,"indexName":"?????????"},{"unit":"??s/cm","data":328.67,"indexName":"?????????"},{"unit":"NTU","data":792.52,"indexName":"??????"},{"unit":"mg/L","data":12.99,"indexName":"??????????????????"},{"unit":"mg/L","data":1.5,"indexName":"??????"},{"unit":"mg/L","data":0.27,"indexName":"??????"},{"unit":"mg/L","data":2.04,"indexName":"??????"}],"updateTime":"2021-12-29 14:00:00","type":3,"riverName":"?????????_????????????","fraName":"??????","longitude":"116.162804"}}';
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
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"??????","code":"water_temp","unit":"???","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":2,"name":"PH","code":"ph","unit":"?????????","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":3,"name":"?????????","code":"do","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":4,"name":"?????????","code":"ec","unit":"??s/cm","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":5,"name":"??????","code":"turbidity","unit":"NTU","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":6,"name":"??????????????????","code":"kmno4","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":7,"name":"??????","code":"nh3","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":8,"name":"??????","code":"allp","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":9,"name":"??????","code":"alln","unit":"mg/L","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":10,"name":"???????????????","code":"cod","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":11,"name":"?????????????????????","code":"bod5","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":12,"name":"???","code":"cu","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":13,"name":"???","code":"zn","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":14,"name":"?????????","code":"f","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":15,"name":"???","code":"se","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":16,"name":"???","code":"as","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":17,"name":"???","code":"hg","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":18,"name":"???","code":"cd","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":19,"name":"???","code":"cr","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":20,"name":"???","code":"pb","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":21,"name":"?????????","code":"hcn","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":22,"name":"?????????","code":"phenol","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":23,"name":"?????????","code":"oil","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":24,"name":"????????????????????????","code":"negion","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":25,"name":"?????????","code":"sox","unit":"mg/L","status":1,"type":1,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null},{"id":26,"name":"???????????????","code":"coliform","unit":"mg/L","status":1,"type":2,"remark":null,"delStatus":0,"updataUser":null,"updateTime":null,"busiParkId":1,"monthEveryDayCount":null,"alarmList":null}]}';
    waterIndexModel=WaterIndexModel.fromJson(json.decode(text) ) ;

    waterIndexList=waterIndexModel.data!;
    IndexData all=IndexData();
    all.id=-1;
    all.name='????????????';
    waterIndexList.insert(0, all);
  }
  //????????????
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
String text='{"msg":"success","code":200,"data":[{"id":1,"name":"??????1-??????????????????","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.189825","latitude":"39.874413","remark":null,"companyId":null,"delStatus":0,"onLineState":2,"busiParkId":null,"outType":3,"comName":null,"comId":0,"waterTypeName":null},{"id":2,"name":"??????2","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.20621","latitude":"39.86223","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":3,"name":"??????3","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.219433","latitude":"39.880615","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":4,"name":"??????4","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.222021","latitude":"39.854476","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":5,"name":"??????5","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.188388","latitude":"39.889031","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":6,"name":"??????1","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.178327","latitude":"39.892574","remark":null,"companyId":null,"delStatus":0,"onLineState":2,"busiParkId":null,"outType":3,"comName":null,"comId":0,"waterTypeName":null},{"id":7,"name":"??????2","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.178327","latitude":"39.892574","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":8,"name":"??????3","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.233231","latitude":"39.835197","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":9,"name":"??????4","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.209085","latitude":"39.889695","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null},{"id":10,"name":"??????5","type":0,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":"116.167404","latitude":"39.904752","remark":null,"companyId":null,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":1,"comName":null,"comId":0,"waterTypeName":null}]}';
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
    String text='{"msg":"success","code":200,"data":{"outletName":"??????1-??????????????????","outletId":1,"latitude":"39.874413","alarmData":[{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[408.90]???????????????(400.0)","createTime":"2021-12-29 14:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[403.50]???????????????(400.0)","createTime":"2021-12-29 13:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[409.56]???????????????(400.0)","createTime":"2021-12-29 12:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[402.84]???????????????(400.0)","createTime":"2021-12-29 12:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[401.42]???????????????(400.0)","createTime":"2021-12-29 11:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"PM","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM????????????[86.43]???????????????(80.0)","createTime":"2021-12-29 11:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[400.26]???????????????(400.0)","createTime":"2021-12-29 10:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[408.56]???????????????(400.0)","createTime":"2021-12-29 09:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"PM","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM????????????[83.02]???????????????(80.0)","createTime":"2021-12-29 08:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[404.84]???????????????(400.0)","createTime":"2021-12-29 07:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"SO???","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO???????????????[400.65]???????????????(400.0)","createTime":"2021-12-29 07:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[406.73]???????????????(400.0)","createTime":"2021-12-29 06:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[407.76]???????????????(400.0)","createTime":"2021-12-29 05:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[408.36]???????????????(400.0)","createTime":"2021-12-29 04:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[404.73]???????????????(400.0)","createTime":"2021-12-29 02:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":1,"outfallName":null,"indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx????????????[410.28]???????????????(400.0)","createTime":"2021-12-29 01:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null}],"updateTime":"2021-12-29 14:00:00","realtimeData":[{"unit":"??g/m 3","data":"354.97","indexName":"SO???"},{"unit":"??g/m 3","data":"408.90","indexName":"NOx"},{"unit":"??g/m 3","data":"76.56","indexName":"PM"}],"comName":"?????????????????????????????????","type":1,"longitude":"116.189825"}}';
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
    String text='{"msg":"success","code":200,"data":[{"id":null,"areaId":null,"name":null,"longitude":"116.102151","latitude":"39.98286","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.007865","latitude":"39.893016","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.00499","latitude":"39.785758","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.179189","latitude":"39.738723","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.360863","latitude":"39.8168","busiParkId":null},{"id":null,"areaId":null,"name":null,"longitude":"116.325793","latitude":"39.924453","busiParkId":null}],"center":{"id":1,"name":"??????1","longitude":"116.175165","latitude":"39.897002","parkCoordinate":"","remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"areaList":null}}';
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
      // ?????????????????????
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
                       child: Text('??????',style: _daqibiaoshi?textStyle1:textStyle2),),
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
                       child: Text('??????',style: _waterbiaoshi?textStyle1:textStyle2),),
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
                       child: Text('?????????',style: _wuranbiaoshi?textStyle1:textStyle2),),
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
                                 child: Text('   ?????????',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),),),
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
                                 child: Text('   ?????????',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),),),
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
                                 child: Text('   ????????????',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),),),
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
                                 child: Text('   ??????',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),),),
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
                             itemCount: airIndexList.length,//??????
                             // scrollDirection: Axis.vertical,//????????????
                             primary: false,//false????????????????????????????????????????????? ?????????[primary]???true????????????????????????????????????
                             //????????????
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
                       child: Text('??????',style: _daqibiaoshi?textStyle1:textStyle2),),
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
                       child: Text('??????',style: _waterbiaoshi?textStyle1:textStyle2),),
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
                       child: Text('?????????',style: _wuranbiaoshi?textStyle1:textStyle2),),
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
                               itemCount: waterIndexList.length,//??????

                               // scrollDirection: Axis.vertical,//????????????
                               primary: false,//false????????????????????????????????????????????? ?????????[primary]???true????????????????????????????????????
                               //????????????
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
                       child: Text('??????',style: _daqibiaoshi?textStyle1:textStyle2),),
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
                       child: Text('??????',style: _waterbiaoshi?textStyle1:textStyle2),),
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
                       child: Text('?????????',style: _wuranbiaoshi?textStyle1:textStyle2),),
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
//???????????????????????????
  void _loadCustomData() async {
    _customStyleOptions ??= CustomStyleOptions(false);
    ByteData styleByteData = await rootBundle.load('assets/style.data');
    _customStyleOptions.styleData = styleByteData.buffer.asUint8List();
    ByteData styleExtraByteData =
    await rootBundle.load('assets/style_extra.data');
    _customStyleOptions.styleExtraData =
        styleExtraByteData.buffer.asUint8List();
    //?????????????????????????????????????????????????????????????????????setState??????CustomStyleOptions???enable???true
   setState(() {
      _customStyleOptions.enabled = true;

   });
  }
  void _chushiquanxian() async {
    AMapFlutterLocation.setApiKey(
        '787dc18adfa7c2705eb11ab4994061c5', "a57d31271de2c454cc30206974e0ace2");

    /// [hasShow] ?????????????????????????????????????????????
    AMapFlutterLocation.updatePrivacyShow(true, true);

    /// [hasAgree] ?????????????????????????????????????????????
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// ????????????????????????
    requestPermission();

    ///iOS ??????native????????????
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///????????????????????????
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
  ///??????iOS native???accuracyAuthorization??????
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
    await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("??????????????????");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("??????????????????");
    } else {
      print("??????????????????");
    }
  }

  /// ????????????????????????
  void requestPermission() async {
    // ????????????
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("????????????????????????");
      //_startLocation();
    } else {
      print("???????????????????????????");
    }
  }

  /// ??????????????????
  /// ????????????????????????true??? ????????????false
  Future<bool> requestLocationPermission() async {
    //?????????????????????
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //????????????
      return true;
    } else {
      //??????????????????????????????
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
  ///??????????????????
  void _setLocationOption() {
    AMapLocationOption locationOption = AMapLocationOption();

    ///??????????????????
    locationOption.onceLocation = true;

    ///?????????????????????????????????
    locationOption.needAddress = true;

    ///??????????????????????????????
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode =
        AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///??????Android??????????????????????????????
    locationOption.locationInterval = 2000;

    ///??????Android??????????????????<br>
    ///????????????<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///??????iOS??????????????????????????????<br>
    locationOption.distanceFilter = -1;

    ///??????iOS????????????????????????
    /// ????????????<br>
    /// <li>[DesiredAccuracy.Best] ????????????</li>
    /// <li>[DesiredAccuracy.BestForNavigation] ????????????????????????????????? </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10??? </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000???</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000???</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///??????iOS?????????????????????????????????
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///????????????????????????????????????
    _locationPlugin.setLocationOption(locationOption);
  }

  ///????????????
  void _startLocation() {
    if (null != _locationPlugin) {
      ///????????????????????????????????????
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  ///????????????
  void _stopLocation() {
    _locationPlugin.stopLocation();
  }


}