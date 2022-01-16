
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/airsite_details_model.dart';
import 'package:flutter_huiyuantong/model/baojing/water_index.dart';
import 'package:flutter_huiyuantong/page/air_site_details.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/easy_popup_child.dart';
import 'package:fluttertoast/fluttertoast.dart';
class DropDownMapAir extends StatefulWidget with EasyPopupChild{
  final _PopController controller = _PopController();
  AirSiteDetailsModel airsitedetailsmodel;
   List<RealtimeData> RealtimeDataList ;
  String sn ;
  DropDownMapAir(this.sn,this.airsitedetailsmodel,this.RealtimeDataList,{Key? key}) : super(key: key);
  @override
  _DropDownMapAirState createState() => _DropDownMapAirState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownMapAirState extends State<DropDownMapAir>
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
                        Text(widget.airsitedetailsmodel.data!.deviceData!.name.toString(),style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(32)),),
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
                        Text('所属地区：${widget.airsitedetailsmodel.data!.deviceData!.regionName.toString()}',
                          style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 0.75),fontSize: Adapt.px(24)),),
                        SizedBox(width: Adapt.px(64),),
                        Text('更新时间：${widget.airsitedetailsmodel.data!.deviceData!.updateTime.toString()}',
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
                          child:GridView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(Adapt.px(32), Adapt.px(0), Adapt.px(32), Adapt.px(0)),
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
                              return getGridViewItem(widget.RealtimeDataList[index]);
                            },
                            itemCount: widget.RealtimeDataList.length,),)
                      ),
                      SizedBox(height: Adapt.px(32),),
                      InkWell(
                        onTap: (){
                          dismiss();
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> AirSiteDetails(widget.sn)));
                        },
                        child:   Text('查看站点详情 >',style: TextStyle(color: const Color.fromRGBO(46, 228, 149, 1),fontSize: Adapt.px(24)),),
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
class _PopController {
  late _DropDownMapAirState state;

  _bindState(_DropDownMapAirState state) {
    this.state = state;
  }

  dismiss() {
    state?.dismiss();
  }
}
