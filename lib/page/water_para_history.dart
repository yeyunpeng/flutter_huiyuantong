import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/paramater_history_model.dart';
import 'package:flutter_huiyuantong/model/water_para_history_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
class WaterParaHistory extends StatefulWidget {
  final String fraId;
  const WaterParaHistory( this.fraId,{Key? key}) : super(key: key);

  @override
  _WaterParaHistoryState createState() {
    // TODO: implement createState
    return _WaterParaHistoryState();
  }
}

class _WaterParaHistoryState extends State<WaterParaHistory>{
  var dateyear=2021;
  String ? timeData=null;
  late WaterParaHistoryModel parahistorymodel;
  var index=1;
  var mydata;
  List<WaterXiang> XiangDataList =[];
  late List<DayIndexData> DayIndexDataList ;
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
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/appWater/qryWaterHistoryData');
    // var params = Map<String, dynamic>();
    // params["pageNum"] = index;
    // params["pageSize"] = 10;
    // params["data"] = {"fraId":widget.fraId,"time":timeData};
    // var result=await http.post(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //   body: jsonEncode(params), );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(utf8decoder.convert(result.bodyBytes)));
    String text='{"msg":"success","code":200,"data":{"totalCount":2415,"pageSize":10,"totalPage":242,"currPage":1,"list":[{"dataTime":"2021-12-29 10:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"氨氮(1.31),高锰酸盐指数(1.16),溶解氧(-0.31)","indexName":"pollutionIndexName"},{"unit":"℃","data":7.6,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":3.43,"indexName":"溶解氧"},{"unit":"μs/cm","data":582.2,"indexName":"电导率"},{"unit":"NTU","data":731.72,"indexName":"浊度"},{"unit":"mg/L","data":12.97,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":2.31,"indexName":"氨氮"},{"unit":"mg/L","data":0.03,"indexName":"总磷"},{"unit":"mg/L","data":0.77,"indexName":"总氮"}]},{"dataTime":"2021-12-29 09:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"氨氮(1.19),总磷(4.2)","indexName":"pollutionIndexName"},{"unit":"℃","data":2.1,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":5.46,"indexName":"溶解氧"},{"unit":"μs/cm","data":421.61,"indexName":"电导率"},{"unit":"NTU","data":526.27,"indexName":"浊度"},{"unit":"mg/L","data":2.97,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":2.19,"indexName":"氨氮"},{"unit":"mg/L","data":0.26,"indexName":"总磷"},{"unit":"mg/L","data":0.49,"indexName":"总氮"}]},{"dataTime":"2021-12-29 08:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"总磷(3.4),总氮(0.82),氨氮(0.74)","indexName":"pollutionIndexName"},{"unit":"℃","data":3.1,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":2.37,"indexName":"溶解氧"},{"unit":"μs/cm","data":434.26,"indexName":"电导率"},{"unit":"NTU","data":598.49,"indexName":"浊度"},{"unit":"mg/L","data":4.52,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":1.74,"indexName":"氨氮"},{"unit":"mg/L","data":0.22,"indexName":"总磷"},{"unit":"mg/L","data":1.82,"indexName":"总氮"}]},{"dataTime":"2021-12-29 07:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"总磷(3.2),高锰酸盐指数(0.28)","indexName":"pollutionIndexName"},{"unit":"℃","data":6.6,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":6.36,"indexName":"溶解氧"},{"unit":"μs/cm","data":768.71,"indexName":"电导率"},{"unit":"NTU","data":799.85,"indexName":"浊度"},{"unit":"mg/L","data":7.68,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":0.59,"indexName":"氨氮"},{"unit":"mg/L","data":0.21,"indexName":"总磷"},{"unit":"mg/L","data":0.81,"indexName":"总氮"}]},{"dataTime":"2021-12-29 06:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"总氮(1.04),总磷(1.2),溶解氧(-0.47)","indexName":"pollutionIndexName"},{"unit":"℃","data":8.0,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":2.65,"indexName":"溶解氧"},{"unit":"μs/cm","data":564.82,"indexName":"电导率"},{"unit":"NTU","data":961.06,"indexName":"浊度"},{"unit":"mg/L","data":1.54,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":1.24,"indexName":"氨氮"},{"unit":"mg/L","data":0.11,"indexName":"总磷"},{"unit":"mg/L","data":2.04,"indexName":"总氮"}]},{"dataTime":"2021-12-29 05:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"总磷(5.8),总氮(0.66),氨氮(0.72)","indexName":"pollutionIndexName"},{"unit":"℃","data":7.8,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":9.0,"indexName":"溶解氧"},{"unit":"μs/cm","data":935.81,"indexName":"电导率"},{"unit":"NTU","data":808.52,"indexName":"浊度"},{"unit":"mg/L","data":0.77,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":1.72,"indexName":"氨氮"},{"unit":"mg/L","data":0.34,"indexName":"总磷"},{"unit":"mg/L","data":1.66,"indexName":"总氮"}]},{"dataTime":"2021-12-29 04:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"氨氮(1.06),总氮(0.96),总磷(3.0)","indexName":"pollutionIndexName"},{"unit":"℃","data":7.5,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":9.63,"indexName":"溶解氧"},{"unit":"μs/cm","data":712.27,"indexName":"电导率"},{"unit":"NTU","data":946.11,"indexName":"浊度"},{"unit":"mg/L","data":9.71,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":2.06,"indexName":"氨氮"},{"unit":"mg/L","data":0.2,"indexName":"总磷"},{"unit":"mg/L","data":1.96,"indexName":"总氮"}]},{"dataTime":"2021-12-29 03:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"总磷(3.8),氨氮(0.96)","indexName":"pollutionIndexName"},{"unit":"℃","data":7.5,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":8.26,"indexName":"溶解氧"},{"unit":"μs/cm","data":576.33,"indexName":"电导率"},{"unit":"NTU","data":773.81,"indexName":"浊度"},{"unit":"mg/L","data":5.97,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":1.96,"indexName":"氨氮"},{"unit":"mg/L","data":0.24,"indexName":"总磷"},{"unit":"mg/L","data":0.7,"indexName":"总氮"}]},{"dataTime":"2021-12-29 02:00:00","historyData":[{"unit":"","data":5,"indexName":"waterType"},{"unit":"","data":"总氮(0.88),氨氮(0.8),高锰酸盐指数(1.34)","indexName":"pollutionIndexName"},{"unit":"℃","data":8.3,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":6.15,"indexName":"溶解氧"},{"unit":"μs/cm","data":538.51,"indexName":"电导率"},{"unit":"NTU","data":539.63,"indexName":"浊度"},{"unit":"mg/L","data":14.05,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":1.8,"indexName":"氨氮"},{"unit":"mg/L","data":0.01,"indexName":"总磷"},{"unit":"mg/L","data":1.88,"indexName":"总氮"}]},{"dataTime":"2021-12-29 01:00:00","historyData":[{"unit":"","data":6,"indexName":"waterType"},{"unit":"","data":"总氮(1.34),总磷(2.2),高锰酸盐指数(0.48)","indexName":"pollutionIndexName"},{"unit":"℃","data":8.9,"indexName":"水温"},{"unit":"无量纲","data":"-","indexName":"PH"},{"unit":"mg/L","data":8.23,"indexName":"溶解氧"},{"unit":"μs/cm","data":132.25,"indexName":"电导率"},{"unit":"NTU","data":340.83,"indexName":"浊度"},{"unit":"mg/L","data":8.86,"indexName":"高锰酸盐指数"},{"unit":"mg/L","data":0.66,"indexName":"氨氮"},{"unit":"mg/L","data":0.16,"indexName":"总磷"},{"unit":"mg/L","data":2.34,"indexName":"总氮"}]}]}}';
    parahistorymodel=WaterParaHistoryModel.fromJson(json.decode(text) ) ;

