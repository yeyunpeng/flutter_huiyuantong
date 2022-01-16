import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_huiyuantong/model/alarm_history_model.dart';
import 'package:flutter_huiyuantong/model/baojing/air_index_model.dart';
import 'package:flutter_huiyuantong/model/baojing/air_site_model.dart';
import 'package:flutter_huiyuantong/model/baojing/air_site_type_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/drop_down_menu.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:flutter_huiyuantong/util/mydatepicker.dart';
import 'package:flutter_huiyuantong/util/poprote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dropdown/drop_down_air_index_menu.dart';
import 'dropdown/drop_down_air_site_menu.dart';
class BaojingDaQiPage extends StatefulWidget{
  const BaojingDaQiPage({Key? key}) : super(key: key);

  @override
  _BaojingDaQiPageState createState()=>_BaojingDaQiPageState();
}
class _BaojingDaQiPageState extends State<BaojingDaQiPage> {
  bool _sitepressed = true;
  bool _indexpressed = true;
  bool _typepressed = true;
  String ? timeData = null;
  String zhandian='全部站点';
  String zhibiao='全部指标';
  String leixing='全部类型';

  //开始筛选
  late AirSiteTypeModel airSiteTypeModel;
   List<SiteTypeData> IndexTypelist=[];
   List<SiteTypeData> SiteTypelist=[];
  late AirSiteModel airSiteModel;
  late AirIndexModel airIndexModel;
  List<Airshebei> allTrueSiteList=[];
  //全部
   List<Airshebei> allsiteList=[];
   List<bool> allschecks=[];
   List<AirIndexData> alliindexList=[];
    List<bool> allichecks=[];
  //国标
   List<Airshebei> gbsiteList=[];
   List<bool> gbschecks=[];
   List<AirIndexData> gbIndexList=[];
   List<bool> gbichecks=[];
  //网格
   List<Airshebei> wgsiteList=[];
   List<bool> wgschecks=[];
   List<AirIndexData> wgIndexList=[];
   List<bool> wgichecks=[];
  //有毒
   List<Airshebei> ydsiteList=[];
   List<bool> ydschecks=[];
   List<AirIndexData> ydIndexList=[];
   List<bool> ydichecks=[];
  //恶臭
   List<Airshebei> ecsiteList=[];
   List<bool> ecschecks=[];
   List<AirIndexData> ecIndexList=[];
   List<bool> ecichecks=[];

  late AlarmHistoryModel alarmhistorymodel;
  var index = 1;
  var mydata;
  List<Alarm> AlarmDataList = [];
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false;

