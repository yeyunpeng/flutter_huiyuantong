import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/alarm_history_model.dart';
import 'package:flutter_huiyuantong/model/water_alarm_history_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
class WaterAlarmHistory extends StatefulWidget {
  final String fraId;
  const WaterAlarmHistory(this.fraId,{Key? key}) : super(key: key);

  @override
  _WaterAlarmHistoryState createState() {
    // TODO: implement createState
    return _WaterAlarmHistoryState();
  }
}
class _WaterAlarmHistoryState extends State<WaterAlarmHistory>{
  var dateyear=2021;
  String ? timeData=null;
  late WaterAlarmHistoryModel alarmhistorymodel;
  var index=1;
  var mydata;
  List<WaterAlarm> AlarmDataList =[];
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //初始化方法里面添加监听器
    _sitesRealTimedPost();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _loadMore();
      }
    });

  }
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
  Future<void> _sitesRealTimedPost() async{
    final prefs = await SharedPreferences.getInstance();
    final busiParkId = prefs.getString('busiParkId')?? "0";
    final authorization = prefs.getString('authorization') ?? "0";
    var url = Uri.parse('${HttpUtil.url}/api/appWater/qryWaterAlarmData');
    var params = Map<String, dynamic>();
    params["pageNum"] = index;
    params["pageSize"] = 10;
    params["data"] = {"fraId":widget.fraId,"time":timeData};
    var result=await http.post(url,
      headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
      body: jsonEncode(params), );
    Utf8Decoder utf8decoder = const Utf8Decoder();
    Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(utf8decoder.convert(result.bodyBytes)));
    //print(widget.sn);
    // print('11111'+json.decode(result.body));
    alarmhistorymodel=WaterAlarmHistoryModel.fromJson(json.decode(utf8decoder.convert(result.bodyBytes)) ) ;
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(6, 36, 66, 1),
        title: Text('断面报警历史数据',style: TextStyle(
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
            SizedBox(height: Adapt.px(20),),
            Row(children: [
              TextButton(
                  onPressed: (){
                    DatePicker.showDatePicker(
                        context,
                        // 是否展示顶部操作按钮
                        showTitleActions: true,
                        // 确定事件
                        onConfirm: (date) {

                          print(formatDate(date, [yyyy, '-', mm, '-', dd]));
                          setState(() {
                            dateyear=date.year;
                            timeData=formatDate(date, [yyyy, '-', mm, '-', dd]);
                            index=1;
                            AlarmDataList.clear();
                            _sitesRealTimedPost();
                          });
                        },
                        // 当前时间
                        currentTime: DateTime.now(),
                        // 语言
                        locale: LocaleType.zh,
                        theme: DatePickerTheme(
                          backgroundColor: Color.fromRGBO(28, 67, 105, 1),
                          cancelStyle: TextStyle(color: Color.fromRGBO(46, 228, 149, 1),
                              fontSize: Adapt.px(34)),
                          doneStyle: TextStyle(color: Color.fromRGBO(46, 228, 149, 1),
                              fontSize: Adapt.px(34)),
                          itemStyle: TextStyle(color: Color.fromRGBO(255, 255, 255, 1),
                              fontSize: Adapt.px(34)),

                        )

                    );

                  },
                  child: Row(children: [
                    Text('$dateyear年',style: TextStyle(
                      color: Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32),)),
                    SizedBox(width: Adapt.px(32),),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(185, 233, 255, 1),
                      size: Adapt.px(32),)
                  ],))
            ],),
            Expanded(child: RefreshIndicator(
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
                      if (index == AlarmDataList.length) {
                        return _buildLoadMoreItem();


                      } else {
                        // 最后一项，显示加载更多布局
                        return getAlarmListViewItem(AlarmDataList[index]);
                      }

                    }), onRefresh: _handleRefresh)),


          ],
        ),
      ),


    );
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
        Container(
          width: Adapt.px(622),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  imageItem(alarm),
                  SizedBox(width:Adapt.px(16)),
                  Text(alarm.indexName??'-'.toString(), style: TextStyle(
                      color:  Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32)),
                  ),
                ],
              ),
              Text(alarm.createTime??"-".toString(), style: TextStyle(
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
                alarm.alarmContent??"-".toString(),
                style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
              ),
            ),
          ],
        ),),

        SizedBox(height: Adapt.px(32),),


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