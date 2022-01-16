import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_details_model.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';
import 'package:flutter_huiyuantong/model/pollution_outlet_details_model.dart';
import 'package:flutter_huiyuantong/page/air_parameter_history.dart';
import 'package:flutter_huiyuantong/page/pollution_alarm_history.dart';
import 'package:flutter_huiyuantong/page/pollution_paramter_history.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'air_alarm_history.dart';
class OutletDetails extends StatefulWidget{
  final String outletId;

  const OutletDetails( this.outletId,   {Key? key}) : super(key: key);
  @override
  _OutletDetailsState createState()=>_OutletDetailsState();
}
class _OutletDetailsState extends State<OutletDetails>{
  var polldetailsmodel;
  late List<PollRealtimeData> RealtimeDataList ;
  late List<PollAlarmData> AlarmDataList ;

  Future<PollutionDetailsModel> alarmRealTimedGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    //
    // var url = Uri.parse('${HttpUtil.url}/api/appPollution/outletDetailData?outId=${widget.outletId}');
    // var result=await http.get(url,headers: {'busiParkId':busiParkId,'authorization':authorization});
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    // //print(json.decode(utf8decoder.convert(result.bodyBytes)));
    String text='{"msg":"success","code":200,"data":{"outletName":"废水1","outletId":6,"latitude":"39.892574","alarmData":[{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷的监测值[1.17]超过标准值(1.0)","createTime":"2021-12-29 10:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷的监测值[1.19]超过标准值(1.0)","createTime":"2021-12-29 09:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"NH₃-N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃-N的监测值[9.88]超过标准值(8.0)","createTime":"2021-12-29 09:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷的监测值[1.14]超过标准值(1.0)","createTime":"2021-12-29 08:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"COD","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"COD的监测值[61.96]超过标准值(60.0)","createTime":"2021-12-29 08:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"NH₃-N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃-N的监测值[8.81]超过标准值(8.0)","createTime":"2021-12-29 07:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"COD","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"COD的监测值[73.29]超过标准值(60.0)","createTime":"2021-12-29 07:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷的监测值[1.04]超过标准值(1.0)","createTime":"2021-12-29 05:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"COD","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"COD的监测值[71.59]超过标准值(60.0)","createTime":"2021-12-29 05:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷的监测值[1.29]超过标准值(1.0)","createTime":"2021-12-29 04:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"COD","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"COD的监测值[61.03]超过标准值(60.0)","createTime":"2021-12-29 04:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"NH₃-N","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"NH₃-N的监测值[10.00]超过标准值(8.0)","createTime":"2021-12-29 03:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总氮的监测值[27.66]超过标准值(20.0)","createTime":"2021-12-29 01:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"总氮","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总氮的监测值[28.85]超过标准值(20.0)","createTime":"2021-12-29 00:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"总磷","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"总磷的监测值[1.13]超过标准值(1.0)","createTime":"2021-12-29 00:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null},{"id":null,"pollutionId":null,"pollutionName":null,"outfallId":6,"outfallName":null,"indexId":null,"indexName":"COD","alarmType":2,"alarmGrade":4,"limitValue":null,"alarmValue":null,"alarmContent":"COD的监测值[75.63]超过标准值(60.0)","createTime":"2021-12-29 00:00:00","busiParkId":null,"alarmCount":0,"alarmValueTimes":null,"code":null,"dataTime":null}],"updateTime":"2021-12-29 10:00:00","realtimeData":[{"unit":"mg/L","data":"47.72","indexName":"COD"},{"unit":"mg/L","data":"6.31","indexName":"NH₃-N"},{"unit":"mg/L","data":"1.17","indexName":"总磷"},{"unit":"mg/L","data":"11.02","indexName":"总氮"}],"comName":"大安化工南村街道分公司","type":2,"longitude":"116.178327"}}';
    polldetailsmodel=PollutionDetailsModel.fromJson(json.decode(text));
    RealtimeDataList=polldetailsmodel.data.realtimeData;
    AlarmDataList=polldetailsmodel.data.alarmData;

    return polldetailsmodel;
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
          title: Text('排口详情',style: TextStyle(
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
              builder: (BuildContext context, AsyncSnapshot<PollutionDetailsModel> snapshot){
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
                      String typeName;
                      if(polldetailsmodel.data.type==1){
                        typeName='废气';
                      }else{
                        typeName='废水';
                      }
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
                                    Text(polldetailsmodel.data.outletName??'-'.toString(), style: TextStyle(
                                        color:  Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Adapt.px(24),),
                                Row(
                                  children: [
                                    SizedBox(width:Adapt.px(32)),
                                    Text('排口类型：', style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                    Text(typeName, style: TextStyle(
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
                                    Text('${polldetailsmodel.data.longitude??'-'},${polldetailsmodel.data.latitude??'-'}', style: TextStyle(
                                        color:  Color.fromRGBO(255, 255, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Adapt.px(24),),
                                Row(
                                  children: [
                                    SizedBox(width:Adapt.px(32)),
                                    Text('所属企业：', style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),
                                    ),
                                    Text(polldetailsmodel.data.comName??'-'.toString(), style: TextStyle(
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
                                    Text(polldetailsmodel.data.updateTime??'-'.toString(), style: TextStyle(
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  PolltionParaHistory(widget.outletId,polldetailsmodel.data.type.toString())));
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
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>  PollutionAlarmHistory(widget.outletId)));
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
Widget getGridViewItem(PollRealtimeData realtimedata) {
  return Container(
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
Widget getAlarmListViewItem(PollAlarmData pollalarmdata) {
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
                  imageItem(pollalarmdata),
                  SizedBox(width:Adapt.px(15)),
                  Text(pollalarmdata.indexName.toString(), style: TextStyle(
                      color:  Color.fromRGBO(185, 233, 255, 1),
                      fontSize: Adapt.px(32)),
                  ),
                ],
              ),
              Text(pollalarmdata.createTime??"-".toString(), style: TextStyle(
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
                pollalarmdata.alarmContent??"-".toString(),
                style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
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
Image imageItem(PollAlarmData pollalarmdata) {
  if(pollalarmdata.alarmType==2){
    if(pollalarmdata.alarmGrade==4){
      return Image(
        image: const AssetImage('images/alarmred.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else if(pollalarmdata.alarmGrade==3){
      return Image(
        image: const AssetImage('images/alarmorange.png'), width: Adapt.px(36), height: Adapt.px(36),);
    }else if(pollalarmdata.alarmGrade==2){
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