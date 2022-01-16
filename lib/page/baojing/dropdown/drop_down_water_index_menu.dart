
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/model/baojing/water_index.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/easy_popup_child.dart';
import 'package:fluttertoast/fluttertoast.dart';



class DropDownWaterIndexMenu extends StatefulWidget with EasyPopupChild{
  final _PopController controller = _PopController();
  List<IndexData> waterIndexList;
   DropDownWaterIndexMenu(this.waterIndexList,{Key? key}) : super(key: key);
  @override
  _DropDownWaterIndexMenuState createState() => _DropDownWaterIndexMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownWaterIndexMenuState extends State<DropDownWaterIndexMenu>
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
                SizedBox(height: MediaQuery.of(context).size.height*1056/1642,
                  child:  ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                  itemBuilder: (BuildContext context, int index) { 
                    return GestureDetector(
                      //behavior: HitTestBehavior.opaque,属性，可以让点击事件透过这个Text的区域。
                      // 如果不添加这个属性，那么只能点击到文字时才会有响应,虽然这里用不到这个属性，因为GestureDetector包裹了整个Container
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context,widget.waterIndexList[index]);
                      },
                      child: Container(
                        height: Adapt.px(88),
                        width: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: Color.fromRGBO(6, 36, 66, 1), width: 0.0)),
                          color:  Color.fromRGBO(6, 36, 66, 1),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.waterIndexList[index].name.toString(),
                          style: TextStyle(color:const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28) ),
                        ),
                      ),
                    );
                  }, itemCount: widget.waterIndexList.length,
                
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
}

class _PopController {
  late _DropDownWaterIndexMenuState state;

  _bindState(_DropDownWaterIndexMenuState state) {
    this.state = state;
  }

  dismiss() {
    state?.dismiss();
  }
}
