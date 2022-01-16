import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_details_model.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';
import 'package:flutter_huiyuantong/model/water_section_details_model.dart';
import 'package:flutter_huiyuantong/page/air_parameter_history.dart';
import 'package:flutter_huiyuantong/page/water_alarm_history.dart';
import 'package:flutter_huiyuantong/page/water_para_history.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'air_alarm_history.dart';
class WaterSectionDetails extends StatefulWidget{
  final String fraId;

  const WaterSectionDetails( this.fraId,   {Key? key}) : super(key: key);
  @override
  _WaterSectionDetailsState createState()=>_WaterSectionDetailsState();
}
class _WaterSectionDetailsState extends State<WaterSectionDetails>{
  var waterdetailsmodel;
  late List<WaterRealtimeData> RealtimeDataList ;
  late List<WaterAlarmData> AlarmDataList ;

  Future<WaterDetailsModel> alarmRealTimedGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // print('${HttpUtil.url}/api/appWater/qryWaterFraDetail?fraId=${widget.fraId}');
    // var url = Uri.parse('${HttpUtil.url}/api/appWater/qryWaterFraDetail?fraId=${widget.fraId}');
    // var result=await http.get(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // waterdetailsmodel=WaterDetailsModel.fromJson(json.decode(utf8decoder.convert(result.bodyBytes)));
    String text='{"msg":"success","code":200,"data":{"latitude":"39.866291","alarmData":[{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(2.31)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(12.97)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(731.72)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(582.2)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(7.6)","createTime":"2021-12-29 10:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.26)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(2.19)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(526.27)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(421.61)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(5.46)","createTime":"2021-12-29 09:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(1.82)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.22)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.74)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(598.49)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(434.26)","createTime":"2021-12-29 08:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.21)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(7.68)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(799.85)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(768.71)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(6.36)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(6.6)","createTime":"2021-12-29 07:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(2.04)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.24)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(961.06)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(564.82)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(8.0)","createTime":"2021-12-29 06:20:03","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(1.66)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.34)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.72)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(808.52)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(935.81)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(9.0)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(7.8)","createTime":"2021-12-29 05:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(1.96)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(2.06)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(9.71)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(946.11)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(712.27)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(9.63)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(7.5)","createTime":"2021-12-29 04:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.24)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.96)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(773.81)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(576.33)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(8.26)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"水温(7.5)","createTime":"2021-12-29 03:20:00","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(1.88)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.8)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(14.05)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(539.63)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(538.51)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(6.15)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"水温(8.3)","createTime":"2021-12-29 02:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(2.34)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(8.86)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(340.83)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(8.23)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"水温","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"水温(8.9)","createTime":"2021-12-29 01:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.79)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(16.61)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(470.16)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":49,"fractureName":"黄白桥","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(400.04)","createTime":"2021-12-29 00:20:02","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null}],"realtimeData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":["氨氮(1.31)","高锰酸盐指数(1.16)","溶解氧(-0.31)"],"indexName":"pollutionIndexName"},{"unit":"℃","data":7.6,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":3.43,"indexName":"溶解氧"},{"unit":"μs/cm","data":582.2,"indexName":"电导率"},{"unit":"NTU","data":731.72,"indexName":"浊度"},{"unit":"mg/L","data":12.97,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":2.31,"indexName":"氨氮"},{"unit":"mg/L","data":0.03,"indexName":"总磷"},{"unit":"mg/L","data":0.77,"indexName":"总氮"}],"updateTime":"2021-12-29 10:00:00","type":3,"riverName":"天津市_海河流域","fraName":"黄白桥","longitude":"116.209974"}}';
    waterdetailsmodel=WaterDetailsModel.fromJson(json.decode(text));
    RealtimeDataList=waterdetailsmodel.data.realtimeData;
    AlarmDataList=waterdetailsmodel.data.alarmData;


