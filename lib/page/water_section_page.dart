import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';
import 'package:flutter_huiyuantong/model/water_section_model.dart';
import 'package:flutter_huiyuantong/page/water_section_details_page.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'air_site_details.dart';
import 'chaxun/water_chaxun_page.dart';
class WaterSection extends StatefulWidget{
  const WaterSection({Key? key}) : super(key: key);
  @override
  _WaterSectionState createState()=>_WaterSectionState();
}
class _WaterSectionState extends State<WaterSection>{
  final GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();
  GlobalKey _stackKey = GlobalKey();
  final List<SortCondition> _typesList = [];
  late SortCondition _selectDistanceSortCondition;
  var watermodel;

  late List<WaterData> watermodelList ;
  String ? typecheckitem;
  String  riverId='-1';
  String  ?fraIds;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _typesList.add(SortCondition(name: '全部河流',devType: '-1', isSelected: false));
    });

    _typeDownGet();



  }
  //类型下拉数据
  Future<void> _typeDownGet() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    // var url = Uri.parse('${HttpUtil.url}/api/waterRiver/getAllRiver');
    // var result=await http.get(url,
    //   headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    // );
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String jsontext='{"msg":"success","code":200,"data":[{"id":1,"name":"北京市_海河流域","status":null,"remark":null,"delStatus":null,"updateUser":null,"updateTime":null,"busiParkId":null,"fractureList":null},{"id":2,"name":"北京市_淮河流域","status":null,"remark":null,"delStatus":null,"updateUser":null,"updateTime":null,"busiParkId":null,"fractureList":null},{"id":3,"name":"天津市_海河流域","status":null,"remark":null,"delStatus":null,"updateUser":null,"updateTime":null,"busiParkId":null,"fractureList":null},{"id":4,"name":"河北省_海河流域","status":null,"remark":null,"delStatus":null,"updateUser":null,"updateTime":null,"busiParkId":null,"fractureList":null},{"id":5,"name":"河北省_辽河流域","status":null,"remark":null,"delStatus":null,"updateUser":null,"updateTime":null,"busiParkId":null,"fractureList":null}]}';
    Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(jsontext));
    print(data['data'].toList());
    List<dynamic> list=data['data'].toList();
    setState(() {
      for(int i=0;i<list.length;i++){
        _typesList.add(SortCondition(name: list[i]['name'].toString(),devType: list[i]['id'].toString(), isSelected: false));
      }
    });







  }
  Future<WaterSectionModel> waterRealTimedPost() async{
    // final prefs = await SharedPreferences.getInstance();
    // final busiParkId = prefs.getString('busiParkId')?? "0";
    // final authorization = prefs.getString('authorization') ?? "0";
    //
    // var url = Uri.parse('${HttpUtil.url}/api/appWater/fractureListData');
    // var result=await http.post(url,headers: {'busiParkId':busiParkId,'authorization':authorization,"Content-Type":"application/json"},
    //     body: jsonEncode({'riverId':riverId,'fraIds':fraIds}));
    // Utf8Decoder utf8decoder = const Utf8Decoder();
    String jsontext='{"msg":"success","code":200,"data":[{"pollutionIndexName":"总磷","alarmCount":102,"fraId":49,"riverId":3,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"天津市_海河流域","fraName":"黄白桥"},{"pollutionIndexName":"总磷","alarmCount":102,"fraId":24,"riverId":3,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"天津市_海河流域","fraName":"三岔口"},{"pollutionIndexName":"总磷","alarmCount":100,"fraId":23,"riverId":3,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"天津市_海河流域","fraName":"万家码头"},{"pollutionIndexName":"氨氮","alarmCount":96,"fraId":4,"riverId":1,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"北京市_海河流域","fraName":"后城"},{"pollutionIndexName":"高锰酸盐指数","alarmCount":95,"fraId":21,"riverId":1,"updateTime":"2021-12-28 17:00:00","waterType":5,"riverName":"北京市_海河流域","fraName":"鼓楼外大街"},{"pollutionIndexName":"氨氮","alarmCount":94,"fraId":25,"riverId":3,"updateTime":"2021-12-28 17:00:00","waterType":5,"riverName":"天津市_海河流域","fraName":"于桥水库出口"},{"pollutionIndexName":"总磷","alarmCount":93,"fraId":2,"riverId":1,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"北京市_海河流域","fraName":"南大荒桥"},{"pollutionIndexName":"溶解氧","alarmCount":93,"fraId":32,"riverId":3,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"天津市_海河流域","fraName":"塘汉公路桥"},{"pollutionIndexName":"溶解氧","alarmCount":92,"fraId":22,"riverId":2,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"北京市_淮河流域","fraName":"八间房漫水桥"},{"pollutionIndexName":"溶解氧","alarmCount":92,"fraId":56,"riverId":4,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"河北省_海河流域","fraName":"上二道河子"},{"pollutionIndexName":"溶解氧","alarmCount":91,"fraId":51,"riverId":3,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"天津市_海河流域","fraName":"齐家务"},{"pollutionIndexName":"总磷","alarmCount":91,"fraId":54,"riverId":4,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"河北省_海河流域","fraName":"三河东大桥"},{"pollutionIndexName":"氨氮","alarmCount":89,"fraId":33,"riverId":3,"updateTime":"2021-12-28 17:00:00","waterType":5,"riverName":"天津市_海河流域","fraName":"大套桥"},{"pollutionIndexName":"氨氮","alarmCount":89,"fraId":20,"riverId":1,"updateTime":"2021-12-28 17:00:00","waterType":5,"riverName":"北京市_海河流域","fraName":"辛庄桥"},{"pollutionIndexName":"高锰酸盐指数","alarmCount":88,"fraId":52,"riverId":4,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"河北省_海河流域","fraName":"26#大桥"},{"pollutionIndexName":"溶解氧","alarmCount":88,"fraId":55,"riverId":4,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"河北省_海河流域","fraName":"三河东大桥(老)"},{"pollutionIndexName":"溶解氧","alarmCount":87,"fraId":1,"riverId":1,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"北京市_海河流域","fraName":"东店"},{"pollutionIndexName":"高锰酸盐指数","alarmCount":87,"fraId":53,"riverId":4,"updateTime":"2021-12-28 17:00:00","waterType":5,"riverName":"河北省_海河流域","fraName":"三小营"},{"pollutionIndexName":"总磷","alarmCount":86,"fraId":50,"riverId":3,"updateTime":"2021-12-28 17:00:00","waterType":5,"riverName":"天津市_海河流域","fraName":"黎河桥"},{"pollutionIndexName":"总氮","alarmCount":84,"fraId":3,"riverId":1,"updateTime":"2021-12-28 17:00:00","waterType":6,"riverName":"北京市_海河流域","fraName":"古北口"}]}';
    watermodel=WaterSectionModel.fromJson(json.decode(jsontext));
    // watermodel=WaterSectionModel.fromJson(json.decode(utf8decoder.convert(result.bodyBytes)));
    watermodelList=watermodel.data;
    return watermodel;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromRGBO(6, 36, 66, 1),
          title: Text('断面数据',style: TextStyle(
            color: Color.fromRGBO(185, 233, 255, 1),
            fontSize: Adapt.px(32),)),
          centerTitle:true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
            Navigator.pop(context);
          }),
          actions: [
            IconButton(icon: const Icon(Icons.search),color: const Color.fromRGBO(185, 233, 255, 1), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> WaterChaXunPage()));
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
                              typecheckitem??"全部河流",
                              style: TextStyle(color: Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28)),
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
                      Expanded(child: FutureBuilder(future: waterRealTimedPost(),
                          builder: (BuildContext context, AsyncSnapshot<WaterSectionModel> snapshot){
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
                                  if(watermodelList.isEmpty){
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
                                        itemCount: watermodelList.length,//个数
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
                                          return getWaterListViewItem(watermodelList[index], context);
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
                              riverId=value.devType;});
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
Widget getWaterListViewItem(WaterData waterdata,BuildContext context) {
  if(waterdata.waterType=='6'){
    waterdata.waterType='劣V类';
  }else if(waterdata.waterType=='5'){
    waterdata.waterType='V类';
  }else if(waterdata.waterType=='4'){
    waterdata.waterType='IV类';
  }else if(waterdata.waterType=='3'){
    waterdata.waterType='III类';
  }else if(waterdata.waterType=='2'){
    waterdata.waterType='II类';
  }else if(waterdata.waterType=='1'){
    waterdata.waterType='I类';
  }
    return InkWell(
      onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=> WaterSectionDetails(waterdata.fraId.toString())));
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
                Image(
                  image: const AssetImage('images/section.png'), width: Adapt.px(56), height: Adapt.px(56),),
                SizedBox(width:Adapt.px(25)),
                Text(waterdata.fraName??'-'.toString(), style: TextStyle(
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
                  width: Adapt.px(191),
                  height: Adapt.px(104),
                  decoration:  BoxDecoration(
                      color: Color.fromRGBO(185, 233, 255, 0.05),
                      borderRadius: BorderRadius.all(Radius.circular(Adapt.px(8)))
                  ),
                  child: Column(
                    children: [
                      SizedBox(height:Adapt.px(8)),
                      Container(
                        alignment: Alignment.center,
                        height: Adapt.px(48),
                        child: Text(waterdata.waterType??'-'.toString(), style: TextStyle(
                            color:  Color.fromRGBO(255, 255, 255, 1),
                            fontSize: Adapt.px(32)),
                        ),

                      ),

                      SizedBox(height:Adapt.px(4)),
                      Container(
                        alignment: Alignment.center,
                        height: Adapt.px(36),
                        child:Text('水质类别', style: TextStyle(
                            color:  Color.fromRGBO(185, 233, 255, 1),
                            fontSize: Adapt.px(24)),),

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
                      Container(
                        alignment: Alignment.center,
                        height: Adapt.px(48),
                        child: Text(waterdata.pollutionIndexName??'-'.toString(), style: TextStyle(
                            color:  Color.fromRGBO(255, 255, 255, 1),
                            fontSize: Adapt.px(32)),
                        ),

                      ),

                      SizedBox(height:Adapt.px(4)),
                      Text('主要污染指标', style: TextStyle(
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
                      Container(
                        alignment: Alignment.center,
                        height: Adapt.px(48),
                        child: Text(waterdata.alarmCount??'-'.toString(), style: TextStyle(
                            color:  Color.fromRGBO(255, 255, 255, 1),
                            fontSize: Adapt.px(32)),),
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
                Text('所属河流：', style: TextStyle(
                    color:  Color.fromRGBO(185, 233, 255, 1),
                    fontSize: Adapt.px(24)),
                ),
                Text(waterdata.riverName??'-'.toString(), style: TextStyle(
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
                Text(waterdata.updateTime??'-'.toString(), style: TextStyle(
                    color:  Color.fromRGBO(255, 255, 255, 1),
                    fontSize: Adapt.px(24)),
                ),

              ],
            ),
          ],
        ),
      ) ,
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
  return Container(color: const Color.fromRGBO(6, 36, 66, 1),child: ListView.separated(
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