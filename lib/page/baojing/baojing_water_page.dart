import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_huiyuantong/model/baojing/water_index.dart';
import 'package:flutter_huiyuantong/model/baojing/water_section_model.dart';
import 'package:flutter_huiyuantong/model/water_alarm_history_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/drop_down_menu.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:flutter_huiyuantong/util/mydatepicker.dart';
import 'package:flutter_huiyuantong/util/poprote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dropdown/drop_down_water_index_menu.dart';
import 'dropdown/drop_down_water_section_menu.dart';
class BaojingWaterPage extends StatefulWidget{
  @override
  _BaojingWaterPageState createState()=>_BaojingWaterPageState();
}
class _BaojingWaterPageState extends State<BaojingWaterPage>{
  bool _sitepressed = true;
  bool _indexpressed = true;
  bool _typepressed = true;
  String ? timeData=null;
  String duanmian='全部断面';
  String zhibiao='全部指标';
  String leixing='全部类型';
  final List<bool> _isChecks=[];
  late WaterSectionModel waterSectionModel;
  List<WaterSection> waterSectionList =[];
  late WaterIndexModel waterIndexModel;
  List<IndexData> waterIndexList =[];
  late WaterAlarmHistoryModel alarmhistorymodel;
  List<WaterAlarm> AlarmDataList =[];

  var index=1;
  var mydata;

  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false;
  //筛选项选择变量
  String fraId='-1';
  var startTime;
  var endTime;
  var indexId='-1';
  var alarmType='-1';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化方法里面添加监听器
    _waterSectionPost();
    _sitesRealTimedPost();
    _waterIndexGet();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _loadMore();
      }
    });
    startTime='${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day.toString().padLeft(2, '0')}';
    endTime='${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day.toString().padLeft(2, '0')}';
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  Future<void> _waterIndexGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/waterIndex/getIndexList?status=1');
    // var result=await http.get(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization},
    //    );
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
  Future<void> _waterSectionPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/waterFracture/findAllFra');
    // var params = <String, dynamic>{};
    // params["name"] = null;
    // var result=await http.post(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //   body: jsonEncode(params), );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"东店","type":3,"riverId":null,"areaId":null,"longitude":"116.162804","latitude":"39.904752","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":2,"name":"南大荒桥","type":3,"riverId":null,"areaId":null,"longitude":"116.197587","latitude":"39.886816","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":3,"name":"古北口","type":3,"riverId":null,"areaId":null,"longitude":"116.082601","latitude":"39.90607","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":4,"name":"后城","type":3,"riverId":null,"areaId":null,"longitude":"116.062002","latitude":"39.893427","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":20,"name":"辛庄桥","type":3,"riverId":null,"areaId":null,"longitude":"116.121397","latitude":"39.939509","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":21,"name":"鼓楼外大街","type":3,"riverId":null,"areaId":null,"longitude":"116.122083","latitude":"39.940035","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":22,"name":"八间房漫水桥","type":3,"riverId":null,"areaId":null,"longitude":"116.137876","latitude":"39.922396","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":23,"name":"万家码头","type":3,"riverId":null,"areaId":null,"longitude":"116.149892","latitude":"39.909493","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":24,"name":"三岔口","type":3,"riverId":null,"areaId":null,"longitude":"116.152639","latitude":"39.905543","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":25,"name":"于桥水库出口","type":3,"riverId":null,"areaId":null,"longitude":"116.158475","latitude":"39.896061","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":32,"name":"塘汉公路桥","type":3,"riverId":null,"areaId":null,"longitude":"116.208944","latitude":"39.867081","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":33,"name":"大套桥","type":3,"riverId":null,"areaId":null,"longitude":"116.208944","latitude":"39.868399","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":49,"name":"黄白桥","type":3,"riverId":null,"areaId":null,"longitude":"116.209974","latitude":"39.866291","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":50,"name":"黎河桥","type":3,"riverId":null,"areaId":null,"longitude":"116.248769","latitude":"39.775318","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":51,"name":"齐家务","type":3,"riverId":null,"areaId":null,"longitude":"116.256322","latitude":"39.787454","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":52,"name":"26#大桥","type":3,"riverId":null,"areaId":null,"longitude":"116.254606","latitude":"39.801172","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":53,"name":"三小营","type":3,"riverId":null,"areaId":null,"longitude":"116.250829","latitude":"39.793258","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":54,"name":"三河东大桥","type":3,"riverId":null,"areaId":null,"longitude":"116.249456","latitude":"39.772151","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":55,"name":"三河东大桥(老)","type":3,"riverId":null,"areaId":null,"longitude":"116.225183","latitude":"39.830322","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null},{"id":56,"name":"上二道河子","type":3,"riverId":null,"areaId":null,"longitude":"116.223363","latitude":"39.83967","status":null,"remark":null,"delStatus":null,"onLineState":null,"busiParkId":null,"rivName":null,"indexId":null,"code":null,"pollutantType":0,"outGauge":null,"cwqiValue":0.0,"waterDataList":null,"areaName":null}]}';
    waterSectionModel=WaterSectionModel.fromJson(json.decode(text) ) ;
    waterSectionList=waterSectionModel.data!;
    WaterSection all=WaterSection();
    all.id=-1;
    all.name='全部断面';
    waterSectionList.insert(0, all);
    for(int i=0;i<waterSectionList.length;i++){
      _isChecks.add(false);
    }
  }
  Future<void> _sitesRealTimedPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/appWater/qryWaterAlarmData');
    // var params = Map<String, dynamic>();
    // params["pageNum"] = index;
    // params["pageSize"] = 10;
    // params["data"] = {
    //   "fraId":fraId,
    //   "time":timeData,
    //   "startTime":startTime,
    //   "endTime":endTime,
    //   "indexId":indexId,
    //   "alarmType":alarmType,};
    // var result=await http.post(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //   body: jsonEncode(params), );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(utf8decoder.convert(result.bodyBytes)));
    // print(params["data"]);
    // // print('11111'+json.decode(result.body));
    String text='{"msg":"success","code":200,"data":{"totalCount":2177,"pageSize":10,"totalPage":218,"currPage":1,"list":[{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"上二道河子","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(2.46)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"上二道河子","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.28)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"上二道河子","indexId":null,"indexName":"氨氮","alarmType":2,"alarmGrade":2,"limitValue":null,"alarmValue":null,"alarmContent":"氨氮(1.56)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"上二道河子","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(990.17)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"上二道河子","indexId":null,"indexName":"溶解氧","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"溶解氧(5.9)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"三河东大桥(老)","indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":3,"limitValue":null,"alarmValue":null,"alarmContent":"总氮(1.44)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"三河东大桥(老)","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷(0.29)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"三河东大桥(老)","indexId":null,"indexName":"高锰酸盐指数","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"高锰酸盐指数(11.99)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"三河东大桥(老)","indexId":null,"indexName":"浊度","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"浊度(716.76)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null},{"id":null,"riverId":null,"riverName":null,"fractureId":null,"fractureName":"三河东大桥(老)","indexId":null,"indexName":"电导率","alarmType":2,"alarmGrade":1,"limitValue":null,"alarmValue":null,"alarmContent":"电导率(551.82)","createTime":"2021-12-29 15:20:01","busiParkId":null,"indexCode":null,"alarmCount":0,"alarmValueTimes":null,"dataTime":null,"indexCount":null}]}}';
    alarmhistorymodel=WaterAlarmHistoryModel.fromJson(json.decode(text) ) ;
    print(alarmhistorymodel.data!.list);
    setState(() {
      AlarmDataList.addAll(alarmhistorymodel.data!.list);
    });



  }
  // 加载更多布局
  Widget _buildLoadMoreItem() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("加载中……",style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
      ),
    );
  }
  // 加载完成布局
  Widget _buildLoadEndItem() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("暂无数据",style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
      ),
    );
  }
