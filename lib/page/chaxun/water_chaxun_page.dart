import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';

import 'package:flutter_huiyuantong/model/water_section_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../air_site_details.dart';
import '../water_section_details_page.dart';

class WaterChaXunPage extends StatefulWidget{
  const WaterChaXunPage({Key? key}) : super(key: key);
  @override
  _WaterChaXunPageState createState()=>_WaterChaXunPageState();
}
class _WaterChaXunPageState extends State<WaterChaXunPage>{

  var watermodel;
  final TextEditingController _unameController = TextEditingController();
  late List<WaterData> AirSiteList ;
  List<WaterData> sousuoSiteList=[] ;
  List<String>  lishiList=[];
  String  riverId='-1';
  String  ?fraIds;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMethod();
  }
  void myMethod() async{
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getStringList('lishiList')!=null) {
      lishiList = prefs.getStringList('lishiList')!;
    }

  }
  void myMethod2(List<String> lishiList) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('lishiList', lishiList);

  }
  void myMethodremove() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('lishiList');

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
    AirSiteList=watermodel.data;
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
              Row(children: [
                SizedBox(
                  width: Adapt.px(542),
                  height: Adapt.px(70),
                  child: TextField(
                    controller: _unameController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration:  InputDecoration(
                      border: InputBorder.none,
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        borderSide:const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0),
                          width: 1.0,
                        ),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22.0),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 0),
                          width: 1.0,
                        ),
                      ),
                      fillColor: const Color.fromRGBO(185, 233, 255, 0.05),//背景色
                      filled: true,//重点，必须设置为true，fillColor才有效
                      isCollapsed: true,//重点，相当于高度包裹的意思，必须设置为true，不然有默认奇妙的最小高度
                      contentPadding: const EdgeInsets.all(12),//内容内边距，影响高度
                      hintText: '搜索断面名称',


                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(185, 233, 255, 1),
                        fontSize: 12,
                      ),

                    ),
                  ),
                ),
                SizedBox(width: Adapt.px(24),),
                InkWell(child: Container(
                  width: Adapt.px(120),
                  height: Adapt.px(70),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(46, 228, 149, 1),
                    borderRadius: BorderRadius.circular(Adapt.px(35)),
                  ),
                  alignment: Alignment.center,
                  child:  Text('搜索',style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(28)),),
                ),onTap: (){
                  setState(() {
                    if(_unameController.text!=''){if(lishiList.length<10){lishiList.add(_unameController.text);}
                    else{lishiList.add(_unameController.text);lishiList.removeAt(0);}
                    myMethod2(lishiList);
                    print(lishiList.length);}

                  });
                }
                )
              ],),
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
                          if(_unameController.text==''||_unameController.text==null){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: Adapt.px(32),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('历史搜索',
                                      style:  TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(32)),
                                    ),
                                    InkWell(child: Image(image: const AssetImage('images/laji.png'),width: Adapt.px(28),height: Adapt.px(28),),onTap: (){
                                      setState(() {
                                        myMethodremove();
                                        lishiList.clear();
                                      });
                                    },),
                                  ],),
                                Wrap(
                                  spacing:Adapt.px(16),
                                  runAlignment : WrapAlignment.start,
                                  crossAxisAlignment: WrapCrossAlignment.start,//run的对齐方式。run可以理解为新的行或者列，如果是水平方向布局的话，run可以理解为新的一行。
                                  runSpacing : Adapt.px(24),//run的间距。
                                  children: wateritems(lishiList),
                                ),



                              ],);

                          }else{if(AirSiteList.isEmpty){
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
                            sousuoSiteList.clear();
                            for(int i=0;i<AirSiteList.length;i++){
                              if(AirSiteList[i].fraName!.contains(_unameController.text)){
                                sousuoSiteList.add(AirSiteList[i]);
                              }
                            }
                            if(sousuoSiteList.isEmpty){
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
                                  itemCount: sousuoSiteList.length,//个数
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
                                    return getWaterListViewItem(sousuoSiteList[index], context);
                                  });}
                          }}


                        }
                    }
                  }
              ),),


              //列表页

            ],
          ),

        )
    );
  }
  List<Widget> wateritems(List<String> lishiList){
    List<Widget> lis=[];
    for(int i=0;i<lishiList.length;i++){
      lis.add(InkWell(child: Container(

        padding: const EdgeInsets.all(5),

        decoration: BoxDecoration(
          borderRadius:  BorderRadius.circular(Adapt.px(28)),
          color: const Color.fromRGBO(185, 233, 255, 0.05),
        ),

        child:  Text(lishiList[i],style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),

      ),onTap: (){
        setState(() {
          _unameController.text=lishiList[i];
        });
      }));

    }
    return lis;
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