  //筛选项选择变量
  String sn = '-1';
  var startTime;
  var endTime;
  var indexId;
  var alarmType = '-1';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Airshebei ashebei=Airshebei();
    ashebei.sn='-1';
    ashebei.name='全部站点';
    allsiteList.add(ashebei);
    allschecks.add(false);
    gbsiteList.add(ashebei);
    gbschecks.add(false);
    wgsiteList.add(ashebei);
    wgschecks.add(false);
    ydsiteList.add(ashebei);
    ydschecks.add(false);
    ecsiteList.add(ashebei);
    ecschecks.add(false);
    AirIndexData aind1=AirIndexData();
    aind1.id=-1;
    aind1.name='全部指标';
    alliindexList.add(aind1);
    allichecks.add(true);
    _sitesRealTimedPost();
    _airindexTypePost();
    _sitePost();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _loadMore();
      }
    });
    startTime = '${DateTime
        .now()
        .year}-${DateTime
        .now()
        .month}-${DateTime
        .now()
        .day
        .toString()
        .padLeft(2, '0')}';
    endTime = '${DateTime
        .now()
        .year}-${DateTime
        .now()
        .month}-${DateTime
        .now()
        .day
        .toString()
        .padLeft(2, '0')}';
  }
  Future<void> _sitePost() async {
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId') ?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/device/findAllPollutant');
    // var params = Map<String, dynamic>();
    // params["type"] = null;
    // var result = await http.post(url,
    //   headers: {
    //     'busiParkId': busiParkId,
    //     'authorization': authorization,
    //     "Content-Type": "application/json"
    //   },
    //   body: jsonEncode(params),);
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"","code":200,"data":[{"sn":"2574","name":"京西北","regionId":1,"devType":2,"devLongitude":"116.106175","devLatitude":"39.968263","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2577","name":"前门","regionId":1,"devType":2,"devLongitude":"116.114799","devLatitude":"39.95853","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2578","name":"北部新区","regionId":1,"devType":2,"devLongitude":"116.109625","devLatitude":"39.942157","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2579","name":"南三环","regionId":1,"devType":2,"devLongitude":"116.096402","devLatitude":"39.957202","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2581","name":"大兴","regionId":1,"devType":2,"devLongitude":"116.115949","devLatitude":"39.945255","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2586","name":"密云","regionId":1,"devType":2,"devLongitude":"116.164242","devLatitude":"39.927109","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2587","name":"平谷","regionId":1,"devType":2,"devLongitude":"116.119398","devLatitude":"39.939059","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2588","name":"延庆","regionId":1,"devType":2,"devLongitude":"116.10445","devLatitude":"39.916485","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2589","name":"怀柔","regionId":1,"devType":1,"devLongitude":"116.152743","devLatitude":"39.90143","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2590","name":"房山","regionId":1,"devType":1,"devLongitude":"116.220008","devLatitude":"39.892131","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2591","name":"昌平","regionId":1,"devType":1,"devLongitude":"116.111924","devLatitude":"39.918698","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2592","name":"永定门","regionId":1,"devType":1,"devLongitude":"116.256228","devLatitude":"39.867768","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2593","name":"西直门","regionId":1,"devType":1,"devLongitude":"116.163667","devLatitude":"39.862895","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2594","name":"通州","regionId":1,"devType":1,"devLongitude":"116.132621","devLatitude":"39.845613","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2595","name":"门头沟","regionId":2,"devType":1,"devLongitude":"116.24358","devLatitude":"39.835419","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2596","name":"顺义","regionId":2,"devType":1,"devLongitude":"116.103875","devLatitude":"39.846499","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"2597","name":"香山","regionId":2,"devType":1,"devLongitude":"116.239555","devLatitude":"39.834089","status":1,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090013","name":"有毒有害01","regionId":4,"devType":3,"devLongitude":"116.10675","devLatitude":"39.874413","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:03:16","updateUser":"1","updateTime":"2020-11-23 11:09:23","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090014","name":"有毒有害02","regionId":4,"devType":3,"devLongitude":"116.120548","devLatitude":"39.88283","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:25","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090015","name":"有毒有害03","regionId":4,"devType":3,"devLongitude":"116.163092","devLatitude":"39.81547","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090017","name":"有毒有害05","regionId":3,"devType":3,"devLongitude":"116.111924","devLatitude":"39.85359","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090018","name":"有毒有害06","regionId":3,"devType":3,"devLongitude":"116.196437","devLatitude":"39.791524","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090019","name":"有毒有害07","regionId":3,"devType":3,"devLongitude":"116.148144","devLatitude":"39.786645","status":1,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090020","name":"恶臭01","regionId":4,"devType":4,"devLongitude":"116.113649","devLatitude":"39.807932","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090021","name":"恶臭02","regionId":4,"devType":4,"devLongitude":"116.059607","devLatitude":"39.842067","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090023","name":"恶臭03","regionId":4,"devType":4,"devLongitude":"116.276925","devLatitude":"39.864224","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090024","name":"恶臭04","regionId":3,"devType":4,"devLongitude":"116.069955","devLatitude":"39.836306","status":0,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"300090025","name":"恶臭05","regionId":3,"devType":4,"devLongitude":"116.159067","devLatitude":"39.760913","status":1,"useStatus":0,"remark":null,"createUser":"1","createTime":"2020-11-23 11:09:17","updateUser":"1","updateTime":"2020-11-23 11:09:17","delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"607","name":"万寿西宫","regionId":2,"devType":1,"devLongitude":"116.161942","devLatitude":"39.762244","status":1,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"608","name":"东四","regionId":2,"devType":1,"devLongitude":"116.053283","devLatitude":"39.779104","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"609","name":"农展馆","regionId":2,"devType":1,"devLongitude":"116.225183","devLatitude":"39.773337","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"610","name":"古城","regionId":2,"devType":1,"devLongitude":"116.080879","devLatitude":"39.808376","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"611","name":"天坛","regionId":2,"devType":1,"devLongitude":"116.31142","devLatitude":"39.840295","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"612","name":"奥体中心","regionId":2,"devType":1,"devLongitude":"116.282674","devLatitude":"39.854919","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"613","name":"官园","regionId":2,"devType":2,"devLongitude":"116.324068","devLatitude":"39.8301","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"614","name":"定陵","regionId":2,"devType":2,"devLongitude":"116.336716","devLatitude":"39.837192","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"615","name":"怀柔镇","regionId":2,"devType":2,"devLongitude":"116.305096","devLatitude":"39.804828","status":1,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"616","name":"昌平镇","regionId":2,"devType":2,"devLongitude":"116.10445","devLatitude":"39.918698","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"617","name":"海淀区万柳","regionId":2,"devType":2,"devLongitude":"116.103875","devLatitude":"39.857135","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null},{"sn":"618","name":"顺义新城","regionId":2,"devType":2,"devLongitude":"116.121698","devLatitude":"39.78354","status":0,"useStatus":0,"remark":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"busiParkId":1,"typeName":null,"regionName":null,"pollutantData":null,"countryDataDayList":null,"griddingDataDayList":null,"countryDataHourList":null,"compareResult":null,"griddingDataHourList":null}]}';
    airSiteModel = AirSiteModel.fromJson(
        json.decode(text));
    print(airSiteModel.data);
    allTrueSiteList=airSiteModel.data!;
    for(int i=0;i<allTrueSiteList.length;i++){
      if(allTrueSiteList[i].devType==1){
        gbsiteList.add(allTrueSiteList[i]);
        gbschecks.add(false);
      }else if(allTrueSiteList[i].devType==2){
        wgsiteList.add(allTrueSiteList[i]);
        wgschecks.add(false);
      }else if(allTrueSiteList[i].devType==3){
        ydsiteList.add(allTrueSiteList[i]);
        ydschecks.add(false);
      }else if(allTrueSiteList[i].devType==4){
        ecsiteList.add(allTrueSiteList[i]);
        ecschecks.add(false);
      }
    }
  }

  Future<void> _airindexTypePost() async {
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId') ?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/devicetype/findAllPollutantType');
    //
    // var result = await http.post(url,
    //   headers: {
    //     'busiParkId': busiParkId,
    //     'authorization': authorization
    //   },
    //  );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"","code":200,"data":[{"id":1,"name":"国标站","delStatus":0,"data":null,"busiParkId":1},{"id":2,"name":"网格站","delStatus":0,"data":null,"busiParkId":1},{"id":3,"name":"有毒有害气体","delStatus":0,"data":null,"busiParkId":1},{"id":4,"name":"恶臭","delStatus":0,"data":null,"busiParkId":1}]}';
    airSiteTypeModel = AirSiteTypeModel.fromJson(
        json.decode(text));
    IndexTypelist.addAll(airSiteTypeModel.data);
    SiteTypelist.addAll(airSiteTypeModel.data);
    SiteTypeData indexTypeData=SiteTypeData();
    indexTypeData.id=-1;
    indexTypeData.name='全部指标';
    IndexTypelist.insert(0, indexTypeData);
    SiteTypeData siteTypeData=SiteTypeData();
    siteTypeData.id=-1;
    siteTypeData.name='全部站点';
    SiteTypelist.insert(0, siteTypeData);
    _indexGet1();
    _indexGet2();
    _indexGet3();
    _indexGet4();

  }
  Future<void> _indexGet1() async {
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId') ?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/pollutantIndex/getPollutantIndexByType/1');
    // var result = await http.get(url,
    //   headers: {
    //     'busiParkId': busiParkId,
    //     'authorization': authorization
    //   });
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"PM₂.₅","code":"pm25","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":2,"name":"PM₁₀","code":"pm10","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":3,"name":"NO₂","code":"no2","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":4,"name":"SO₂","code":"so2","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":5,"name":"CO","code":"co","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":6,"name":"O₃","code":"o3","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":7,"name":"O₃_8H最大","code":"o3_8h_max","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":8,"name":"O₃_8H","code":"o3_8h","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":9,"name":"NMHC","code":"nmhc","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]}]}';
    airIndexModel = AirIndexModel.fromJson(
        json.decode(text));
    gbIndexList=airIndexModel.data!;
   for(int i=0;i<gbIndexList.length;i++){
     gbichecks.add(false);
   }
  }
  Future<void> _indexGet2() async {
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId') ?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/pollutantIndex/getPollutantIndexByType/2');
    // var result = await http.get(url,
    //     headers: {
    //       'busiParkId': busiParkId,
    //       'authorization': authorization
    //     });
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"PM₂.₅","code":"pm25","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":2,"name":"PM₁₀","code":"pm10","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":3,"name":"NO₂","code":"no2","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":4,"name":"SO₂","code":"so2","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":5,"name":"CO","code":"co","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":6,"name":"O₃","code":"o3","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":7,"name":"O₃_8H最大","code":"o3_8h_max","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":8,"name":"O₃_8H","code":"o3_8h","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":10,"name":"TVOC","code":"tvoc","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]}]}';
    airIndexModel = AirIndexModel.fromJson(
        json.decode(text));
    wgIndexList=airIndexModel.data!;
    for(int i=0;i<wgIndexList.length;i++){
      wgichecks.add(false);
    }
  }
  Future<void> _indexGet3() async {
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId') ?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/pollutantIndex/getPollutantIndexByType/3');
    // var result = await http.get(url,
    //     headers: {
    //       'busiParkId': busiParkId,
    //       'authorization': authorization
    //     });
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":[{"id":11,"name":"H₂S","code":"h2s","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":12,"name":"NH₃","code":"nh3","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":13,"name":"HCl","code":"hcl","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":14,"name":"Cl₂","code":"cl2","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":15,"name":"COCl₂","code":"cocl2","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":16,"name":"VOC","code":"voc","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]}]}';
    airIndexModel = AirIndexModel.fromJson(
        json.decode(text));
    ydIndexList=airIndexModel.data!;
    for(int i=0;i<ydIndexList.length;i++){
      ydichecks.add(false);
    }
  }
  Future<void> _indexGet4() async {
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId') ?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/pollutantIndex/getPollutantIndexByType/4');
    // var result = await http.get(url,
    //     headers: {
    //       'busiParkId': busiParkId,
    //       'authorization': authorization
    //     });
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":[{"id":12,"name":"NH₃","code":"nh3","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":17,"name":"C₃H₉N","code":"c3h9n","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":11,"name":"H₂S","code":"h2s","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":18,"name":"CH₄S","code":"ch4s","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":19,"name":"C₂H₆S","code":"c2h6s","unit":"mg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":20,"name":"C₂H₆S₂","code":"c2h6s2","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":21,"name":"CS₂","code":"cs2","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":22,"name":"C₈H₈","code":"c8h8","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]},{"id":23,"name":"OU","code":"ou","unit":"µg/m³","busiParkId":null,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":0,"dayAlarmCount":[]}]}';
    airIndexModel = AirIndexModel.fromJson(
        json.decode(text));
    ecIndexList=airIndexModel.data!;
    for(int i=0;i<ecIndexList.length;i++){
      ecichecks.add(false);
    }
  }
  Future<void> _sitesRealTimedPost() async {
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId') ?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/appAirData/appQryAirAlarm');
    // var params = Map<String, dynamic>();
    // params["pageNum"] = index;
    // params["pageSize"] = 10;
    // params["data"] = {
    //   "sn": sn,
    //   "time": timeData,
    //   "startTime": startTime,
    //   "endTime": endTime,
    //   "indexId": indexId,
    //   "alarmType": alarmType,};
    // print(params["data"]);
    // var result = await http.post(url,
    //   headers: {
    //     'busiParkId': busiParkId,
    //     'authorization': authorization,
    //     "Content-Type": "application/json"
    //   },
    //   body: jsonEncode(params),);
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // Map<String, dynamic> data = new Map<String, dynamic>.from(
    //     json.decode(utf8decoder.convert(result.bodyBytes)));
    // //print(widget.sn);
    // // print('11111'+json.decode(result.body));
    String text='{"msg":"success","code":200,"data":{"totalCount":2347,"pageSize":10,"totalPage":235,"currPage":1,"list":[{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[115.43]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"OU","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"OU的监测值[55.92]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"C₈H₈","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₈H₈的监测值[68.25]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"CS₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CS₂的监测值[84.61]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S₂的监测值[98.48]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"C₂H₆S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₂H₆S的监测值[88.58]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"CH₄S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"CH₄S的监测值[86.96]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"C₃H₉N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"C₃H₉N的监测值[66.87]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭04","indexId":null,"indexName":"NH₃","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃的监测值[52.34]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null},{"id":null,"deviceId":null,"deviceName":"恶臭02","indexId":null,"indexName":"H₂S","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"H₂S的监测值[67.23]超过标准值(50.0)","createTime":"2021-12-29 15:20:03","busiParkId":null,"dataTime":null,"alarmCount":null,"alarmMultiple":0.0,"data":null}]}}';
    alarmhistorymodel = AlarmHistoryModel.fromJson(
        json.decode(text));
    print(alarmhistorymodel.data!.list);
    setState(() {
      AlarmDataList.addAll(alarmhistorymodel.data!.list);
    });
  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  // 加载更多布局
  Widget _buildLoadMoreItem() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "数据加载中", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
      ),
    );
  }

  // 加载完成布局
  Widget _buildLoadEndItem() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          "暂无数据", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),),
      ),
    );
  }

