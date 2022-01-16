import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/paramater_history_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
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
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/appAirData/appQryAirRealtimeData');
    // var params = Map<String, dynamic>();
    // params["pageNum"] = index;
    // params["pageSize"] = 10;
    // params["data"] = {"deviceType":widget.deviceType, "sn":widget.sn,"time":timeData};
    // var result=await http.post(url,
    //     headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //     body: jsonEncode(params), );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
   // Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(utf8decoder.convert(result.bodyBytes)));
    String text='{"msg":"success","code":200,"data":{"totalCount":22454,"pageSize":10,"totalPage":2246,"currPage":1,"list":[{"dataTime":"2021-12-28 17:20:04","dayIndexData":[{"unit":"mg/m³","data":84.35,"indexName":"NH₃"},{"unit":"mg/m³","data":99.67,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":101.85,"indexName":"H₂S"},{"unit":"mg/m³","data":74.08,"indexName":"CH₄S"},{"unit":"mg/m³","data":119.43,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":71.41,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":58.52,"indexName":"CS₂"},{"unit":"µg/m³","data":56.08,"indexName":"C₈H₈"},{"unit":"µg/m³","data":78.05,"indexName":"OU"}]},{"dataTime":"2021-12-28 16:20:01","dayIndexData":[{"unit":"mg/m³","data":87.03,"indexName":"NH₃"},{"unit":"mg/m³","data":107.92,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":105.38,"indexName":"H₂S"},{"unit":"mg/m³","data":99.44,"indexName":"CH₄S"},{"unit":"mg/m³","data":107,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":113.51,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":71,"indexName":"CS₂"},{"unit":"µg/m³","data":53.63,"indexName":"C₈H₈"},{"unit":"µg/m³","data":85.51,"indexName":"OU"}]},{"dataTime":"2021-12-28 15:20:03","dayIndexData":[{"unit":"mg/m³","data":201.54,"indexName":"NH₃"},{"unit":"mg/m³","data":276.7,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":257.41,"indexName":"H₂S"},{"unit":"mg/m³","data":217.89,"indexName":"CH₄S"},{"unit":"mg/m³","data":137.12,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":222.51,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":197.04,"indexName":"CS₂"},{"unit":"µg/m³","data":134.05,"indexName":"C₈H₈"},{"unit":"µg/m³","data":194.62,"indexName":"OU"}]},{"dataTime":"2021-12-28 14:20:01","dayIndexData":[{"unit":"mg/m³","data":34.45,"indexName":"NH₃"},{"unit":"mg/m³","data":48.58,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":34.26,"indexName":"H₂S"},{"unit":"mg/m³","data":40.25,"indexName":"CH₄S"},{"unit":"mg/m³","data":33.1,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":49.8,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":26.18,"indexName":"CS₂"},{"unit":"µg/m³","data":40.93,"indexName":"C₈H₈"},{"unit":"µg/m³","data":28.55,"indexName":"OU"}]},{"dataTime":"2021-12-28 13:20:01","dayIndexData":[{"unit":"mg/m³","data":365.03,"indexName":"NH₃"},{"unit":"mg/m³","data":397.17,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":338.59,"indexName":"H₂S"},{"unit":"mg/m³","data":385.48,"indexName":"CH₄S"},{"unit":"mg/m³","data":313.29,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":325.46,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":287.96,"indexName":"CS₂"},{"unit":"µg/m³","data":321.72,"indexName":"C₈H₈"},{"unit":"µg/m³","data":370.41,"indexName":"OU"}]},{"dataTime":"2021-12-28 12:20:05","dayIndexData":[{"unit":"mg/m³","data":355.42,"indexName":"NH₃"},{"unit":"mg/m³","data":327.16,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":313.66,"indexName":"H₂S"},{"unit":"mg/m³","data":389.64,"indexName":"CH₄S"},{"unit":"mg/m³","data":313.73,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":348.42,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":296.08,"indexName":"CS₂"},{"unit":"µg/m³","data":376.46,"indexName":"C₈H₈"},{"unit":"µg/m³","data":295.74,"indexName":"OU"}]},{"dataTime":"2021-12-28 11:20:01","dayIndexData":[{"unit":"mg/m³","data":184.27,"indexName":"NH₃"},{"unit":"mg/m³","data":191.76,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":169.67,"indexName":"H₂S"},{"unit":"mg/m³","data":251.01,"indexName":"CH₄S"},{"unit":"mg/m³","data":148.36,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":265.29,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":184.7,"indexName":"CS₂"},{"unit":"µg/m³","data":171.04,"indexName":"C₈H₈"},{"unit":"µg/m³","data":260.29,"indexName":"OU"}]},{"dataTime":"2021-12-28 10:20:04","dayIndexData":[{"unit":"mg/m³","data":257.73,"indexName":"NH₃"},{"unit":"mg/m³","data":270.48,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":258.01,"indexName":"H₂S"},{"unit":"mg/m³","data":222.92,"indexName":"CH₄S"},{"unit":"mg/m³","data":215.91,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":192.49,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":132.22,"indexName":"CS₂"},{"unit":"µg/m³","data":265.61,"indexName":"C₈H₈"},{"unit":"µg/m³","data":242.54,"indexName":"OU"}]},{"dataTime":"2021-12-28 09:20:01","dayIndexData":[{"unit":"mg/m³","data":61.84,"indexName":"NH₃"},{"unit":"mg/m³","data":54.93,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":61.14,"indexName":"H₂S"},{"unit":"mg/m³","data":110.93,"indexName":"CH₄S"},{"unit":"mg/m³","data":86.71,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":75.71,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":81.47,"indexName":"CS₂"},{"unit":"µg/m³","data":90.76,"indexName":"C₈H₈"},{"unit":"µg/m³","data":87.89,"indexName":"OU"}]},{"dataTime":"2021-12-28 08:20:02","dayIndexData":[{"unit":"mg/m³","data":16.78,"indexName":"NH₃"},{"unit":"mg/m³","data":14.86,"indexName":"C₃H₉N"},{"unit":"mg/m³","data":23.67,"indexName":"H₂S"},{"unit":"mg/m³","data":8.28,"indexName":"CH₄S"},{"unit":"mg/m³","data":3.62,"indexName":"C₂H₆S"},{"unit":"µg/m³","data":1.84,"indexName":"C₂H₆S₂"},{"unit":"µg/m³","data":2.28,"indexName":"CS₂"},{"unit":"µg/m³","data":17.74,"indexName":"C₈H₈"},{"unit":"µg/m³","data":13.28,"indexName":"OU"}]}]}}';
     parahistorymodel=ParaHistoryModel.fromJson(json.decode(text) ) ;
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

