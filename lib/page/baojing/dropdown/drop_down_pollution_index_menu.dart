import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/baojing/pollution_index_model.dart';
import 'package:flutter_huiyuantong/model/baojing/pollution_outlet_model.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/easy_popup_child.dart';
class DropDownPollutionIndexMenu extends StatefulWidget with EasyPopupChild{
  final _PopController controller = _PopController();
  late List<PollutionIndexAir> airList;
  late List<PollutionIndexWater> waterList;
    final List<bool> _airisChecks;
   final List<bool> _waterisChecks;
  final List<bool> _allisChecks;
  DropDownPollutionIndexMenu(this.airList,this.waterList,this._allisChecks,this._airisChecks,this._waterisChecks,{Key? key}) : super(key: key);
  @override
  _DropDownPollutionIndexMenuState createState() => _DropDownPollutionIndexMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownPollutionIndexMenuState extends State<DropDownPollutionIndexMenu>
    with SingleTickerProviderStateMixin {

  TextStyle textStyle1 = TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(24));
  TextStyle textStyle2 = TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24));
  BoxDecoration boxDecoration1 = BoxDecoration(
    color: const Color.fromRGBO(46, 228, 149, 1),
    borderRadius: BorderRadius.circular(Adapt.px(32)),

  );
  BoxDecoration boxDecoration2 =BoxDecoration(
    border: Border.all(width: Adapt.px(1),color: const Color.fromRGBO(185, 233, 255, 1)),
    borderRadius: BorderRadius.circular(Adapt.px(32)),
  );

  late Animation<Offset> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // for(int i=0;i<widget.airList.length;i++){
    //   _airisChecks.add(false);
    // }
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
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: Adapt.px(40),right:Adapt.px(40) ),
                    decoration: const BoxDecoration(
                      color:  Color.fromRGBO(6, 36, 66, 1),
                      border: Border(bottom: BorderSide(
                          color: Color.fromRGBO(6, 36, 66, 1), width: 0)),
                    ),
                    height: MediaQuery.of(context).size.height*1056/1642,
                    width: MediaQuery.of(context).size.width,
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Adapt.px(41),),
                        InkWell(child: Container(
                          width: Adapt.px(152),
                          height: Adapt.px(56),
                          decoration: widget._allisChecks[0]?boxDecoration1:boxDecoration2,
                          alignment: Alignment.center,
                          child:  Text('全部指标',style: widget._allisChecks[0] ? textStyle1 : textStyle2,),
                        ),onTap: (){
                          setState(() {
                            for(int i=0;i<widget.airList.length;i++){
                              widget._airisChecks[i]=false;
                            }
                            for(int i=0;i<widget.waterList.length;i++){
                              widget._waterisChecks[i]=false;
                            }
                            widget._allisChecks[0]=!widget._allisChecks[0];
                          });


                          dismiss();
                          Navigator.pop(context,'-1');
                        },),
                        SizedBox(height: Adapt.px(40),),
                        Text('废水',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),
                        SizedBox(height: Adapt.px(20),),
                        Wrap(
                          spacing:Adapt.px(21),
                          runAlignment : WrapAlignment.start,//run的对齐方式。run可以理解为新的行或者列，如果是水平方向布局的话，run可以理解为新的一行。
                          runSpacing : Adapt.px(21),//run的间距。
                          children: _wateritems(),
                        ),
                        SizedBox(height: Adapt.px(40),),
                        Text('废气',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(24)),),
                        SizedBox(height: Adapt.px(20),),
                        Wrap(
                          spacing:Adapt.px(21),
                          runAlignment : WrapAlignment.start,//run的对齐方式。run可以理解为新的行或者列，如果是水平方向布局的话，run可以理解为新的一行。
                          runSpacing : Adapt.px(21),//run的间距。
                          children: _airitems(),
                        )
                      ],
                    ),
                  ),
                  onTap: (){},
                ),

              ],),

          ),
          onTap: (){
            dismiss();
            print('out');
            Navigator.pop(context,'out');
          },),

      ),

    );
  }
  List<Widget> _airitems(){
    List<Widget> lis=[];
    for(int i=0;i<widget.airList.length;i++){
      lis.add(InkWell(child: Container(
        width: Adapt.px(152),
        height: Adapt.px(56),
        decoration: widget._airisChecks[i]? boxDecoration1:boxDecoration2,
        alignment: Alignment.center,
        child:  Text(widget.airList[i].name.toString(),style:  widget._airisChecks[i]? textStyle1:textStyle2,),
      ),onTap: (){
        setState(() {
          widget._allisChecks[0]=false;
          for(int i=0;i<widget.airList.length;i++){
            widget._airisChecks[i]=false;
          }
          for(int i=0;i<widget.waterList.length;i++){
            widget._waterisChecks[i]=false;
          }
          widget._airisChecks[i]=!widget._airisChecks[i];
          print(widget._allisChecks[0]);
        });
        dismiss();
        Navigator.pop(context,widget.airList[i]);
      },));

    }
    return lis;
  }
  List<Widget> _wateritems(){
    List<Widget> lis=[];
    for(int i=0;i<widget.waterList.length;i++){
      lis.add(InkWell(child: Container(
        width: Adapt.px(152),
        height: Adapt.px(56),
        decoration: widget._waterisChecks[i]? boxDecoration1:boxDecoration2,
        alignment: Alignment.center,
        child:  Text(widget.waterList[i].name.toString(),style: widget._waterisChecks[i]? textStyle1:textStyle2,),
      ),onTap: (){
        setState(() {
          widget._allisChecks[0]=false;
          for(int i=0;i<widget.airList.length;i++){
            widget._airisChecks[i]=false;
          }
          for(int i=0;i<widget.waterList.length;i++){
            widget._waterisChecks[i]=false;
          }
          widget._waterisChecks[i]=!widget._waterisChecks[i];
        });
        dismiss();
        Navigator.pop(context,widget.waterList[i]);
      },));

    }
    return lis;
  }
}
String? listToString(List<String> list) {
  if (list .isEmpty) {
    return '-1';
  }
  String ? result;
  list.forEach((string) =>
  {if (result == null) result = string else result = '$result,$string'});
  return result.toString();
}
class _PopController {
  late _DropDownPollutionIndexMenuState state;

  _bindState(_DropDownPollutionIndexMenuState state) {
    this.state = state;
  }

  dismiss() {
    state?.dismiss();
  }
}