// 下拉刷新方法
  Future<Null> _handleRefresh() async {
    setState(() {
      AlarmDataList.clear();
      index=1;
      _sitesRealTimedPost();
    });

  }
// 上拉加载
  Future<Null> _loadMore() async {

    if (!isLoading) {
      setState(() => isLoading = true);
      setState(() {
        ++index;
        isLoading = false;
        _sitesRealTimedPost();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color.fromRGBO(1, 20, 43, 1),width: 0.0)),
            gradient: LinearGradient(
              colors: [ Color.fromRGBO(6, 36, 66, 1),Color.fromRGBO(16, 56, 95, 1),Color.fromRGBO(1, 20, 43, 1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0,0.5,1],
            )
        ),

        child: Column(
          children: [
            Row(
              children: [
                _siteDownButton(),
                _indexDownButton(),
                _typeDownButton(),
              ],
            ),
            Row(children: [
              InkWell(
                  onTap: (){
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return MyDatePicker(
                            endYear: DateTime.now().year,
                            selectedDate: null,
                            onSelectedDate: (String startDate,String endDate) {

                              startTime=startDate;
                              endTime=endDate;
                              AlarmDataList.clear();
                              index=1;
                              _sitesRealTimedPost();

                              Navigator.pop(context);
                            },);
                        });

                  },
                  child: Row(children: [
                    SizedBox(width: Adapt.px(32),),
                    Text('$startTime',style: TextStyle(
                      color: Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32),)),
                    SizedBox(width: Adapt.px(16),),
                    Text('至',style: TextStyle(
                      color: Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32),)),
                    SizedBox(width: Adapt.px(16),),
                    Text('$endTime',style: TextStyle(
                      color: Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32),)),
                    SizedBox(width: Adapt.px(16),),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(185, 233, 255, 1),
                      size: Adapt.px(32),)
                  ],))
            ],),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: Adapt.px(32), right: Adapt.px(32)),
              child: RefreshIndicator(
                  child:ListView.separated(
                      itemCount: AlarmDataList.length+1,//个数
                      controller: _scrollController,  //注册监听器
                      // itemExtent:  Adapt.px(477),//行高
                      // scrollDirection: Axis.vertical,//滑动方向
                      // primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                      // //内容适配
                      // shrinkWrap: true,
                      separatorBuilder: (BuildContext context, int index) =>
                          Container(
                            height: Adapt.px(24),
                            color: Colors.transparent,
                          ),
                      itemBuilder:(BuildContext context,int index){
                        if(AlarmDataList.isEmpty || index>alarmhistorymodel.data!.totalCount!.toInt()){
                          return _buildLoadEndItem();
                        }else{
                          if (index == AlarmDataList.length) {
                            return _buildLoadMoreItem();
                          } else {
                            // 最后一项，显示加载更多布局
                            return getAlarmListViewItem(AlarmDataList[index]);
                          }}

                      }), onRefresh: _handleRefresh),),
            ),


          ],
        ),
      ),
    );
  }
  Widget _siteDownButton() {
    TextStyle textStyle1 = TextStyle(
      color: const Color.fromRGBO(185, 233, 255, 1),
      fontSize: Adapt.px(28),);
    TextStyle textStyle2 = TextStyle(
      color: const Color.fromRGBO(46, 228, 149, 1),
      fontSize: Adapt.px(28),);
    Icon icon1 = Icon(
      Icons.keyboard_arrow_down,
      color: Color.fromRGBO(185, 233, 255, 1),
      size: Adapt.px(32),);
    Icon icon2 = Icon(
      Icons.keyboard_arrow_up_sharp,
      color: Color.fromRGBO(46, 228, 149, 1),
      size: Adapt.px(32),);
    return InkWell(
      child: Container(
          width: Adapt.px(250),
          height: Adapt.px(96),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Adapt.px(116),
                child: Text(duanmian, style: _sitepressed ? textStyle1 : textStyle2,overflow: TextOverflow.ellipsis,),),
              SizedBox(width: Adapt.px(12),),
              _sitepressed ? icon1 : icon2
            ],)),
      onTap: () {
        _showSectionMenu();
        setState(() {
          _sitepressed = !_sitepressed;
        });
      },
    );
  }
  _showSectionMenu() {
    Navigator.push(context, PopRoute(DropDownWaterSectionMenu(waterSectionList,_isChecks))).then((value) => setState(() {
      print(value);
      if(value=='out'){
        _sitepressed = !_sitepressed;
      }else{
        fraId=value['id'];
        duanmian=value['name'];
        AlarmDataList.clear();
        index = 1;
        _sitesRealTimedPost();
        _sitepressed = !_sitepressed;}
    }));
  }
  Widget _indexDownButton() {
    TextStyle textStyle1 = TextStyle(
      color: const Color.fromRGBO(185, 233, 255, 1),
      fontSize: Adapt.px(28),);
    TextStyle textStyle2 = TextStyle(
      color: const Color.fromRGBO(46, 228, 149, 1),
      fontSize: Adapt.px(28),);
    Icon icon1 = Icon(
      Icons.keyboard_arrow_down,
      color: Color.fromRGBO(185, 233, 255, 1),
      size: Adapt.px(32),);
    Icon icon2 = Icon(
      Icons.keyboard_arrow_up_sharp,
      color: Color.fromRGBO(46, 228, 149, 1),
      size: Adapt.px(32),);
    return InkWell(
      child: Container(
          width: Adapt.px(250),
          height: Adapt.px(96),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Adapt.px(116),
                child: Text(zhibiao, style: _sitepressed ? textStyle1 : textStyle2,overflow: TextOverflow.ellipsis,),),
              SizedBox(width: Adapt.px(12),),
              _indexpressed ? icon1 : icon2
            ],)),
      onTap: () {
        _showDropDownIndexMenu();
        setState(() {
          _indexpressed = !_indexpressed;
        });
      },
    );
  }
  _showDropDownIndexMenu() {
    Navigator.push(context, PopRoute(DropDownWaterIndexMenu(waterIndexList))).then((value) => setState(() {

      if(value=='out'){
        _indexpressed = !_indexpressed;
      }else{
        indexId=value.id.toString();
         zhibiao=value.name.toString();
        AlarmDataList.clear();
        index = 1;
        _sitesRealTimedPost();
        _indexpressed = !_indexpressed;}
    }));
  }
  Widget _typeDownButton() {
    TextStyle textStyle1 = TextStyle(
      color: const Color.fromRGBO(185, 233, 255, 1),
      fontSize: Adapt.px(28),);
    TextStyle textStyle2 = TextStyle(
      color: const Color.fromRGBO(46, 228, 149, 1),
      fontSize: Adapt.px(28),);
    Icon icon1 = Icon(
      Icons.keyboard_arrow_down,
      color: Color.fromRGBO(185, 233, 255, 1),
      size: Adapt.px(32),);
    Icon icon2 = Icon(
      Icons.keyboard_arrow_up_sharp,
      color: Color.fromRGBO(46, 228, 149, 1),
      size: Adapt.px(32),);
    return InkWell(
      child: Container(
          width: Adapt.px(250),
          height: Adapt.px(96),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(leixing, style: _typepressed ? textStyle1 : textStyle2),
              SizedBox(width: Adapt.px(12),),
              _typepressed ? icon1 : icon2
            ],)),
      onTap: () {
        _showDropDownMenu();
        setState(() {

          _typepressed = !_typepressed;
        });
      },
    );
  }
  _showDropDownMenu() {
    Navigator.push(context, PopRoute(DropDownMenu())).then((value) => setState(() {
      if(value=='out'){
        _typepressed = !_typepressed;
      }else{
        alarmType=value;
        if(value=='-1'){
          leixing='全部类型';
        }else if(value=='0'){
          leixing='零值报警';
        }else if(value=='1'){
          leixing='缺失报警';
        }else if(value=='2'){
          leixing='超标报警';
        }
        AlarmDataList.clear();
        index = 1;
        _sitesRealTimedPost();
        _typepressed = !_typepressed;}
    }));
  }

}
Widget getAlarmListViewItem(WaterAlarm alarm) {
  return Container(
    decoration:  BoxDecoration(
        color: const Color.fromRGBO(185, 233, 255, 0.05),
        borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
    ),
    width: Adapt.px(686),


    child: Column(
      children: [
        SizedBox(height: Adapt.px(32),),
        IntrinsicHeight(child: Row(
          children: [
            SizedBox(width:Adapt.px(32)),
            imageItem(alarm),
            SizedBox(width:Adapt.px(16)),
            Text(alarm.fractureName??'-'.toString(), style: TextStyle(
                color:  Color.fromRGBO(185, 233, 255, 1),
                fontSize: Adapt.px(32)),
            ),
          ],
        ),),


        SizedBox(height: Adapt.px(32),),
        Row(children: [
          SizedBox(width:Adapt.px(32)),
          Text('报警指标：', style: TextStyle(
              color:  Color.fromRGBO(185, 233, 255, 1),
              fontSize: Adapt.px(24)),
          ),
          Text(alarm.indexName??"-".toString(), style: TextStyle(
              color:  Color.fromRGBO(255, 255, 255, 1),
              fontSize: Adapt.px(24)),
          ),
        ],),
        SizedBox(height: Adapt.px(16),),
        IntrinsicHeight(child:Row(
          children: [
            SizedBox(width:Adapt.px(32)),
            Text('报警内容：', style: TextStyle(
                color:  Color.fromRGBO(185, 233, 255, 1),
                fontSize: Adapt.px(24)),
            ),
            Container(
              width: Adapt.px(502),
              child: Text(
                alarm.alarmContent??"-".toString(),
                style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
              ),
            ),
          ],
        ),),
        SizedBox(height: Adapt.px(16),),
        Row(children: [
          SizedBox(width:Adapt.px(32)),
          Text('报警时间：', style: TextStyle(
              color:  Color.fromRGBO(185, 233, 255, 1),
              fontSize: Adapt.px(24)),
          ),
          Text(alarm.createTime??"-".toString(), style: TextStyle(
              color:  Color.fromRGBO(255, 255, 255, 1),
              fontSize: Adapt.px(24)),
          ),
        ],),
        SizedBox(height: Adapt.px(36),),


      ],
    ),
    // 下边框
    // decoration: const BoxDecoration(
    //     border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 0.1)))
    // ),
  ) ;
}
Image imageItem(WaterAlarm alarm) {

  if(alarm.alarmType==2){
    if(alarm.alarmGrade==4){
      return Image(
        image: const AssetImage('images/alarmred.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else if(alarm.alarmGrade==3){
      return Image(
        image: const AssetImage('images/alarmorange.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else if(alarm.alarmGrade==2){
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