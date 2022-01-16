import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';
import 'package:flutter_huiyuantong/model/pollution_outlet_model.dart';
import 'package:flutter_huiyuantong/model/water_section_model.dart';
import 'package:flutter_huiyuantong/page/pollution_outlet_details.dart';
import 'package:flutter_huiyuantong/page/water_section_details_page.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'air_site_details.dart';
import 'chaxun/pollution_chaxun_page.dart';
class PollutionOutlet extends StatefulWidget{
  const PollutionOutlet({Key? key}) : super(key: key);
  @override
  _PollutionOutletState createState()=>_PollutionOutletState();
}
class _PollutionOutletState extends State<PollutionOutlet>{
  final GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();
  final List<SortCondition> _typesList = [];
  late SortCondition _selectDistanceSortCondition;
  var pollutionoutletmodel;

  late List<OutletData> pollutionoutletmodelList ;
  String ? typecheckitem;
  String  ? outIds;
  String  ? comId='-1';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _typesList.add(SortCondition(name: '全部企业',devType: '-1', isSelected: false));

    });

    _typeDownPost();


  }
  //类型下拉数据
  Future<void> _typeDownPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/stationOverview/getAllComAndOutlet');
    // var result=await http.post(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    // );
    var jsonTxt1 ='{"msg":"success","code":200,"data":[{"id":1,"name":"大安化工南村街道分公司","person":null,"address":null,"socialCode":null,"contacts":null,"phone":null,"director":null,"dirPhone":null,"scale":null,"comLongitude":null,"comLatitude":null,"performance":null,"performanceName":null,"prodStatus":null,"prodStatusName":null,"consStatus":null,"consStatusName":null,"classType":null,"classTypeName":null,"monDevice":null,"monDeviceName":null,"orgCode":null,"note":null,"createTime":null,"busiParkId":null,"crippledCount":null,"detailedAddress":null,"deviceAddress":null,"deviceDetailedAddress":null,"comDetailedType":null,"delStatus":0,"delStatusName":null,"allCount":0,"alarmCount":0,"standCount":0,"isKey":0,"industryId":null,"induName":null,"outletList":[{"id":1,"name":"废气1-南村小区街道","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":1,"delStatus":0,"onLineState":2,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":5,"name":"废气5","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":1,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":6,"name":"废水1","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":1,"delStatus":0,"onLineState":2,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":10,"name":"废水5","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":1,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null}],"comType":2,"comTypeName":null,"outName":null,"outId":0,"onLineState":0,"indusName":null,"outType":0,"urls":null,"alarmMessageCount":0,"alarmMul":0.0,"validRate":0.0,"deficValueRate":0.0,"zeroValueRate":0.0,"alarmMessageCountIndex":0.0,"riskIndex":0.0,"distance":0.0,"alarmValue":0.0,"show":true,"declear":false,"licenceCode":null,"licenceDetailedName":null},{"id":2,"name":"重型汽车公司1","person":null,"address":null,"socialCode":null,"contacts":null,"phone":null,"director":null,"dirPhone":null,"scale":null,"comLongitude":null,"comLatitude":null,"performance":null,"performanceName":null,"prodStatus":null,"prodStatusName":null,"consStatus":null,"consStatusName":null,"classType":null,"classTypeName":null,"monDevice":null,"monDeviceName":null,"orgCode":null,"note":null,"createTime":null,"busiParkId":null,"crippledCount":null,"detailedAddress":null,"deviceAddress":null,"deviceDetailedAddress":null,"comDetailedType":null,"delStatus":0,"delStatusName":null,"allCount":0,"alarmCount":0,"standCount":0,"isKey":0,"industryId":null,"induName":null,"outletList":[{"id":2,"name":"废气2","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":2,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":7,"name":"废水2","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":2,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null}],"comType":2,"comTypeName":null,"outName":null,"outId":0,"onLineState":0,"indusName":null,"outType":0,"urls":null,"alarmMessageCount":0,"alarmMul":0.0,"validRate":0.0,"deficValueRate":0.0,"zeroValueRate":0.0,"alarmMessageCountIndex":0.0,"riskIndex":0.0,"distance":0.0,"alarmValue":0.0,"show":false,"declear":false,"licenceCode":null,"licenceDetailedName":null},{"id":3,"name":"新三力有限公司","person":null,"address":null,"socialCode":null,"contacts":null,"phone":null,"director":null,"dirPhone":null,"scale":null,"comLongitude":null,"comLatitude":null,"performance":null,"performanceName":null,"prodStatus":null,"prodStatusName":null,"consStatus":null,"consStatusName":null,"classType":null,"classTypeName":null,"monDevice":null,"monDeviceName":null,"orgCode":null,"note":null,"createTime":null,"busiParkId":null,"crippledCount":null,"detailedAddress":null,"deviceAddress":null,"deviceDetailedAddress":null,"comDetailedType":null,"delStatus":0,"delStatusName":null,"allCount":0,"alarmCount":0,"standCount":0,"isKey":0,"industryId":null,"induName":null,"outletList":[{"id":3,"name":"废气3","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":3,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":8,"name":"废水3","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":3,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null},{"id":9,"name":"废水4","type":2,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":3,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null}],"comType":2,"comTypeName":null,"outName":null,"outId":0,"onLineState":0,"indusName":null,"outType":0,"urls":null,"alarmMessageCount":0,"alarmMul":0.0,"validRate":0.0,"deficValueRate":0.0,"zeroValueRate":0.0,"alarmMessageCountIndex":0.0,"riskIndex":0.0,"distance":0.0,"alarmValue":0.0,"show":false,"declear":false,"licenceCode":null,"licenceDetailedName":null},{"id":4,"name":"天鼎核电公司","person":null,"address":null,"socialCode":null,"contacts":null,"phone":null,"director":null,"dirPhone":null,"scale":null,"comLongitude":null,"comLatitude":null,"performance":null,"performanceName":null,"prodStatus":null,"prodStatusName":null,"consStatus":null,"consStatusName":null,"classType":null,"classTypeName":null,"monDevice":null,"monDeviceName":null,"orgCode":null,"note":null,"createTime":null,"busiParkId":null,"crippledCount":null,"detailedAddress":null,"deviceAddress":null,"deviceDetailedAddress":null,"comDetailedType":null,"delStatus":0,"delStatusName":null,"allCount":0,"alarmCount":0,"standCount":0,"isKey":0,"industryId":null,"induName":null,"outletList":[{"id":4,"name":"废气4","type":1,"typeName":null,"status":0,"statusName":null,"waterType":null,"longitude":null,"latitude":null,"remark":null,"companyId":4,"delStatus":0,"onLineState":1,"busiParkId":null,"outType":2,"comName":null,"comId":0,"waterTypeName":null}],"comType":2,"comTypeName":null,"outName":null,"outId":0,"onLineState":0,"indusName":null,"outType":0,"urls":null,"alarmMessageCount":0,"alarmMul":0.0,"validRate":0.0,"deficValueRate":0.0,"zeroValueRate":0.0,"alarmMessageCountIndex":0.0,"riskIndex":0.0,"distance":0.0,"alarmValue":0.0,"show":false,"declear":false,"licenceCode":null,"licenceDetailedName":null}]}';
    Utf8Decoder utf8decoder = const Utf8Decoder();
    Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(jsonTxt1));
    print(data['data'].toList());
    List<dynamic> list=data['data'].toList();
    setState(() {
      for(int i=0;i<list.length;i++){
        _typesList.add(SortCondition(name: list[i]['name'].toString(),devType: list[i]['id'].toString(), isSelected: false));
      }
    });
  }
  Future<PollutionOutletModel> pollutionRealTimedPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // print(HttpUtil.url);
    // var url = Uri.parse('${HttpUtil.url}/api/appPollution/outletListData');
    // var result=await http.post(url,headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //     body: jsonEncode({'outIds':outIds,'comId':comId}));
    var jsonTxt1 = '{"msg":"success","code":200,"data":[{"outletName":"废水1","alarmCount":25,"outletId":6,"updateTime":"2021-12-28 15:00:00","indexData":["COD","NH₃-N","总磷","总氮"],"comName":"大安化工南村街道分公司","type":2},{"outletName":"废水2","alarmCount":25,"outletId":7,"updateTime":"2021-12-28 15:00:00","indexData":["COD","NH₃-N","总磷","总氮"],"comName":"重型汽车公司1","type":2},{"outletName":"废水3","alarmCount":21,"outletId":8,"updateTime":"2021-12-28 15:00:00","indexData":["COD","NH₃-N","总磷","总氮"],"comName":"新三力有限公司","type":2},{"outletName":"废水5","alarmCount":17,"outletId":10,"updateTime":"2021-12-28 15:00:00","indexData":["COD","NH₃-N","总磷","总氮"],"comName":"大安化工南村街道分公司","type":2},{"outletName":"废气4","alarmCount":16,"outletId":4,"updateTime":"2021-12-28 15:00:00","indexData":["SO₂","NOx","PM"],"comName":"天鼎核电公司","type":1},{"outletName":"废气3","alarmCount":15,"outletId":3,"updateTime":"2021-12-28 15:00:00","indexData":["SO₂","NOx","PM"],"comName":"新三力有限公司","type":1},{"outletName":"废气5","alarmCount":15,"outletId":5,"updateTime":"2021-12-28 15:00:00","indexData":["SO₂","NOx","PM"],"comName":"大安化工南村街道分公司","type":1},{"outletName":"废水4","alarmCount":15,"outletId":9,"updateTime":"2021-12-28 15:00:00","indexData":["COD","NH₃-N","总磷","总氮"],"comName":"新三力有限公司","type":2},{"outletName":"废气1-南村小区街道","alarmCount":13,"outletId":1,"updateTime":"2021-12-28 15:00:00","indexData":["SO₂","NOx","PM"],"comName":"大安化工南村街道分公司","type":1},{"outletName":"废气2","alarmCount":12,"outletId":2,"updateTime":"2021-12-28 15:00:00","indexData":["SO₂","NOx","PM"],"comName":"重型汽车公司1","type":1}]}';
    Utf8Decoder utf8decoder = const Utf8Decoder();
    // print(json.decode(utf8decoder.convert(result.bodyBytes)));
    //pollutionoutletmodel=PollutionOutletModel.fromJson(json.decode(utf8decoder.convert(result.bodyBytes)));
    pollutionoutletmodel=PollutionOutletModel.fromJson(json.decode(jsonTxt1));
    pollutionoutletmodelList=pollutionoutletmodel.data;
    return pollutionoutletmodel;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(6, 36, 66, 1),
          title: Text('排口数据',style: TextStyle(
            color: Color.fromRGBO(185, 233, 255, 1),
            fontSize: Adapt.px(32),)),
          centerTitle:true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pop(context);
          }),
          actions: [
            IconButton(icon: const Icon(Icons.search),color: const Color.fromRGBO(185, 233, 255, 1), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> PollutionChaXunPage()));
            }),
          ],
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
              SizedBox(height: Adapt.px(8),),
              Expanded(child: Stack(
                key: _stackKey,
                children: [
                  Column(
                    children: [
                      Container(


                        child: GZXDropDownHeader(
                          items: [
                            GZXDropDownHeaderItem(
                              typecheckitem??"全部企业",
                              //style: TextStyle(color: Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28)),
                              iconData: Icons.keyboard_arrow_down_sharp,
                              iconDropDownData: Icons.keyboard_arrow_up_sharp,
                            ),

                          ],
                          controller: _dropdownMenuController,
                          stackKey: _stackKey,
                          // 头部的高度
                          height: Adapt.px(70),
//                         // 头部背景颜色
                          color: Color.fromRGBO(185, 233, 255, 0.3),
//                         // 头部边框宽度
                          borderWidth: 0,
                          // 头部边框颜色
                          borderColor:Color.fromRGBO(185, 233, 255, 0),
//                         // 分割线高度
                          dividerHeight: Adapt.px(88),
//                         // 分割线颜色
                          dividerColor: Color.fromRGBO(185, 233, 255, 0),
                          style: TextStyle(color:Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(28)),
//                // 下拉时文字样式
                          dropDownStyle: TextStyle(
                            fontSize: Adapt.px(28),
                            color: Color.fromRGBO(185, 233, 255, 1),
                          ),
                          // 文字样式

                        ),),
                      Expanded(child: FutureBuilder(future: pollutionRealTimedPost(),
                          builder: (BuildContext context, AsyncSnapshot<PollutionOutletModel> snapshot){
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return  const Text('网络连接失败');
                              case ConnectionState.waiting:
                                return  const Center(child: CircularProgressIndicator());
                              case  ConnectionState.active:
                                return const Text('');
                              case ConnectionState.done:
                                if(snapshot.hasError){
                                  return Text(
                                    '${snapshot.error}',
                                    style: const TextStyle(color: Colors.red),
                                  );
                                }else{
                                  if(pollutionoutletmodelList.isEmpty){
                                    return Center(child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image(image: const AssetImage('images/nulldata.png'), width: Adapt.px(80), height: Adapt.px(80),),
                                        Text('抱歉！暂无数据', style: TextStyle(
                                            color:  Color.fromRGBO(185, 233, 255, 0.45),
                                            fontSize: Adapt.px(32)),
                                        ),
                                      ],
                                    ),);
                                  }else{
                                    return ListView.separated(
                                        itemCount: pollutionoutletmodelList.length,//个数
                                        // scrollDirection: Axis.vertical,//滑动方向
                                        primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                                        //内容适配
                                        shrinkWrap: true,
                                        //physics: const NeverScrollableScrollPhysics(),//禁止滚动
                                        padding: const EdgeInsets.only(top: 12,bottom: 12),
                                        separatorBuilder: (BuildContext context, int index) =>
                                            Container(
                                              height: Adapt.px(24),
                                              color: Colors.transparent,
                                            ),
                                        itemBuilder:(BuildContext context,int index){
                                          return getPollutionListViewItem(pollutionoutletmodelList[index], context);
                                        });
                                  }

                                }
                            }
                          }
                      ),),
                    ],
                  ),

                  GZXDropDownMenu(
                    // controller用于控制menu的显示或隐藏
                    controller: _dropdownMenuController,
                    // 下拉菜单显示或隐藏动画时长
                    animationMilliseconds: 300,
                    // 下拉后遮罩颜色
                    maskColor: Theme.of(context).primaryColor.withOpacity(0),
                    // 下拉菜单，高度自定义，你想显示什么就显示什么，完全由你决定，你只需要在选择后调用_dropdownMenuController.hide();即可
                    menus: [
                      GZXDropdownMenuBuilder(
                          dropDownHeight: Adapt.px(88) * _typesList.length,
                          dropDownWidget: _buildConditionListWidget(_typesList, (value) {
                            _selectDistanceSortCondition = value;
                            typecheckitem = _selectDistanceSortCondition.name;
                            _dropdownMenuController.hide();
                            setState(() {
                              print(value.name);
                              comId=value.devType;});
                          })),

                    ],
                  ),

                ],
              ),),


              //列表页

            ],
          ),

          // Column(
          //   children: [
          //     SizedBox(height: Adapt.px(8),),
          //     Row(children: [
          //
          //       Container(
          //         width:  Adapt.px(327),
          //         height:  Adapt.px(70),
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Color.fromRGBO(185, 233, 255, 0.05),width: 0),
          //           borderRadius: BorderRadius.circular(Adapt.px(24)),
          //           color: Color.fromRGBO(185, 233, 255, 0.05),
          //
          //         ),
          //         child:
          //         DropdownButton<String>(
          //           isExpanded: true,
          //           isDense: false,
          //           hint: Container(
          //             padding: EdgeInsets.only(left: Adapt.px(24)),
          //             child: Text('站点数据',style: TextStyle(
          //             color: Color.fromRGBO(185, 233, 255, 1),
          //             fontSize: Adapt.px(28),)),),
          //           underline: Container(height: 0),
          //
          //           items: <String>['A', 'B', 'C', 'D'].map((String value) {
          //             return new DropdownMenuItem<String>(
          //
          //               value: value,
          //               child: new Text(value),
          //             );
          //           }).toList(),
          //           onChanged: (_) {},
          //         ),
          //       ),
          //
          //     ],),
          //     SizedBox(height: Adapt.px(24),),
          //     // ListView.builder(
          //     //     itemBuilder: (BuildContext context,int index){
          //     //   return getSiteListViewItem(AlarmList[index]);},
          //     //   itemCount: 10,//个数
          //     //   itemExtent: Adapt.px(284),
          //     //
          //     // )
          //   ],
          // ),

        )
    );
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
Widget getPollutionListViewItem(OutletData outletdata,BuildContext context) {
  String indexdata="";
  indexdata=listToString(outletdata.indexData!)!;
  String typeName="";
  if(outletdata.type==2){
    typeName="废水";
  }else{typeName="废气";}
  return InkWell(
    onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> OutletDetails(outletdata.outletId.toString())));
    },
    child: Container(
      width: Adapt.px(686),
      height: Adapt.px(400),
      decoration:  BoxDecoration(
          color: const Color.fromRGBO(185, 233, 255, 0.05),
          borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
      ),

      child: Column(
        children: [
          SizedBox(height: Adapt.px(32),),
          Row(
            children: [
              SizedBox(width:Adapt.px(32)),
              Image(image: const AssetImage('images/section.png'), width: Adapt.px(28), height: Adapt.px(28),),
              SizedBox(width:Adapt.px(25)),
              Text(outletdata.outletName??'-'.toString(), style: TextStyle(
                  color:  Color.fromRGBO(185, 233, 255, 1),
                  fontSize: Adapt.px(32)),
              ),
            ],
          ),
          SizedBox(height: Adapt.px(40),),
          Row(
            children: [
              SizedBox(width:Adapt.px(32)),
              Container(
                width: Adapt.px(407),
                height: Adapt.px(104),
                decoration:  BoxDecoration(
                    color: Color.fromRGBO(185, 233, 255, 0.05),
                    borderRadius: BorderRadius.all(Radius.circular(Adapt.px(8)))
                ),
                child: Column(
                  children: [
                    SizedBox(height:Adapt.px(8)),
                    Text(indexdata, style: TextStyle(
                      color:  Color.fromRGBO(255, 255, 255, 1),
                      fontSize: Adapt.px(32),),

                    ),
                    SizedBox(height:Adapt.px(4)),
                    Text('监测指标', style: TextStyle(
                        color:  Color.fromRGBO(185, 233, 255, 1),
                        fontSize: Adapt.px(24)),
                    ),
                  ],
                ),
              ),
              SizedBox(width:Adapt.px(24)),
              Container(
                width: Adapt.px(191),
                height: Adapt.px(104),
                decoration:  BoxDecoration(
                    color: Color.fromRGBO(185, 233, 255, 0.05),
                    borderRadius: BorderRadius.all(Radius.circular(Adapt.px(8)))
                ),
                child: Column(
                  children: [
                    SizedBox(height:Adapt.px(8)),
                    Text(outletdata.alarmCount??'-'.toString(), style: TextStyle(
                        color:  Color.fromRGBO(255, 255, 255, 1),
                        fontSize: Adapt.px(32)),
                    ),
                    SizedBox(height:Adapt.px(4)),
                    Text('当日报警次数', style: TextStyle(
                        color:  Color.fromRGBO(185, 233, 255, 1),
                        fontSize: Adapt.px(24)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Adapt.px(32),),
          Row(
            children: [
              SizedBox(width:Adapt.px(32)),
              Text('所属企业：', style: TextStyle(
                  color:  Color.fromRGBO(185, 233, 255, 1),
                  fontSize: Adapt.px(24)),
              ),
              Text(outletdata.comName??'-'.toString(), style: TextStyle(
  color:  const Color.fromRGBO(255, 255, 255, 1),
  fontSize: Adapt.px(24)),overflow:TextOverflow.ellipsis,),
              Expanded(child: Container()),

              Text('排口类型：', style: TextStyle(
                  color:  Color.fromRGBO(185, 233, 255, 1),
                  fontSize: Adapt.px(24)),
              ),
              Text(typeName, style: TextStyle(
                  color:  Color.fromRGBO(255, 255, 255, 1),
                  fontSize: Adapt.px(24)),
              ),
              SizedBox(width:Adapt.px(32)),
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
              Text(outletdata.updateTime??'-'.toString(), style: TextStyle(
                  color:  Color.fromRGBO(255, 255, 255, 1),
                  fontSize: Adapt.px(24)),
              ),

            ],
          ),
        ],
      ),
      // 下边框
      // decoration: const BoxDecoration(
      //     border: Border(bottom: BorderSide(width: 1, color: Color.fromRGBO(255, 255, 255, 0.1)))
      // ),
    ),
  );

}
Image imageItem(AirSiteData airsitedata) {
  if(airsitedata.deviceType==4){
    return Image(
      image: const AssetImage('images/siteechou.png'), width: Adapt.px(28), height: Adapt.px(28),);
  }else if(airsitedata.deviceType==3){
    return Image(
      image: const AssetImage('images/siteyouduyouhai.png'), width: Adapt.px(28), height: Adapt.px(28),);
  }else if(airsitedata.deviceType==2){
    return Image(
      image: const AssetImage('images/sitewangge.png'), width: Adapt.px(28), height: Adapt.px(28),);
  }else {
    return Image(
      image: const AssetImage('images/siteguobiao.png'), width: Adapt.px(28), height: Adapt.px(28),);
  }
}
class SortCondition {
  String name;
  String devType;

  bool isSelected;

  SortCondition({
    required this.name,
    required this.devType,
    required this.isSelected,
  });
}
_buildConditionListWidget(items, void itemOnTap(SortCondition sortCondition)) {
  return Container(color: const Color.fromRGBO(6, 36, 66, 1),child:  ListView.separated(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    itemCount: items.length,
    // item 的个数
    separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
    // 添加分割线
    itemBuilder: (BuildContext context, int index) {
      return gestureDetector(items, index, itemOnTap, context);
    },
  ),);

}
GestureDetector gestureDetector(items, int index, void itemOnTap(SortCondition sortCondition), BuildContext context) {
  SortCondition goodsSortCondition = items[index];
  return GestureDetector(
    onTap: () {
      for (var value in items) {
        value.isSelected = false;
      }
      goodsSortCondition.isSelected = true;

      itemOnTap(goodsSortCondition);
    },
    child: Container(
      color: const Color.fromRGBO(6, 36, 66, 1),
      height: Adapt.px(80),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: Adapt.px(32),
          ),
          Expanded(
            child: Text(
              goodsSortCondition.name,
              style: TextStyle(
                color: goodsSortCondition.isSelected ? const Color.fromRGBO(46, 228, 149, 1): const Color.fromRGBO(184, 233, 255, 0.75),
              ),
            ),
          ),
          goodsSortCondition.isSelected
              ? Icon(
            Icons.check,
            color: const Color.fromRGBO(46, 228, 149, 1),
            size: Adapt.px(32),
          )
              : SizedBox(),
        ],
      ),
    ),
  );
}