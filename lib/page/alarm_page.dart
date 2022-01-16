import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';

import 'baojing/baojing_all_page.dart';
import 'baojing/baojing_daqi_page.dart';
import 'baojing/baojing_pollution_page.dart';
import 'baojing/baojing_water_page.dart';
import 'dart:ui';

class AlarmPage extends StatefulWidget{
  const AlarmPage({Key? key}) : super(key: key);



  @override
  _AlarmPageState createState()=>_AlarmPageState();
}
class _AlarmPageState extends State<AlarmPage>with SingleTickerProviderStateMixin{

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
      appBar: PreferredSize(
          child:  Container(
            height: MediaQueryData.fromWindow(window).padding.top,
            color: const Color.fromRGBO(6, 36, 66, 1),
          ),
          preferredSize: Size.fromHeight(MediaQueryData.fromWindow(window).padding.top)),

      body: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color:  Color.fromRGBO(6, 36, 66, 1),
              border: Border(bottom: BorderSide(
                  color: Color.fromRGBO(6, 36, 66, 1), width: 0)),
            ),

            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: Adapt.px(33)),
            child: TabBar(
              //padding: EdgeInsets.fromLTRB(Adapt.px(0), Adapt.px(14), Adapt.px(0), Adapt.px(14)),
              controller: _controller1,
              isScrollable: true,
              labelStyle: TextStyle(fontSize: Adapt.px(30),color: Color.fromRGBO(255, 255, 255, 1),),
              unselectedLabelStyle: TextStyle(fontSize: Adapt.px(30),color: Color.fromRGBO(185, 233, 255, 1),),
              indicatorWeight: Adapt.px(0),
              indicator: BoxDecoration(

                borderRadius: BorderRadius.circular(Adapt.px(56)),
                color:  Color.fromRGBO(46, 228, 149, 1),
              ),
              tabs: _tabs,
            ),
          ),
          Flexible(child: TabBarView(
            controller: _controller1,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              BaojingAllPage(),
              BaojingDaQiPage(),
              BaojingWaterPage(),
              BaojingPollutionPage(),
            ],))

        ],
      ),
    );
  }

}