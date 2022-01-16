import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/page/home_all_page.dart';
import 'package:flutter_huiyuantong/page/home_daqi_page.dart';
import 'package:flutter_huiyuantong/page/home_pollution_page.dart';

import 'home_water_page.dart';
class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState()=>_HomePageState();

}
class _HomePageState extends State<HomePage>with SingleTickerProviderStateMixin{
  late TabController _controller1;
  final List<Tab> _tabs=[
    Tab(text: "总体概况",),
    Tab(text: "大气",),
    Tab(text: "水质",),
    Tab(text: "污染源",),
  ];
  @override
  void initState(){
    _controller1=TabController(length: 4, vsync: this);
    super.initState();
  }
  final PageController _pageController=PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(6, 36, 66, 1),
        automaticallyImplyLeading: false,//去掉返回按钮
        title: Row(
          children: const <Widget>[
           Image(image: AssetImage('images/location_yuanqu.png'),width: 16,height: 16,),
           SizedBox(width: 4),//设置间隔为4，用SizedBox填充中间间距
           Text('HCR工业园区',style: TextStyle(
             color: Color.fromRGBO(185, 233, 255, 1),
             fontSize: 16,)),
           ],),
        centerTitle:false,
        // leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
        //   Navigator.pop(context);//自定义返回按钮
        // }),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color.fromRGBO(6, 36, 66, 1),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 16.5),
            child: TabBar(
              padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
              controller: _controller1,
              isScrollable: true,
              labelStyle: TextStyle(fontSize: 14,color: Color.fromRGBO(255, 255, 255, 1),),
              unselectedLabelStyle: TextStyle(fontSize: 14,color: Color.fromRGBO(185, 233, 255, 1),),
              indicatorWeight: 0,
              indicator: BoxDecoration(

                borderRadius: BorderRadius.circular(28),
                color:  Color.fromRGBO(46, 228, 149, 1),
              ),
              tabs: _tabs,
            ),
          ),
          Flexible(child: TabBarView(
            controller: _controller1,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              HomeAllPage(),
              HomeDaQiPage(),
              HomeWaterPage(),
              HomePollutionPage(),
            ],))

        ],
      ),


    );
  }


}