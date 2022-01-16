import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_details_model.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';
import 'package:flutter_huiyuantong/page/air_parameter_history.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'air_alarm_history.dart';
class AirSiteDetails extends StatefulWidget{
  final String sn;
  // final String deviceTypeName;
  // final String regionName;
  const AirSiteDetails( this.sn,   {Key? key}) : super(key: key);
  @override
  _AirSiteDetailsState createState()=>_AirSiteDetailsState();
}
class _AirSiteDetailsState extends State<AirSiteDetails>{
  var airsitedetailsmodel;
  late List<RealtimeData> RealtimeDataList ;
  late List<AlarmData> AlarmDataList ;
  late Map<String,String> a={'1':'23','2':'34'} ;

  Future<AirSiteDetailsModel> alarmRealTimedGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // print('http://39.105.58.216:13001/api/countryDataDay/appQryDevDetail?sn=${widget.sn}');
    // var url = Uri.parse('http://39.105.58.216:13001/api/countryDataDay/appQryDevDetail?sn=${widget.sn}');
    // var result=await http.get(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":{"deviceData":{"sn":null,"name":"恶臭04","regionId":3,"devType":4,"devLongitude":"116.069955","devLatitude":"39.836306","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":"2021-12-28 17:20:04","delStatus":0,"busiParkId":null,"typeName":"恶臭","regionName":"区域0003","pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},"alarmData":[{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[101.85]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[78.05]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[56.08]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[58.52]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[71.41]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[119.43]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[74.08]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[99.67]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[84.35]超过标准值(50.0)","createTime":"2021-12-28 17:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[105.38]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[85.51]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[53.63]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[71.0]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[113.51]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[107.0]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[99.44]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[107.92]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[87.03]超过标准值(50.0)","createTime":"2021-12-28 16:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[257.41]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[194.62]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[134.05]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[197.04]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[222.51]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[137.12]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[217.89]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[276.7]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[201.54]超过标准值(50.0)","createTime":"2021-12-28 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[338.59]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[370.41]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[321.72]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[287.96]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[325.46]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[313.29]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[385.48]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[397.17]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[365.03]超过标准值(50.0)","createTime":"2021-12-28 13:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[313.66]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[295.74]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[376.46]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[296.08]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[348.42]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[313.73]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[389.64]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[327.16]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[355.42]超过标准值(50.0)","createTime":"2021-12-28 12:20:05","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[169.67]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[260.29]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[171.04]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[184.7]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[265.29]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[148.36]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[251.01]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[191.76]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[184.27]超过标准值(50.0)","createTime":"2021-12-28 11:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[258.01]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[242.54]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[265.61]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[132.22]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[192.49]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[215.91]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[222.92]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[270.48]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[257.73]超过标准值(50.0)","createTime":"2021-12-28 10:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[61.14]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[87.89]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[90.76]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[81.47]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[75.71]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[86.71]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[110.93]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[54.93]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[61.84]超过标准值(50.0)","createTime":"2021-12-28 09:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[69.38]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[115.62]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[113.2]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[116.6]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[100.02]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[55.69]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[68.73]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[80.24]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[75.07]超过标准值(50.0)","createTime":"2021-12-28 05:20:04","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[308.87]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[387.28]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[383.15]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[297.28]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[296.71]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[358.79]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[285.16]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[286.86]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[335.4]超过标准值(50.0)","createTime":"2021-12-28 03:20:02","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[73.19]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[92.08]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[112.32]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[50.82]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[70.14]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[78.11]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[116.18]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[85.73]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":"300090024","deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[93.35]超过标准值(50.0)","createTime":"2021-12-28 00:20:01","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null}],"realtimeData":[{"unit":"mg/m³","data":84.35,"indexName":"NH₃"},{"unit":"mg/m³","data":99.67,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":101.85,"indexName":"H₂S"},{"unit":"mg/m³","data":74.08,"indexName":"CH₄S"},{"unit":"mg/m³","data":119.43,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":71.41,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":58.52,"indexName":"CS₂"},{"unit":"µg/m³","data":56.08,"indexName":"C₈H₈"},{"unit":"µg/m³","data":78.05,"indexName":"OU"}]}}';
    //print(json.decode(utf8decoder.convert(result.bodyBytes)));
    airsitedetailsmodel=AirSiteDetailsModel.fromJson(json.decode(text));
    RealtimeDataList=airsitedetailsmodel.data.realtimeData;
    AlarmDataList=airsitedetailsmodel.data.alarmData;


