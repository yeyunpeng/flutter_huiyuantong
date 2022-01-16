import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/page/pollution_outlet_page.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
class HomePollutionPage extends StatefulWidget{
  @override
  _HomePollutionPageState createState()=>_HomePollutionPageState();
}
class _HomePollutionPageState extends State<HomePollutionPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width, // 屏幕宽度
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Color.fromRGBO(6, 36, 66, 1),Color.fromRGBO(16, 56, 95, 1),Color.fromRGBO(1, 20, 43, 1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0,0.5,1],
                )
            ),
            child: Container(
              width: Adapt.px(686),
              padding: EdgeInsets.only(left: Adapt.px(32),right: Adapt.px(32),top: Adapt.px(40)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('数据监测',
                    style: TextStyle(
                        color:  Color.fromRGBO(185, 233, 255, 1),
                        fontSize: Adapt.px(24)),),
                  SizedBox(height: Adapt.px(24),),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>PollutionOutlet()));},
                        child: Container(
                          width: Adapt.px(327),
                          height: Adapt.px(144),
                          decoration:  BoxDecoration(
                            gradient: LinearGradient(
                              colors: [ Color.fromRGBO(46, 228, 149, 1),Color.fromRGBO(91, 243, 199, 1)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              stops: [0,1],
                            ),
                            borderRadius: BorderRadius.circular(Adapt.px(24)),),

                          child: Container(
                            padding: EdgeInsets.only(left:Adapt.px(24), right: Adapt.px(24)),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(height: Adapt.px(34),),
                                    Container(
                                      width: Adapt.px(78),
                                      height: Adapt.px(78),
                                      decoration:  BoxDecoration(
                                          borderRadius: BorderRadius.circular(Adapt.px(24)),
                                          color: const Color.fromRGBO(90, 244, 198, 0.2),
                                          boxShadow: [ BoxShadow(
                                              offset: Offset(0, Adapt.px(13)),
                                              color: const Color.fromRGBO(0, 0, 0, 0.1),
                                              spreadRadius: 0,
                                              blurRadius: 10),]
                                      ),
                                      child: Image(image: AssetImage('images/paikou.png')),
                                    ),
                                  ],)
                                ,
                                SizedBox(width: Adapt.px(24),),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Adapt.px(24),),
                                      Container(
                                        height: Adapt.px(48),
                                        child: Text('排口数据',
                                          style: TextStyle(
                                              color:  Color.fromRGBO(255, 255, 255, 1),
                                              fontSize: Adapt.px(32)),),),
                                      SizedBox(height: Adapt.px(12),),



                                    ],),)
                                ,



                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: Adapt.px(32),),
                      Container(
                        width: Adapt.px(327),
                        height: Adapt.px(144),
                        decoration:  BoxDecoration(
                          color: Color.fromRGBO(185, 233, 255, 0.05),
                          borderRadius: BorderRadius.circular(Adapt.px(24)),),

                        child: Container(
                          padding: EdgeInsets.only(left:Adapt.px(24), right: Adapt.px(24)),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: Adapt.px(34),),
                                  Stack(
                                    alignment:Alignment.center,
                                    children: [
                                      Container(
                                        width: Adapt.px(78),
                                        height: Adapt.px(78),
                                        decoration:  BoxDecoration(
                                            borderRadius: BorderRadius.circular(Adapt.px(24)),
                                            color: const Color.fromRGBO(90, 244, 198, 0.2),
                                            boxShadow: [ BoxShadow(
                                                offset: Offset(0, Adapt.px(13)),
                                                color: const Color.fromRGBO(0, 0, 0, 0.1),
                                                spreadRadius: 0,
                                                blurRadius: 10),]
                                        ),
                                      ),
                                      Image(image: AssetImage('images/qiye.png'),width: Adapt.px(48),height: Adapt.px(48),),
                                    ],
                                  )

                                ],)
                              ,
                              SizedBox(width: Adapt.px(24),),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Adapt.px(24),),
                                    Container(
                                      height: Adapt.px(48),
                                      child: Text('企业数据',
                                        style: TextStyle(
                                            color:  Color.fromRGBO(185, 233, 255, 1),
                                            fontSize: Adapt.px(32)),),),
                                    SizedBox(height: Adapt.px(12),),
                                    Container(
                                      height: Adapt.px(36),
                                      child: Text('开发中…',
                                        style: TextStyle(
                                            color:  Color.fromRGBO(185, 233, 255, 1),
                                            fontSize: Adapt.px(24)),),),


                                  ],),)
                              ,



                            ],
                          ),
                        ),
                      ),

                    ],),
                  SizedBox(height: Adapt.px(40),),
                  Text('数据分析',
                    style: TextStyle(
                        color:  Color.fromRGBO(185, 233, 255, 1),
                        fontSize: Adapt.px(24)),),
                  SizedBox(height: Adapt.px(24),),
                  Container(
                    width: Adapt.px(686),
                    height: Adapt.px(144),
                    decoration:  BoxDecoration(
                      color: Color.fromRGBO(185, 233, 255, 0.05),
                      borderRadius: BorderRadius.circular(Adapt.px(24)),),

                    child: Container(
                      padding: EdgeInsets.only(left:Adapt.px(24), right: Adapt.px(24)),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: Adapt.px(34),),
                              Stack(
                                alignment:Alignment.center,
                                children: [
                                  Container(
                                    width: Adapt.px(78),
                                    height: Adapt.px(78),
                                    decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(Adapt.px(24)),
                                        color: const Color.fromRGBO(90, 244, 198, 0.2),
                                        boxShadow: [ BoxShadow(
                                            offset: Offset(0, Adapt.px(13)),
                                            color: const Color.fromRGBO(0, 0, 0, 0.1),
                                            spreadRadius: 0,
                                            blurRadius: 10),]
                                    ),
                                  ),
                                  Image(image: AssetImage('images/fenxi.png'),width: Adapt.px(48),height: Adapt.px(48),),
                                ],
                              )

                            ],)
                          ,
                          SizedBox(width: Adapt.px(24),),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Adapt.px(24),),
                                Container(
                                  height: Adapt.px(48),
                                  child: Text('排放浓度分析',
                                    style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(32)),),),
                                SizedBox(height: Adapt.px(12),),
                                Container(
                                  height: Adapt.px(36),
                                  child: Text('开发中…',
                                    style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),),),


                              ],),)
                          ,



                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Adapt.px(40),),
                  Text('设置',
                    style: TextStyle(
                        color:  Color.fromRGBO(185, 233, 255, 1),
                        fontSize: Adapt.px(24)),),
                  SizedBox(height: Adapt.px(24),),
                  Container(
                    width: Adapt.px(686),
                    height: Adapt.px(144),
                    decoration:  BoxDecoration(
                      color: Color.fromRGBO(185, 233, 255, 0.05),
                      borderRadius: BorderRadius.circular(Adapt.px(24)),),

                    child: Container(
                      padding: EdgeInsets.only(left:Adapt.px(24), right: Adapt.px(24)),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: Adapt.px(34),),
                              Stack(
                                alignment:Alignment.center,
                                children: [
                                  Container(
                                    width: Adapt.px(78),
                                    height: Adapt.px(78),
                                    decoration:  BoxDecoration(
                                        borderRadius: BorderRadius.circular(Adapt.px(24)),
                                        color: const Color.fromRGBO(90, 244, 198, 0.2),
                                        boxShadow: [ BoxShadow(
                                            offset: Offset(0, Adapt.px(13)),
                                            color: const Color.fromRGBO(0, 0, 0, 0.1),
                                            spreadRadius: 0,
                                            blurRadius: 10),]
                                    ),
                                  ),
                                  Image(image: AssetImage('images/shezhi.png'),width: Adapt.px(48),height: Adapt.px(48),),
                                ],
                              )

                            ],),
                          SizedBox(width: Adapt.px(24),),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Adapt.px(24),),
                                Container(
                                  height: Adapt.px(48),
                                  child: Text('报警设置',
                                    style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(32)),),),
                                SizedBox(height: Adapt.px(12),),
                                Container(
                                  height: Adapt.px(36),
                                  child: Text('开发中…',
                                    style: TextStyle(
                                        color:  Color.fromRGBO(185, 233, 255, 1),
                                        fontSize: Adapt.px(24)),),),


                              ],),)
                          ,



                        ],
                      ),
                    ),
                  ),

                ],
              ),
            )

        )
    );
  }

}