    setState(() {
      XiangDataList.addAll(parahistorymodel.data!.list!.toList());
    });


    //DayIndexDataList=parahistorymodel.data!['list'].dayIndexData;


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(6, 36, 66, 1),
        title: Text('断面监测历史数据',style: TextStyle(
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
                          setState(() {
                            dateyear=date.year;
                            timeData=formatDate(date, [yyyy, '-', mm, '-', dd]);
                            index=1;
                            XiangDataList.clear();
                            _sitesRealTimedPost();
                          });
                          print(formatDate(date, [yyyy, '-', mm, '-', dd]));
                          // setState(() {
                          //
                          // });
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
                    itemCount: XiangDataList.length+1,//个数
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
                      if (index == XiangDataList.length) {
                        return _buildLoadMoreItem();


                      } else {
                        // 最后一项，显示加载更多布局
                        return getAlarmListViewItem(XiangDataList[index]);
                      }

                    }), onRefresh: _handleRefresh)),


          ],
        ),
      ),


    );
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
      XiangDataList.clear();
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


}


Widget getAlarmListViewItem(WaterXiang xiang) {
  return Container(
    decoration:  BoxDecoration(
        color: const Color.fromRGBO(185, 233, 255, 0.05),
        borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
    ),
    // width: Adapt.px(686),
    // height: Adapt.px((xiang.historyData!.length+1)*85),
    child: Column(
      children: [
        SizedBox(height: Adapt.px(32),),
        Row(
          children: [
            SizedBox(width: Adapt.px(32),),
            Text(xiang.dataTime??"-".toString(), style: TextStyle(
                color:  Color.fromRGBO(185, 233, 255, 1),
                fontSize: Adapt.px(28)),
            ),
          ],
        ),

        Container(
          constraints: BoxConstraints(
            minWidth: Adapt.px(686),
            minHeight: Adapt.px(xiang.historyData!.length*85),
            maxHeight: Adapt.px(xiang.historyData!.length*121),
            maxWidth: Adapt.px(686),
          ),
              child:ListView.builder(
                  itemCount: xiang.historyData!.length,//个数
                  // itemExtent: Adapt.px(85),//行高
                  // scrollDirection: Axis.vertical,//滑动方向
                  primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                  //内容适配
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),//禁止滚动

                  itemBuilder:(BuildContext context,int index){
                    return getRealtimeDataListListViewItem(xiang.historyData![index]);
                  }),),

        SizedBox(height: Adapt.px(32),),


      ],
    ),
    // 下边框
    // decoration: const BoxDecoration(
    //     border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 0.1)))
    // ),
  ) ;
}
Widget getRealtimeDataListListViewItem(WPHistoryData waterrealtimedata) {
  if(waterrealtimedata.indexName=='waterType'){
    waterrealtimedata.indexName='水质类别';
  }else if(waterrealtimedata.indexName=='pollutionIndexName'){
    waterrealtimedata.indexName='主要污染指标';
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
          child:  IntrinsicHeight(
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
            ),
          ),

        ),
        SizedBox(height: Adapt.px(24), ),
        Divider(indent: Adapt.px(32),endIndent: Adapt.px(32),height: Adapt.px(1),color: Color.fromRGBO(255, 255, 255, 0.1))
      ],
    ),


  ) ;
}

