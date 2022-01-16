
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_details_model.dart';

import 'package:flutter_huiyuantong/model/water_section_details_model.dart';

import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/easy_popup_child.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../water_para_history.dart';
import '../../water_section_details_page.dart';
class DropDownMapWater extends StatefulWidget with EasyPopupChild{
  final _PopController controller = _PopController();
  WaterDetailsModel airsitedetailsmodel;
  List<WaterRealtimeData> RealtimeDataList ;
  String id ;
  DropDownMapWater(this.id,this.airsitedetailsmodel,this.RealtimeDataList,{Key? key}) : super(key: key);
  @override
  _DropDownMapWaterState createState() => _DropDownMapWaterState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownMapWaterState extends State<DropDownMapWater>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    widget.controller._bindState(this);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<Offset>(begin: Offset.zero, end: Offset.zero)
        .animate(_controller);
    _controller.forward();
  }

  dismiss() {
    _controller?.reverse();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body:SlideTransition(
        position: _animation,
        child: GestureDetector(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child:  Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height-Adapt.px(686)),
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    color:  const Color.fromRGBO(6, 36, 66, 1),
                    height: Adapt.px(686),
                    child:  Column(children: [
                      SizedBox(height: Adapt.px(32),),
                      Row(children: [
                        SizedBox(width: Adapt.px(32),),
                        Text(widget.airsitedetailsmodel.data!.fraName.toString(),style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(32)),),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: (){
                            dismiss();
                            Navigator.pop(context);
                          },
                          child:  Icon(Icons.clear,color: const Color.fromRGBO(185, 233, 255, 1),size: Adapt.px(32),),
                        ),
                        SizedBox(width: Adapt.px(32),),
                      ],),
                      SizedBox(height: Adapt.px(16),),
                      Row(children: [
                        SizedBox(width: Adapt.px(32),),
                        SizedBox(width: Adapt.px(256),child:   Text('所属河流：${widget.airsitedetailsmodel.data!.riverName.toString()}',
                          style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 0.75),fontSize: Adapt.px(24)),overflow: TextOverflow.ellipsis,),),

                        SizedBox(width: Adapt.px(64),),
                        Text('更新时间：${widget.airsitedetailsmodel.data!.updateTime.toString()}',
                          style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 0.75),fontSize: Adapt.px(24)),),
                      ],),
                      SizedBox(height: Adapt.px(32),),
                      //实时参数信息
                      Container(
                          width: Adapt.px(686),
                          height:  Adapt.px(403),
                          // height: Adapt.px((widget.RealtimeDataList.length/2+1)*100),
                          decoration:  BoxDecoration(
                              color: const Color.fromRGBO(185, 233, 255, 0.05),
                              borderRadius: BorderRadius.all(Radius.circular(Adapt.px(24)))
                          ),
                          child: SizedBox(
                            width:  Adapt.px(624),
                            child:ListView.builder(
                                padding: const EdgeInsets.only(top: 0),
                                itemCount: widget.RealtimeDataList.length,//个数
                                //itemExtent: Adapt.px(85),//行高
                                // scrollDirection: Axis.vertical,//滑动方向
                                primary: false,//false，如果内容不足，则用户无法滚动 而如果[primary]为true，它们总是可以尝试滚动。
                                //内容适配
                                shrinkWrap: true,


                                itemBuilder:(BuildContext context,int index){
                                  return getRealtimeDataListListViewItem(widget.RealtimeDataList[index]);
                                }),)
                      ),
                      SizedBox(height: Adapt.px(32),),
                      InkWell(
                        onTap: (){
                          dismiss();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> WaterSectionDetails(widget.id)));
                        },
                        child:   Text('查看断面详情 >',style: TextStyle(color: const Color.fromRGBO(46, 228, 149, 1),fontSize: Adapt.px(24)),),
                      ),
                    ],),
                  ),
                ),

                // ListView.builder(
                //   padding: const EdgeInsets.only(top: 0),
                //   itemBuilder: (BuildContext context, int index) {
                //     return GestureDetector(
                //       //behavior: HitTestBehavior.opaque,属性，可以让点击事件透过这个Text的区域。
                //       // 如果不添加这个属性，那么只能点击到文字时才会有响应,虽然这里用不到这个属性，因为GestureDetector包裹了整个Container
                //       behavior: HitTestBehavior.opaque,
                //       onTap: () {
                //         Navigator.pop(context,widget.waterIndexList[index]);
                //       },
                //       child: Container(
                //         height: Adapt.px(88),
                //         width: MediaQuery.of(context).size.height,
                //         decoration: const BoxDecoration(
                //           border: Border(bottom: BorderSide(
                //               color: Color.fromRGBO(6, 36, 66, 1), width: 0.0)),
                //           color:  Color.fromRGBO(6, 36, 66, 1),
                //         ),
                //         alignment: Alignment.center,
                //         child: Text(
                //           widget.waterIndexList[index].name.toString(),
                //           style: TextStyle(color:const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28) ),
                //         ),
                //       ),
                //     );
                //   }, itemCount: widget.waterIndexList.length,
                //
                // ),
              ],),

          ),
          onTap: (){
            dismiss();
            Navigator.pop(context,'out');
          },),

      ),

    );
  }
}
Widget getGridViewItem(RealtimeData realtimedata) {
  return Container(
      alignment: Alignment.center,
      width: Adapt.px(279),
      height: Adapt.px(100),
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
Widget getRealtimeDataListListViewItem(WaterRealtimeData waterrealtimedata) {
  if(waterrealtimedata.indexName=='waterType'){
    waterrealtimedata.indexName='水质类别';
  }else if(waterrealtimedata.indexName=='pollutionIndexName'){
    waterrealtimedata.indexName='主要污染指标';
    // waterrealtimedata.data= listToString(waterrealtimedata) ;
  }
  if(waterrealtimedata.data=='6'){
    waterrealtimedata.data='劣V类';
  }else if(waterrealtimedata.data=='5'){
    waterrealtimedata.data='V类';
  }else if(waterrealtimedata.data=='4'){
    waterrealtimedata.data='IV类';
  }else if(waterrealtimedata.data=='3'){
    waterrealtimedata.data='III类';
  }else if(waterrealtimedata.data=='2'){
    waterrealtimedata.data='II类';
  }else if(waterrealtimedata.data=='1'){
    waterrealtimedata.data='I类';
  }
  return Container(

    width: Adapt.px(686),

    child:Column(

      children: [
        SizedBox(height: Adapt.px(24), ),
        Container(

          width: Adapt.px(622),
          child:   IntrinsicHeight(
            child:  Row(
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
                      child: Text(waterrealtimedata.indexName??'-'.toString(),style:  TextStyle(
                          color:  Color.fromRGBO(185, 233, 255, 0.75),
                          fontSize: Adapt.px(24)),),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: Adapt.px(400),
                  child:  Text(
                    "${waterrealtimedata.data??'-'}${waterrealtimedata.unit??'-'.toString()}",

                    style:  TextStyle(
                        color:  Color.fromRGBO(255, 255, 255, 1),
                        fontSize: Adapt.px(24)),),
                ),

              ],
            ),),

        ),
        SizedBox(height: Adapt.px(24), ),
        Divider(indent: Adapt.px(32),endIndent: Adapt.px(32),height: Adapt.px(1),color: Color.fromRGBO(255, 255, 255, 0.1))
      ],
    ),


  ) ;
}
class _PopController {
  late _DropDownMapWaterState state;

  _bindState(_DropDownMapWaterState state) {
    this.state = state;
  }

  dismiss() {
    state?.dismiss();
  }
}
