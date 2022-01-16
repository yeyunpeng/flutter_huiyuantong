import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/paramater_history_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:date_format/date_format.dart';
class ParaHistory extends StatefulWidget {
  final String sn;
  final String deviceType;
  const ParaHistory( this.sn, this.deviceType,{Key? key}) : super(key: key);

  @override
  _ParaHistoryState createState() {
    // TODO: implement createState
    return _ParaHistoryState();
  }
}

class _ParaHistoryState extends State<ParaHistory>{
  var dateyear=2021;
   String ? timeData=null;
  late ParaHistoryModel parahistorymodel;
  var index=1;
  var mydata;
   List<Xiang> XiangDataList =[];
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
    final prefs = await SharedPreferences.getInstance();
    final busiParkId = prefs.getString('busiParkId')?? "0";
    final authorization = prefs.getString('authorization') ?? "0";
    var url = Uri.parse('http://39.105.58.216:13001/api/appAirData/appQryAirRealtimeData');
    var params = Map<String, dynamic>();
    params["pageNum"] = index;
    params["pageSize"] = 10;
    params["data"] = {"deviceType":widget.deviceType, "sn":widget.sn,"time":timeData};
    var result=await http.post(url,
        headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
        body: jsonEncode(params), );
    Utf8Decoder utf8decoder = const Utf8Decoder();
    Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(utf8decoder.convert(result.bodyBytes)));
     parahistorymodel=ParaHistoryModel.fromJson(json.decode(utf8decoder.convert(result.bodyBytes)) ) ;
    print(widget.sn+timeData.toString());
    setState(() {
      XiangDataList.addAll(parahistorymodel.data!.list);
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
          title: Text('站点监测历史数据',style: TextStyle(
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


Widget getAlarmListViewItem(Xiang xiang) {
  return Container(
    decoration:  BoxDecoration(
        color: const Color.fromRGBO(185, 233, 255, 0.05),
        borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
    ),
    width: Adapt.px(686),
    height: Adapt.px((xiang.dayIndexData!.length/2+1)*100),
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
                  return getGridViewItem(xiang.dayIndexData![index]);
                },
                itemCount: xiang.dayIndexData!.length,),)
        ),



      ],
    ),
    // 下边框
    // decoration: const BoxDecoration(
    //     border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 0.1)))
    // ),
  ) ;
}
Widget getGridViewItem(DayIndexData dayIndexData) {
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
                child: Text(dayIndexData.indexName??'-'.toString(),style:  TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 0.75),
                    fontSize: Adapt.px(24)),),
              ),
            ],
          ),
          Text(
            "${dayIndexData.data??'-'.toString()}${dayIndexData.unit??''.toString()}",
            maxLines: 1,overflow: TextOverflow.ellipsis,
            style:  TextStyle(
                color:  Color.fromRGBO(255, 255, 255, 1),
                fontSize: Adapt.px(24)),),
        ],
      )
  );
}

