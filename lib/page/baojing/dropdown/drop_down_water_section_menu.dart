
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/baojing/water_section_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/easy_popup_child.dart';
class DropDownWaterSectionMenu extends StatefulWidget with EasyPopupChild{
  final _PopController controller = _PopController();
  List<WaterSection> waterSectionList;
  List<bool> _isChecks=[];

  DropDownWaterSectionMenu(this.waterSectionList,this._isChecks,{Key? key}) : super(key: key);
  @override
  _DropDownWaterSectionMenuState createState() => _DropDownWaterSectionMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownWaterSectionMenuState extends State<DropDownWaterSectionMenu>
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
                SizedBox(height: MediaQuery.of(context).padding.top +Adapt.px(192)),
                Container(
                  decoration: const BoxDecoration(
                    color:  Color.fromRGBO(6, 36, 66, 1),
                    border: Border(bottom: BorderSide(
                        color: Color.fromRGBO(6, 36, 66, 1), width: 0)),
                  ),
                  height: MediaQuery.of(context).size.height*1056/1642-Adapt.px(108),
                  child:  ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        //behavior属性，可以让点击事件透过这个Text的区域。
                        behavior: HitTestBehavior.opaque,
                      onTap: () {
                        setState(() {
                          widget._isChecks[index]=!widget._isChecks[index];
                            if(index==0&&widget._isChecks[0]==true){
                              for(int i=0;i<widget.waterSectionList.length;i++){
                                widget._isChecks[i]=true;
                              }
                            }else if(index==0&&widget._isChecks[0]==false){
                              for(int i=0;i<widget.waterSectionList.length;i++){
                                widget._isChecks[i]=false;
                              }
                            }
                        });

      },
                        child: Container(
                        height: Adapt.px(88),
                        width: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: Color.fromRGBO(6, 36, 66, 1), width: 0.0)),
                          color:  Color.fromRGBO(6, 36, 66, 1),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(children: [
                          SizedBox(width: Adapt.px(40),),
                          Container(
                            alignment: Alignment.center,
                            width: Adapt.px(24),
                            height: Adapt.px(24),
                            child: Checkbox(
                              //materialTapTargetSize: Adapt.px(24),
                              fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                                const Set<MaterialState> interactiveStates = <MaterialState>{
                                  MaterialState.pressed,
                                  MaterialState.hovered,
                                  MaterialState.focused,
                                };
                                if (states.contains(MaterialState.disabled)) {
                                  return ThemeData.from(colorScheme: ColorScheme.light()).disabledColor;
                                }
                                if (states.contains(MaterialState.selected)) {
                                  return const Color.fromRGBO(46, 228, 149, 1);
                                }
                                if (states.any(interactiveStates.contains)) {
                                  return Colors.red;
                                }
                                // 最终返回
                                return const Color.fromRGBO(185, 233, 255, 1);
                              }),
                              //focusColor:const Color.fromRGBO(185, 233, 255, 1),
                              checkColor: const Color.fromRGBO(255, 255, 255, 1),
                              activeColor: const Color.fromRGBO(46, 228, 149, 1),
                              shape: const CircleBorder(),//这里就是实现圆形的设置
                              value: widget._isChecks[index],
                              onChanged: (  value) {
                                widget._isChecks[index]=value!;
                                if(index==0&&widget._isChecks[0]==true){
                                  for(int i=0;i<widget.waterSectionList.length;i++){
                                    widget._isChecks[i]=true;
                                  }
                                }else if(index==0&&widget._isChecks[0]==false){
                                  for(int i=0;i<widget.waterSectionList.length;i++){
                                    widget._isChecks[i]=false;
                                  }
                                }
                                setState(() {


                                });
                              },
                            ),),
                          // _check(checkboxSelected),
                          SizedBox(width: Adapt.px(16),),
                          Text(
                            widget.waterSectionList[index].name.toString(),
                            style: TextStyle(color:const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28) ),
                          ),
                        ],),

                      ),);
                    }, itemCount: widget.waterSectionList.length,

                  ),),
                Container(
                  decoration: const BoxDecoration(
                    color:  Color.fromRGBO(6, 36, 66, 1),
                    border: Border(bottom: BorderSide(
                        color: Color.fromRGBO(6, 36, 66, 1), width: 0)),
                  ),
                  height: Adapt.px(108),
                  padding: EdgeInsets.only(top: Adapt.px(24),bottom: Adapt.px(20)),
                  child: Row(
                  children: [
                    SizedBox(width: Adapt.px(40),),
                    InkWell(child: Container(
                      width: Adapt.px(325),
                      height: Adapt.px(64),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Adapt.px(32)),
                        border: Border.all(width: Adapt.px(1),color: Color.fromRGBO(185, 233, 255, 1)),
                      ),
                      alignment: Alignment.center,
                      child:  Text('重置',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28)),),
                    ),onTap: (){
                      setState(() {
                        for(int i=0;i<widget.waterSectionList.length;i++){
                          widget._isChecks[i]=false;
                        }
                      });

                    },),
                    SizedBox(width: Adapt.px(20),),
                    InkWell(child: Container(
                      width: Adapt.px(325),
                      height: Adapt.px(64),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(46, 228, 149, 1),
                        borderRadius: BorderRadius.circular(Adapt.px(32)),

                      ),
                      alignment: Alignment.center,
                      child:  Text('确定',style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(28)),),
                    ),onTap: (){
                      List<String> backIdList=[];
                      List<String> backNameList=[];
                      Map<String,String> backMap=Map();
                      for(int i=0;i<widget.waterSectionList.length;i++){
                        if(widget._isChecks[i]==true){
                          backIdList.add(widget.waterSectionList[i].id.toString());
                          backNameList.add(widget.waterSectionList[i].name.toString());
                        }

                      }
                      backMap['id']=listToString(backIdList);
                      backMap['name']=listnameToString(backNameList);
                      dismiss();
                      print(backMap);
                      Navigator.pop(context,backMap);
                    },),
                  ],
                ),),


              ],),

          ),
          onTap: (){
            dismiss();
            Navigator.pop(context,'out');
          },),

      ),

    );
  }
  // Widget _check(bool Selected) {
  //   print(Selected);
  //   return ;
  // }
}
String listToString(List<String> list) {
  if (list .isEmpty) {
    return '-1';
  }
  String ? result;
  list.forEach((string) =>
  {if (result == null) result = string else result = '$result,$string'});
  return result.toString();
}
String listnameToString(List<String> list) {
  if (list .isEmpty) {
    return '全部断面';
  }
  String ? result;
  list.forEach((string) =>
  {if (result == null) result = string else result = '$result,$string'});
  return result.toString();
}
class _PopController {
  late _DropDownWaterSectionMenuState state;

  _bindState(_DropDownWaterSectionMenuState state) {
    this.state = state;
  }

  dismiss() {
    state?.dismiss();
  }
}
