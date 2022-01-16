import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_model.dart';
import 'package:flutter_huiyuantong/model/pollution_outlet_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/http_util.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../air_site_details.dart';
import '../pollution_outlet_details.dart';

class PollutionChaXunPage extends StatefulWidget{
  const PollutionChaXunPage({Key? key}) : super(key: key);
  @override
  _PollutionChaXunPageState createState()=>_PollutionChaXunPageState();
}
class _PollutionChaXunPageState extends State<PollutionChaXunPage>{

  var pollutionoutletmodel;
  final TextEditingController _unameController = TextEditingController();
  late List<OutletData> AirSiteList ;
  List<OutletData> sousuoSiteList=[] ;
  List<String>  lishiList=[];
  String  ? outIds;
  String  ? comId='-1';
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
    pollutionoutletmodel=PollutionOutletModel.fromJson(json.decode(jsonTxt1));
    AirSiteList=pollutionoutletmodel.data;
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
                      hintText: '搜索排口名称',


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
                              if(AirSiteList[i].outletName!.contains(_unameController.text)){
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
                                    return getPollutionListViewItem(sousuoSiteList[index], context);
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
                  color:  Color.fromRGBO(255, 255, 255, 1),
                  fontSize: Adapt.px(24)),
              ),
              SizedBox(width:Adapt.px(118)),
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