    return waterdetailsmodel;
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
          title: Text('断面详情',style: TextStyle(
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
              builder: (BuildContext context, AsyncSnapshot<WaterDetailsModel> snapshot){
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
                            height: Adapt.px(354),
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
                                    Text(waterdetailsmodel.data.fraName??'-'.toString(), style: TextStyle(
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
                                    Text('${waterdetailsmodel.data.longitude??'-'},${waterdetailsmodel.data.latitude??'-'}', style: TextStyle(
                                        color:  Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Adapt.px(24),),
                                Row(
                                  children: [
                                    SizedBox(width:Adapt.px(32)),
                                    Text('所属河流：', style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                    Text(waterdetailsmodel.data.riverName??'-'.toString(), style: TextStyle(
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
                                    Text(waterdetailsmodel.data.updateTime??'-'.toString(), style: TextStyle(
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

                            // height: Adapt.px(RealtimeDataList.length*85+85),
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  WaterParaHistory(widget.fraId)));
                                        },
                                        child:  Text('历史数据>', style: TextStyle(
                                            color:  const Color.fromRGBO(46, 228, 149, 1),
                                            fontSize: Adapt.px(28)),),
                                      ),


                                    ],
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    minWidth: Adapt.px(686),
                                    minHeight: Adapt.px(RealtimeDataList.length*85),
                                    maxHeight: Adapt.px(RealtimeDataList.length*121),
                                    maxWidth: Adapt.px(686),
                                  ),
                                  child:ListView.builder(
                                      itemCount: RealtimeDataList.length,//个数
                                      //itemExtent: Adapt.px(85),//行高
                                      // scrollDirection: Axis.vertical,//滑动方向
                                      primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                                      //内容适配
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),//禁止滚动

                                      itemBuilder:(BuildContext context,int index){
                                        return getRealtimeDataListListViewItem(RealtimeDataList[index]);
                                      }),
                                ),
                                SizedBox(height: Adapt.px(24),),

                              ],
                            ),
                          ),
                          SizedBox(height: Adapt.px(24),),
                          Container(
                            decoration:  BoxDecoration(
                                color: const Color.fromRGBO(185, 233, 255, 0.05),
                                borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: Adapt.px(43),),
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  WaterAlarmHistory(widget.fraId)));
                                        },
                                        child:  Text('历史数据>', style: TextStyle(
                                            color:  const Color.fromRGBO(46, 228, 149, 1),
                                            fontSize: Adapt.px(28)),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                                Container(
                                  constraints: BoxConstraints(
                                    minWidth: Adapt.px(686),
                                    minHeight: Adapt.px(AlarmDataList.length*167),
                                    maxHeight: Adapt.px(AlarmDataList.length*203),
                                    maxWidth: Adapt.px(686),
                                  ),
                                  child:  ListView.builder(
                                      itemCount: AlarmDataList.length,//个数
                                      //行高
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

Widget getRealtimeDataListListViewItem(WaterRealtimeData waterrealtimedata) {
  if(waterrealtimedata.indexName=='waterType'){
    waterrealtimedata.indexName='水质类别';
  }else if(waterrealtimedata.indexName=='pollutionIndexName'){
    waterrealtimedata.indexName='主要污染指标';
    // waterrealtimedata.data= listToString(waterrealtimedata) ;
  }
  if(waterrealtimedata.data=='6'){
    waterrealtimedata.data='劣V类';
  }else if(waterrealtimedata.data=='5'){
    waterrealtimedata.data='V类';
  }else if(waterrealtimedata.data=='4'){
    waterrealtimedata.data='IV类';
  }else if(waterrealtimedata.data=='3'){
    waterrealtimedata.data='III类';
  }else if(waterrealtimedata.data=='2'){
    waterrealtimedata.data='II类';
  }else if(waterrealtimedata.data=='1'){
    waterrealtimedata.data='I类';
  }
  return Container(

    width: Adapt.px(686),

    child:Column(

      children: [
        SizedBox(height: Adapt.px(24), ),
        Container(

          width: Adapt.px(622),
          child:   IntrinsicHeight(
            child:  Row(
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
                      child: Text(waterrealtimedata.indexName??'-'.toString(),style:  TextStyle(
                          color:  Color.fromRGBO(185, 233, 255, 0.75),
                          fontSize: Adapt.px(24)),),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Adapt.px(400),
                  child:  Text(
                    "${waterrealtimedata.data??'-'}${waterrealtimedata.unit??'-'.toString()}",

                    style:  TextStyle(
                        color:  Color.fromRGBO(255, 255, 255, 1),
                        fontSize: Adapt.px(24)),),
                ),

              ],
            ),),

        ),
        SizedBox(height: Adapt.px(24), ),
        Divider(indent: Adapt.px(32),endIndent: Adapt.px(32),height: Adapt.px(1),color: Color.fromRGBO(255, 255, 255, 0.1))
      ],
    ),


  ) ;
}
Widget getAlarmListViewItem(WaterAlarmData wateralarmdata) {
  return Container(

    width: Adapt.px(686),

    child: Column(
      children: [
        SizedBox(height: Adapt.px(32),),
        Container(
          width: Adapt.px(622),
          height: Adapt.px(48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  imageItem(wateralarmdata),
                  SizedBox(width:Adapt.px(16)),
                  Text(wateralarmdata.indexName.toString(), style: TextStyle(
                      color:  Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32)),
                  ),
                ],
              ),
              Text(wateralarmdata.createTime??"-".toString(), style: TextStyle(
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
                wateralarmdata.alarmContent??"-".toString(),
                style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),),

        SizedBox(height: Adapt.px(32),),
        Divider(indent: Adapt.px(32),endIndent: Adapt.px(32),height: Adapt.px(1),color: Color.fromRGBO(255, 255, 255, 0.1)),

      ],
    ),
    // 下边框
    // decoration: const BoxDecoration(
    //     border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 0.1)))
    // ),
  ) ;
}
Image imageItem(WaterAlarmData alarmdata) {
  if(alarmdata.alarmType=='2'){
    if(alarmdata.alarmGrade=='4'){
      return Image(
        image: const AssetImage('images/alarmred.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else if(alarmdata.alarmGrade=='3'){
      return Image(
        image: const AssetImage('images/alarmorange.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else if(alarmdata.alarmGrade=='2'){
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
String? listToString(List<String> list) {
  if (list == null) {
    return null;
  }
  String ? result;
  list.forEach((string) =>
  {if (result == null) result = string else result = '$result，$string'});
  return result.toString();
}