    return airsitedetailsmodel;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(6, 36, 66, 1),
          title: Text('站点详情',style: TextStyle(
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
          child: FutureBuilder(future: alarmRealTimedGet(),
              builder: (BuildContext context, AsyncSnapshot<AirSiteDetailsModel> snapshot){
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
                      return ListView(
                        children: [
                          SizedBox(height: Adapt.px(24),),
                          //基本信息
                          Container(
                            width: Adapt.px(686),
                            height: Adapt.px(414),
                            decoration:  BoxDecoration(
                                color: const Color.fromRGBO(185, 233, 255, 0.05),
                                borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: Adapt.px(24),),
                                Row(
                                  children: [
                                    SizedBox(width:Adapt.px(32)),
                                    Text('基本信息', style: TextStyle(
                                        color:  const Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(28)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Adapt.px(40),),
                                Row(
                                  children: [
                                    SizedBox(width:Adapt.px(32)),
                                    Text('名称：', style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                    Text(airsitedetailsmodel.data.deviceData.name??'-'.toString(), style: TextStyle(
                                        color:  Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Adapt.px(24),),
                                Row(
                                  children: [
                                    SizedBox(width:Adapt.px(32)),
                                    Text('站点类型：', style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                    Text(airsitedetailsmodel.data.deviceData.typeName??'-'.toString(), style: TextStyle(
                                        color:  Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Adapt.px(24),),
                                Row(
                                  children: [
                                    SizedBox(width:Adapt.px(32)),
                                    Text('经纬度：', style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                    Text('${airsitedetailsmodel.data.deviceData.devLongitude??'-'},${airsitedetailsmodel.data.deviceData.devLatitude??'-'}', style: TextStyle(
                                        color:  Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Adapt.px(24),),
                                Row(
                                  children: [
                                    SizedBox(width:Adapt.px(32)),
                                    Text('所属地区：', style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                    Text(airsitedetailsmodel.data.deviceData.regionName??'-'.toString(), style: TextStyle(
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
                                    Text(airsitedetailsmodel.data.deviceData.updateTime??'-'.toString(), style: TextStyle(
                                        color:  Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: Adapt.px(24),),
                          //实时参数信息
                          Container(
                            width: Adapt.px(686),
                            height: Adapt.px((RealtimeDataList.length/2+1)*100),
                            decoration:  BoxDecoration(
                                color: const Color.fromRGBO(185, 233, 255, 0.05),
                                borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: Adapt.px(24),),
                                Container(
                                  width: Adapt.px(622),
                                  height: Adapt.px(42),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text('实时参数信息', style: TextStyle(
                                          color:  const Color.fromRGBO(185, 233, 255, 1),
                                          fontSize: Adapt.px(28)),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  ParaHistory(widget.sn,airsitedetailsmodel.data.deviceData.devType.toString())));
                                        },
                                        child:  Text('历史数据>', style: TextStyle(
                                            color:  const Color.fromRGBO(46, 228, 149, 1),
                                            fontSize: Adapt.px(28)),),
                                      ),


                                    ],
                                  ),
                                ),
                                Expanded(

                                  child: Container(
                                    width:  Adapt.px(624),
                                    child:GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    //padding: EdgeInsets.fromLTRB(Adapt.px(32), Adapt.px(40), Adapt.px(32), Adapt.px(40)),
                                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      //纵轴间距
                                      mainAxisSpacing:Adapt.px(0),
                                      //横轴间距
                                      crossAxisSpacing: Adapt.px(66),
                                      //子组件宽高长度比例
                                      childAspectRatio: 2.79,
                                    ),
                                    itemBuilder: (BuildContext context, int index) {
                                      return getGridViewItem(RealtimeDataList[index]);
                                    },
                                    itemCount: RealtimeDataList.length,),)
                                  ),
                                SizedBox(height: Adapt.px(24),),

                              ],
                            ),
                          ),
                          SizedBox(height: Adapt.px(24),),
                          Container(
                            width: Adapt.px(686),
                            height: Adapt.px(AlarmDataList.length*202+85),
                            decoration:  BoxDecoration(
                                color: const Color.fromRGBO(185, 233, 255, 0.05),
                                borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: Adapt.px(24),),
                                Container(
                                  width: Adapt.px(622),
                                  height: Adapt.px(42),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text('当日报警', style: TextStyle(
                                          color:  const Color.fromRGBO(185, 233, 255, 1),
                                          fontSize: Adapt.px(28)),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  AlarmHistory(widget.sn)));
                                        },
                                        child:  Text('历史数据>', style: TextStyle(
                                            color:  const Color.fromRGBO(46, 228, 149, 1),
                                            fontSize: Adapt.px(28)),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                                Expanded(

                                    child:ListView.builder(
                                        itemCount: AlarmDataList.length,//个数

                                        // scrollDirection: Axis.vertical,//滑动方向
                                        primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                                        //内容适配
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),//禁止滚动

                                        itemBuilder:(BuildContext context,int index){
                                          return getAlarmListViewItem(AlarmDataList[index]);
                                        }),
                                ),
                                SizedBox(height: Adapt.px(24),),

                              ],
                            ),

                          ),
                        ],
                      );
                    }
                }
              }
          ),

        )

    );
  }

}
Widget getGridViewItem(RealtimeData realtimedata) {
  return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(width: Adapt.px(2), color: Color.fromRGBO(255, 255, 255, 0.1)),
      //   ),
      // ),
    width: Adapt.px(279),
    height: Adapt.px(102),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: Adapt.px(12),
              height: Adapt.px(12),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(46, 228, 149, 1),
                  borderRadius: BorderRadius.all(Radius.circular(Adapt.px(6)))
              ),
            ),
            SizedBox(width: Adapt.px(10), ),
            Container(
              child: Text(realtimedata.indexName??'-'.toString(),style:  TextStyle(
                  color:  Color.fromRGBO(185, 233, 255, 0.75),
                  fontSize: Adapt.px(24)),),
            ),
          ],
        ),
        Text(
            "${realtimedata.data??'-'.toString()}${realtimedata.unit??'-'.toString()}",
            maxLines: 1,overflow: TextOverflow.ellipsis,
            style:  TextStyle(
              color:  Color.fromRGBO(255, 255, 255, 1),
              fontSize: Adapt.px(24)),),
      ],
    )
  ) ;
}
Widget getAlarmListViewItem(AlarmData alarmdata) {
  return Container(

    width: Adapt.px(686),
    child: Column(
      children: [
        SizedBox(height: Adapt.px(38),),
        Container(
          width: Adapt.px(622),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
    children: [
      imageItem(alarmdata),
      SizedBox(width:Adapt.px(16)),
      Text(alarmdata.indexName.toString(), style: TextStyle(
          color:  Color.fromRGBO(185, 233, 255, 1),
          fontSize: Adapt.px(32)),
      ),
    ],
  ),
              Text(alarmdata.createTime??"-".toString(), style: TextStyle(
                  color:  Color.fromRGBO(185, 233, 255, 1),
                  fontSize: Adapt.px(24)),
              ),
            ],
          ),
        ),

        SizedBox(height: Adapt.px(18),),
        IntrinsicHeight(child:Row(
          children: [
            SizedBox(width:Adapt.px(83)),
            Container(
              width: Adapt.px(571),
              child: Text(
                alarmdata.alarmContent??"-".toString(),
                style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),),

        SizedBox(height: Adapt.px(24),),
        Divider(indent: Adapt.px(32),endIndent: Adapt.px(32),height: Adapt.px(2),color: Color.fromRGBO(255, 255, 255, 0.1)),

      ],
    ),
    // 下边框
    // decoration: const BoxDecoration(
    //     border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 0.1)))
    // ),
  ) ;
}
Image imageItem(AlarmData alarmdata) {
  if(alarmdata.alarmType==2){
    if(alarmdata.alarmGrade==4){
      return Image(
        image: const AssetImage('images/alarmred.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else if(alarmdata.alarmGrade==3){
      return Image(
        image: const AssetImage('images/alarmorange.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else if(alarmdata.alarmGrade==2){
      return Image(
        image: const AssetImage('images/alarmyellow.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else {
      return Image(
        image: const AssetImage('images/alarmblue.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }

  }else {
    return Image(
      image: const AssetImage('images/alarmgrew.png'), width: Adapt.px(36), height: Adapt.px(36),);
  }
}