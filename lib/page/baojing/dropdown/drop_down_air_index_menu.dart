
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/baojing/air_index_model.dart';
import 'package:flutter_huiyuantong/model/baojing/air_site_type_model.dart';
import 'package:flutter_huiyuantong/model/baojing/water_index.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/easy_popup_child.dart';
class DropDownAirIndexMenu extends StatefulWidget with EasyPopupChild{
  final _PopController controller = _PopController();

   List<SiteTypeData> siteTypelist;
//全部
   List<AirIndexData> alliindexList;
   List<bool> allchecks;
//国标

   List<AirIndexData> gbIndexList;
   List<bool> gbichecks;
//网格

   List<AirIndexData> wgIndexList;
   List<bool> wgichecks;
//有毒

   List<AirIndexData> ydIndexList;
   List<bool> ydichecks;
//恶臭

   List<AirIndexData> ecIndexList;
   List<bool> ecichecks;

  DropDownAirIndexMenu(this.siteTypelist,this.alliindexList,this.allchecks,this.gbIndexList,this.gbichecks,this.wgIndexList,this.wgichecks,this.ydIndexList,this.ydichecks,this.ecIndexList,this.ecichecks,{Key? key}) : super(key: key);
  @override
  _DropDownAirIndexMenuState createState() => _DropDownAirIndexMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownAirIndexMenuState extends State<DropDownAirIndexMenu>
    with SingleTickerProviderStateMixin {
   String biaoshi='quan';
  late List<AirIndexData> xuanranList;
   List<bool> xuanrancheckList=[];
  TextStyle textStyle2 = TextStyle(
    color: const Color.fromRGBO(185, 233, 255, 1),
    fontSize: Adapt.px(28),);
  TextStyle textStyle1 = TextStyle(
    color: const Color.fromRGBO(46, 228, 149, 1),
    decoration: TextDecoration.underline,
    decorationColor: const Color.fromRGBO(46, 228, 149, 1),
    fontSize: Adapt.px(28),);
  TextStyle textStyle12 = TextStyle(
    color: const Color.fromRGBO(185, 233, 255, 1),
    fontSize: Adapt.px(28),);
  TextStyle textStyle11 = TextStyle(
    color: const Color.fromRGBO(46, 228, 149, 1),
    decorationColor: const Color.fromRGBO(46, 228, 149, 1),
    fontSize: Adapt.px(28),);
  BoxDecoration boxDecoration1 = BoxDecoration(

    color: const Color.fromRGBO(46, 228, 149, 1),
    borderRadius: BorderRadius.circular(Adapt.px(32)),

  );
  BoxDecoration boxDecoration2 =BoxDecoration(
    border: Border.all(width: Adapt.px(1),color: const Color.fromRGBO(185, 233, 255, 1)),
    borderRadius: BorderRadius.circular(Adapt.px(32)),
  );
  List<bool>typechecks=[];
  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    xuanranList=widget.alliindexList;
    xuanrancheckList=widget.allchecks;
    for(int i=0;i<widget.siteTypelist.length;i++){
      typechecks.add(false);
    }
    typechecks[0]=true;
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
                SizedBox(height: MediaQuery.of(context).padding.top +Adapt.px(192)),
                Container(
                  color:  Color.fromRGBO(6, 36, 66, 1),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*1056/1642,
                  child:  Row(
                    children: [
                      Container(
                        color:  Color.fromRGBO(185, 233, 255, 0.05),
                        width: Adapt.px(240),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                setState(() {
                                  for(int i=0;i<widget.siteTypelist.length;i++){
                                    typechecks[i]=false;
                                  }
                                  typechecks[index]=!typechecks[index];
                                });
                                if(index==0){
                                  xuanranList=widget.alliindexList;
                                  xuanrancheckList=widget.allchecks;
                                  biaoshi='quan';
                                }else if(index==1){
                                  xuanranList=widget.gbIndexList;
                                  xuanrancheckList=widget.gbichecks;
                                  biaoshi='gb';
                                }else if(index==2){
                                  xuanranList=widget.wgIndexList;
                                  xuanrancheckList=widget.wgichecks;
                                  biaoshi='wg';
                                }else if(index==3){
                                  xuanranList=widget.ydIndexList;
                                  xuanrancheckList=widget.ydichecks;
                                  biaoshi='yd';
                                }else if(index==4){
                                  xuanranList=widget.ecIndexList;
                                  xuanrancheckList=widget.ecichecks;
                                  biaoshi='ec';
                                }


                              },
                              child: Container(
                                height: Adapt.px(88),
                                width: Adapt.px(240),
                                decoration: const BoxDecoration(

                                ),
                                alignment: Alignment.center,
                                child:
                                Text(widget.siteTypelist[index].name.toString(),
                                  style: typechecks[index] ? textStyle1 : textStyle2,
                                ),
                              ),
                            );
                          }, itemCount: widget.siteTypelist.length,

                        ),
                      ),
                      Container(
                        color:  Color.fromRGBO(6, 36, 66, 1),
                        width: Adapt.px(510),
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 0),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              //behavior: HitTestBehavior.opaque,属性，可以让点击事件透过这个Text的区域。
                              // 如果不添加这个属性，那么只能点击到文字时才会有响应,虽然这里用不到这个属性，因为GestureDetector包裹了整个Container
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if(biaoshi=='quan'){
                                  widget.allchecks[index]=!widget.allchecks[index];
                                  for(int i=0;i<widget.gbichecks.length;i++){
                                    widget.gbichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.wgichecks.length;i++){
                                    widget.wgichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.ydichecks.length;i++){
                                    widget.ydichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.ecichecks.length;i++){
                                    widget.ecichecks[i]=false;
                                  }
                                }else if(biaoshi=='gb'){
                                  widget.gbichecks[index]=!widget.gbichecks[index];
                                  widget.allchecks[0]=false;
                                  for(int i=0;i<widget.wgichecks.length;i++){
                                    widget.wgichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.ydichecks.length;i++){
                                    widget.ydichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.ecichecks.length;i++){
                                    widget.ecichecks[i]=false;
                                  }

                                }else if(biaoshi=='wg'){
                                  widget.wgichecks[index]=!widget.wgichecks[index];
                                  widget.allchecks[0]=false;
                                  for(int i=0;i<widget.gbichecks.length;i++){
                                    widget.gbichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.ydichecks.length;i++){
                                    widget.ydichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.ecichecks.length;i++){
                                    widget.ecichecks[i]=false;
                                  }

                                }else if(biaoshi=='yd'){
                                  widget.ydichecks[index]=!widget.ydichecks[index];
                                  widget.allchecks[0]=false;
                                  for(int i=0;i<widget.wgichecks.length;i++){
                                    widget.wgichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.gbichecks.length;i++){
                                    widget.gbichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.ecichecks.length;i++){
                                    widget.ecichecks[i]=false;
                                  }

                                }else if(biaoshi=='ec'){
                                  widget.ecichecks[index]=!widget.ecichecks[index];
                                  widget.allchecks[0]=false;
                                  for(int i=0;i<widget.wgichecks.length;i++){
                                    widget.wgichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.ydichecks.length;i++){
                                    widget.ydichecks[i]=false;
                                  }
                                  for(int i=0;i<widget.gbichecks.length;i++){
                                    widget.gbichecks[i]=false;
                                  }

                                }
                                dismiss();
                                Navigator.pop(context,xuanranList[index]);
                              },
                              child: Container(
                                height: Adapt.px(72),
                                width: Adapt.px(510),
                                padding: EdgeInsets.only(left: Adapt.px(40)),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(
                                      color: Color.fromRGBO(6, 36, 66, 1), width: 0.0)),
                                  color:  Color.fromRGBO(6, 36, 66, 1),
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  xuanranList[index].name.toString(),
                                  style: xuanrancheckList[index]? textStyle11:textStyle12,
                                ),
                              ),
                            );
                          }, itemCount: xuanranList.length,

                        ),
                      ),

                    ],
                  ),
                  ),

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

class _PopController {
  late _DropDownAirIndexMenuState state;

  _bindState(_DropDownAirIndexMenuState state) {
    this.state = state;
  }

  dismiss() {
    state?.dismiss();
  }
}
