
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'easy_popup_child.dart';

class DropDownMenu extends StatefulWidget with EasyPopupChild{
  final _PopController controller = _PopController();
  @override
  _DropDownMenuState createState() => _DropDownMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownMenuState extends State<DropDownMenu>
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
                Container(height: Adapt.px(352),child:  ListView(
                  padding: EdgeInsets.only(top: 0),
                  children: [
                    GestureDetector(

                      onTap: () {
                        Navigator.pop(context,'-1');
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
                        child:  Text(
                          '全部类型',
                          style: TextStyle(color:const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28) ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {

                        Navigator.pop(context,'2');
                      },
                      child: Container(
                        height: Adapt.px(88),
                        decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(
                              color: Color.fromRGBO(6, 36, 66, 1), width: 0.0)),
                          color:  Color.fromRGBO(6, 36, 66, 1),
                        ),


                        alignment: Alignment.center,
                        child: Text(
                          '超标报警',
                          style: TextStyle(color:const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28) ),
                        ),
                      ),
                    ),
                    GestureDetector(

                      onTap: () {

                        Navigator.pop(context,'0');
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
                          '零值报警',
                          style: TextStyle(color:const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28) ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {

                        Navigator.pop(context,'1');
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
                          '缺失报警',
                          style: TextStyle(color:const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28) ),
                        ),
                      ),
                    ),
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
}

class _PopController {
  late _DropDownMenuState state;

  _bindState(_DropDownMenuState state) {
    this.state = state;
  }

  dismiss() {
    state?.dismiss();
  }
}