// 下拉刷新方法
  Future<Null> _handleRefresh() async {
    setState(() {
      AlarmDataList.clear();
      index = 1;
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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(
                color: Color.fromRGBO(1, 20, 43, 1), width: 0.0)),
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(6, 36, 66, 1),
                Color.fromRGBO(16, 56, 95, 1),
                Color.fromRGBO(1, 20, 43, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.5, 1],
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
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return MyDatePicker(
                            endYear: DateTime
                                .now()
                                .year,
                            selectedDate: null,
                            onSelectedDate: (String startDate, String endDate) {
                              startTime = startDate;
                              endTime = endDate;
                              AlarmDataList.clear();
                              index = 1;
                              _sitesRealTimedPost();

                              Navigator.pop(context);
                            },);
                        });
                  },
                  child: Row(children: [
                    SizedBox(width: Adapt.px(32),),
                    Text('$startTime', style: TextStyle(
                      color: Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32),)),
                    SizedBox(width: Adapt.px(16),),
                    Text('至', style: TextStyle(
                      color: Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32),)),
                    SizedBox(width: Adapt.px(16),),
                    Text('$endTime', style: TextStyle(
                      color: Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32),)),
                    SizedBox(width: Adapt.px(16),),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(185, 233, 255, 1),
                      size: Adapt.px(32),)
                  ],),
                ),
              ],),
            Expanded(child: Container(
              padding: EdgeInsets.only(left: Adapt.px(32), right: Adapt.px(32)),
              child: RefreshIndicator(
                  child: ListView.separated(
                      itemCount: AlarmDataList.length + 1,
                      //个数
                      controller: _scrollController,
                      //注册监听器
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
                      itemBuilder: (BuildContext context, int index) {
                        if (AlarmDataList.isEmpty || index >
                            alarmhistorymodel.data!.totalCount!.toInt()) {
                          return _buildLoadEndItem();
                        } else {
                          if (index == AlarmDataList.length) {
                            return _buildLoadMoreItem();
                          } else {
                            // 最后一项，显示加载更多布局
                            return getAlarmListViewItem(AlarmDataList[index]);
                          }
                        }
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
                child: Text(zhandian, style: _sitepressed ? textStyle1 : textStyle2,overflow: TextOverflow.ellipsis,),),
              SizedBox(width: Adapt.px(12),),
              _sitepressed ? icon1 : icon2
            ],)),
      onTap: () {
        _showDropDownSiteMenu();
        setState(() {
          _sitepressed = !_sitepressed;
        });
      },
    );
  }
  _showDropDownSiteMenu() {
    Navigator.push(context, PopRoute(
        DropDownAirSiteMenu(SiteTypelist,allsiteList,allschecks,gbsiteList,gbschecks,wgsiteList,wgschecks,ydsiteList,ydschecks,ecsiteList,ecschecks))).then((value) => setState(() {

      if(value=='out'){
        _sitepressed = !_sitepressed;
      }else{
        sn=value['id'].toString();
        zhandian=value['name'].toString();
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
              Text(zhibiao, style: _indexpressed ? textStyle1 : textStyle2),
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
    Navigator.push(context, PopRoute(
        DropDownAirIndexMenu(IndexTypelist,alliindexList,allichecks,gbIndexList,gbichecks,wgIndexList,wgichecks,ydIndexList,ydichecks,ecIndexList,ecichecks))).then((value) => setState(() {
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
    // EasyPopup.show(context, DropDownMenu(), offsetLT: Offset(0, MediaQuery
    //     .of(context)
    //     .padding
    //     .top + 96+96));

  }

  Widget getAlarmListViewItem(Alarm alarm) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromRGBO(185, 233, 255, 0.05),
          borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
      ),
      width: Adapt.px(686),
      child: Column(
        children: [
          SizedBox(height: Adapt.px(32),),
          IntrinsicHeight(child: Row(
            children: [
              SizedBox(width: Adapt.px(32)),
              imageItem(alarm),
              SizedBox(width: Adapt.px(16)),
              Text(alarm.deviceName ?? '-'.toString(), style: TextStyle(
                  color: Color.fromRGBO(185, 233, 255, 1),
                  fontSize: Adapt.px(32)),
              ),
            ],
          ),),


          SizedBox(height: Adapt.px(32),),
          Row(children: [
            SizedBox(width: Adapt.px(32)),
            Text('报警指标：', style: TextStyle(
                color: Color.fromRGBO(185, 233, 255, 1),
                fontSize: Adapt.px(24)),
            ),
            Text(alarm.indexName ?? "-".toString(), style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontSize: Adapt.px(24)),
            ),
          ],),
          SizedBox(height: Adapt.px(16),),
          IntrinsicHeight(child: Row(
            children: [
              SizedBox(width: Adapt.px(32)),
              Text('报警内容：', style: TextStyle(
                  color: Color.fromRGBO(185, 233, 255, 1),
                  fontSize: Adapt.px(24)),
              ),
              Container(
                width: Adapt.px(502),
                child: Text(
                  alarm.alarmContent ?? "-".toString(),
                  style: TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      fontSize: Adapt.px(24)),
                ),
              ),
            ],
          ),),
          SizedBox(height: Adapt.px(16),),
          Row(children: [
            SizedBox(width: Adapt.px(32)),
            Text('报警时间：', style: TextStyle(
                color: Color.fromRGBO(185, 233, 255, 1),
                fontSize: Adapt.px(24)),
            ),
            Text(alarm.createTime ?? "-".toString(), style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
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
    );
  }

  Image imageItem(Alarm alarm) {
    if (alarm.alarmType == 2) {
      if (alarm.alarmGrade == 4) {
        return Image(
          image: const AssetImage('images/alarmred.png'),
          width: Adapt.px(36),
          height: Adapt.px(36),);
      } else if (alarm.alarmGrade == 3) {
        return Image(
          image: const AssetImage('images/alarmorange.png'),
          width: Adapt.px(36),
          height: Adapt.px(36),);
      } else if (alarm.alarmGrade == 2) {
        return Image(
          image: const AssetImage('images/alarmyellow.png'),
          width: Adapt.px(36),
          height: Adapt.px(36),);
      } else {
        return Image(
          image: const AssetImage('images/alarmblue.png'),
          width: Adapt.px(36),
          height: Adapt.px(36),);
      }
    } else {
      return Image(
        image: const AssetImage('images/alarmgrew.png'),
        width: Adapt.px(36),
        height: Adapt.px(36),);
    }
  }

}