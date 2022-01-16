import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_huiyuantong/model/alarm_history_model.dart';
import 'package:flutter_huiyuantong/model/baojing/pollution_index_model.dart';
import 'package:flutter_huiyuantong/model/baojing/pollution_outlet_model.dart';
import 'package:flutter_huiyuantong/model/pollution_alarm_history_model.dart';
import 'package:flutter_huiyuantong/model/water_alarm_history_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/drop_down_menu.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:flutter_huiyuantong/util/mydatepicker.dart';
import 'package:flutter_huiyuantong/util/poprote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dropdown/drop_down_pollution_index_menu.dart';
import 'dropdown/drop_down_pollution_outlet_menu.dart';
class BaojingPollutionPage extends StatefulWidget{
  @override
  _BaojingPollutionPageState createState()=>_BaojingPollutionPageState();
}
class _BaojingPollutionPageState extends State<BaojingPollutionPage>{
  bool _sitepressed = true;
  bool _indexpressed = true;
  bool _typepressed = true;
  final List<bool> _allisChecks=[];
  final List<bool> _airisChecks=[];
  final List<bool> _waterisChecks=[];

  String ? timeData=null;
  String paikou='全部排口';
  String zhibiao='全部指标';
  String leixing='全部类型';
  final List<bool> _isChecks=[];
  late PollutionOutletModel pollutionOutletModel;
  List<OutletList> outletList =[];
  late PollutionIndexModel pollutionIndexModel;
  List<PollutionIndexAir> pollutionIndexAir =[];
  List<PollutionIndexWater> pollutionIndexWater =[];
  late PollutionAlarmHistoryModel alarmhistorymodel;
  List<PollutionAlarm> AlarmDataList =[];
  var index=1;
  var mydata;
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false;
  //筛选项选择变量
  String outId='-1';
  var startTime='-1';
  var endTime;
  var indexId;
  var alarmType='-1';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化方法里面添加监听器
    _pollutionOutletPost();
    _pollutionIndexGet();
    _sitesRealTimedPost();
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

  Future<void> _pollutionOutletPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/stationOverview/getAllComAndOutlet');
    //
    // var result=await http.post(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization});
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String text='{"msg":"success","code":200,"data":[{"id":1,"name":"大安化工南村街道分公司","person":null,"address":null,"socialCode":null,"contacts":null,"phone":null,"director":null,"dirPhone":null,"scale":null,"comLongitude":null,"comLatitude":null,"performance":null,"performanceName":null,"prodStatus":null,"prodStatusName":null,"consStatus":null,"consStatusName":null,"classType":null,"classTypeName":null,"monDevice":null,"monDeviceName":null,"orgCode":null,"note":null,"createTime":null,"busiParkId":null,"crippledCount":null,"detailedAddress":null,"deviceAddress":null,"deviceDetailedAddress":null,"comDetailedType":null,"delStatus":0,"delStatusName":null,"allCount":0,"alarmCount":0,"standCount":0,"isKey":0,"industryId":null,"induName":null,"outletList":[{"id":1,"name":"废气1-南村小区街道","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":1,"delStatus":0,"onLineState":2,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":5,"name":"废气5","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":1,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":6,"name":"废水1","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":1,"delStatus":0,"onLineState":2,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":10,"name":"废水5","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":1,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null}],"comType":2,"comTypeName":null,"outName":null,"outId":0,"onLineState":0,"indusName":null,"outType":0,"urls":null,"alarmMessageCount":0,"alarmMul":0.0,"validRate":0.0,"deficValueRate":0.0,"zeroValueRate":0.0,"alarmMessageCountIndex":0.0,"riskIndex":0.0,"distance":0.0,"alarmValue":0.0,"show":true,"declear":false,"licenceCode":null,"licenceDetailedName":null},{"id":2,"name":"重型汽车公司1","person":null,"address":null,"socialCode":null,"contacts":null,"phone":null,"director":null,"dirPhone":null,"scale":null,"comLongitude":null,"comLatitude":null,"performance":null,"performanceName":null,"prodStatus":null,"prodStatusName":null,"consStatus":null,"consStatusName":null,"classType":null,"classTypeName":null,"monDevice":null,"monDeviceName":null,"orgCode":null,"note":null,"createTime":null,"busiParkId":null,"crippledCount":null,"detailedAddress":null,"deviceAddress":null,"deviceDetailedAddress":null,"comDetailedType":null,"delStatus":0,"delStatusName":null,"allCount":0,"alarmCount":0,"standCount":0,"isKey":0,"industryId":null,"induName":null,"outletList":[{"id":2,"name":"废气2","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":2,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":7,"name":"废水2","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":2,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null}],"comType":2,"comTypeName":null,"outName":null,"outId":0,"onLineState":0,"indusName":null,"outType":0,"urls":null,"alarmMessageCount":0,"alarmMul":0.0,"validRate":0.0,"deficValueRate":0.0,"zeroValueRate":0.0,"alarmMessageCountIndex":0.0,"riskIndex":0.0,"distance":0.0,"alarmValue":0.0,"show":false,"declear":false,"licenceCode":null,"licenceDetailedName":null},{"id":3,"name":"新三力有限公司","person":null,"address":null,"socialCode":null,"contacts":null,"phone":null,"director":null,"dirPhone":null,"scale":null,"comLongitude":null,"comLatitude":null,"performance":null,"performanceName":null,"prodStatus":null,"prodStatusName":null,"consStatus":null,"consStatusName":null,"classType":null,"classTypeName":null,"monDevice":null,"monDeviceName":null,"orgCode":null,"note":null,"createTime":null,"busiParkId":null,"crippledCount":null,"detailedAddress":null,"deviceAddress":null,"deviceDetailedAddress":null,"comDetailedType":null,"delStatus":0,"delStatusName":null,"allCount":0,"alarmCount":0,"standCount":0,"isKey":0,"industryId":null,"induName":null,"outletList":[{"id":3,"name":"废气3","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":3,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":8,"name":"废水3","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":3,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":9,"name":"废水4","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":3,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null}],"comType":2,"comTypeName":null,"outName":null,"outId":0,"onLineState":0,"indusName":null,"outType":0,"urls":null,"alarmMessageCount":0,"alarmMul":0.0,"validRate":0.0,"deficValueRate":0.0,"zeroValueRate":0.0,"alarmMessageCountIndex":0.0,"riskIndex":0.0,"distance":0.0,"alarmValue":0.0,"show":false,"declear":false,"licenceCode":null,"licenceDetailedName":null},{"id":4,"name":"天鼎核电公司","person":null,"address":null,"socialCode":null,"contacts":null,"phone":null,"director":null,"dirPhone":null,"scale":null,"comLongitude":null,"comLatitude":null,"performance":null,"performanceName":null,"prodStatus":null,"prodStatusName":null,"consStatus":null,"consStatusName":null,"classType":null,"classTypeName":null,"monDevice":null,"monDeviceName":null,"orgCode":null,"note":null,"createTime":null,"busiParkId":null,"crippledCount":null,"detailedAddress":null,"deviceAddress":null,"deviceDetailedAddress":null,"comDetailedType":null,"delStatus":0,"delStatusName":null,"allCount":0,"alarmCount":0,"standCount":0,"isKey":0,"industryId":null,"induName":null,"outletList":[{"id":4,"name":"废气4","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":4,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null}],"comType":2,"comTypeName":null,"outName":null,"outId":0,"onLineState":0,"indusName":null,"outType":0,"urls":null,"alarmMessageCount":0,"alarmMul":0.0,"validRate":0.0,"deficValueRate":0.0,"zeroValueRate":0.0,"alarmMessageCountIndex":0.0,"riskIndex":0.0,"distance":0.0,"alarmValue":0.0,"show":false,"declear":false,"licenceCode":null,"licenceDetailedName":null}]}';
    pollutionOutletModel=PollutionOutletModel.fromJson(json.decode(text)) ;
    List<OutletData> dataList=pollutionOutletModel.data;
    OutletList all=OutletList();
    all.id=-1;
    all.name='全部排口';
    outletList.insert(0, all);
    for(int i=0;i<dataList.length;i++){
      outletList.addAll(dataList[i].outletList);
    }
    for(int i=0;i<outletList.length;i++){
      _isChecks.add(false);
    }
  }
  Future<void> _pollutionIndexGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/pollutionSourceIndex/qryAllIndexDataWithOutletType');
    // var result=await http.get(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization},
    // );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // // print('11111'+json.decode(result.body));
    String text='{"msg":"success","code":200,"data":{"air":[{"id":3,"name":"SO₂","code":"so2","unit":"µg/m 3","acquisitionTime":1,"status":1,"remark":null,"busiParkId":1,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":null,"outletType":0,"outfallId":0,"limitType":0,"limitValue":0.0,"limitMin":0.0,"limitMax":0.0,"monthEveryDayCount":null},{"id":4,"name":"NOx","code":"nox","unit":"µg/m 3","acquisitionTime":1,"status":1,"remark":null,"busiParkId":1,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":null,"outletType":0,"outfallId":0,"limitType":0,"limitValue":0.0,"limitMin":0.0,"limitMax":0.0,"monthEveryDayCount":null},{"id":5,"name":"PM","code":"pm","unit":"µg/m 3","acquisitionTime":1,"status":1,"remark":null,"busiParkId":1,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":null,"outletType":0,"outfallId":0,"limitType":0,"limitValue":0.0,"limitMin":0.0,"limitMax":0.0,"monthEveryDayCount":null}],"water":[{"id":1,"name":"COD","code":"cod","unit":"mg/L","acquisitionTime":1,"status":1,"remark":null,"busiParkId":1,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":null,"outletType":0,"outfallId":0,"limitType":0,"limitValue":0.0,"limitMin":0.0,"limitMax":0.0,"monthEveryDayCount":null},{"id":2,"name":"NH₃-N","code":"nh3_nh4","unit":"mg/L","acquisitionTime":1,"status":1,"remark":null,"busiParkId":1,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":null,"outletType":0,"outfallId":0,"limitType":0,"limitValue":0.0,"limitMin":0.0,"limitMax":0.0,"monthEveryDayCount":null},{"id":6,"name":"总磷","code":"TP","unit":"mg/L","acquisitionTime":1,"status":1,"remark":null,"busiParkId":1,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":null,"outletType":0,"outfallId":0,"limitType":0,"limitValue":0.0,"limitMin":0.0,"limitMax":0.0,"monthEveryDayCount":null},{"id":7,"name":"总氮","code":"TN","unit":"mg/L","acquisitionTime":1,"status":1,"remark":null,"busiParkId":1,"createUser":null,"createTime":null,"updateUser":null,"updateTime":null,"delStatus":null,"outletType":0,"outfallId":0,"limitType":0,"limitValue":0.0,"limitMin":0.0,"limitMax":0.0,"monthEveryDayCount":null}]}}';
    pollutionIndexModel=PollutionIndexModel.fromJson(json.decode(text) ) ;
    pollutionIndexAir=pollutionIndexModel.data.air;
    pollutionIndexWater=pollutionIndexModel.data.water;
    for(int i=0;i<pollutionIndexAir.length;i++){
      _airisChecks.add(false);
    }
    for(int i=0;i<pollutionIndexWater.length;i++){
      _waterisChecks.add(false);
    }
    _allisChecks.add(true);
  }
  Future<void> _sitesRealTimedPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/appPollution/qyrPollutionAlarmData');
    // var params = Map<String, dynamic>();
    // params["pageNum"] = index;
    // params["pageSize"] = 10;
    // params["data"] = {
    //   "outId":outId,
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
    // //print(widget.sn);
    // // print('11111'+json.decode(result.body));
    String text='{"msg":"success","code":200,"data":{"totalCount":208,"pageSize":10,"totalPage":21,"currPage":1,"list":[{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废水5","indexId":null,"indexName":"NH₃-N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃-N的监测值[9.41]超过标准值(8.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废水4","indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷的监测值[1.15]超过标准值(1.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废水3","indexId":null,"indexName":"NH₃-N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃-N的监测值[10.28]超过标准值(8.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废水2","indexId":null,"indexName":"COD","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"COD的监测值[72.37]超过标准值(60.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废水1","indexId":null,"indexName":"COD","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"COD的监测值[64.51]超过标准值(60.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废气5","indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[409.46]超过标准值(400.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废气4","indexId":null,"indexName":"PM","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM的监测值[83.86]超过标准值(80.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废气3","indexId":null,"indexName":"NOx","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NOx的监测值[406.96]超过标准值(400.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废气3","indexId":null,"indexName":"PM","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"PM的监测值[86.81]超过标准值(80.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":null,"outfallName":"废气3","indexId":null,"indexName":"SO₂","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"SO₂的监测值[410.69]超过标准值(400.0)","createTime":"2021-12-29 15:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null}]}}';
    alarmhistorymodel=PollutionAlarmHistoryModel.fromJson(json.decode(text) ) ;
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

                    }), onRefresh: _handleRefresh),
            )
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
                child: Text(paikou, style: _sitepressed ? textStyle1 : textStyle2,overflow: TextOverflow.ellipsis,),),

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
    Navigator.push(context, PopRoute(DropDownPollutionOutletMenu(outletList,_isChecks))).then((value) => setState(() {
      print(value);
      if(value=='out'){
        _sitepressed = !_sitepressed;
      }else{
        outId=value['id'];
        paikou=value['name'];
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
    Navigator.push(context, PopRoute(DropDownPollutionIndexMenu(pollutionIndexAir,pollutionIndexWater,_allisChecks,_airisChecks,_waterisChecks))).then((value) => setState(() {
      if(value=='out'){
        _indexpressed = !_indexpressed;
      }else if(value=='-1'){
        zhibiao='全部指标';
        indexId=value;
        AlarmDataList.clear();
        index = 1;
        _sitesRealTimedPost();
        _indexpressed = !_indexpressed;
      }else{
        zhibiao=value.name;
        indexId=value.id;
        AlarmDataList.clear();
        index = 1;
        _sitesRealTimedPost();
        _indexpressed = !_indexpressed;
      }
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
        _showDropDownTypeMenu();
        setState(() {

          _typepressed = !_typepressed;
        });
      },
    );
  }
  _showDropDownTypeMenu() {
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
Widget getAlarmListViewItem(PollutionAlarm alarm) {
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
            Text(alarm.outfallName??'-'.toString(), style: TextStyle(
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
Image imageItem(PollutionAlarm alarm) {

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