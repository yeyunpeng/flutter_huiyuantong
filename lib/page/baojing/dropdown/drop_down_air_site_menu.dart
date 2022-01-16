
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'package:flutter_huiyuantong/model/baojing/air_site_model.dart';
import 'package:flutter_huiyuantong/model/baojing/air_site_type_model.dart';

import 'package:flutter_huiyuantong/util/adapt.dart';
import 'package:flutter_huiyuantong/util/easy_popup_child.dart';
class DropDownAirSiteMenu extends StatefulWidget with EasyPopupChild{
  final _PopController controller = _PopController();

  List<SiteTypeData> siteTypelist;
//全部
  List<Airshebei> alliindexList;
  List<bool> allchecks;
//国标

  List<Airshebei> gbSiteList;
  List<bool> gbichecks;
//网格

  List<Airshebei> wgSiteList;
  List<bool> wgichecks;
//有毒

  List<Airshebei> ydSiteList;
  List<bool> ydichecks;
//恶臭

  List<Airshebei> ecSiteList;
  List<bool> ecichecks;

  DropDownAirSiteMenu(this.siteTypelist,this.alliindexList,this.allchecks,this.gbSiteList,this.gbichecks,this.wgSiteList,this.wgichecks,this.ydSiteList,this.ydichecks,this.ecSiteList,this.ecichecks,{Key? key}) : super(key: key);
  @override
  _DropDownAirSiteMenuState createState() => _DropDownAirSiteMenuState();

  @override
  dismiss() {
    controller.dismiss();
  }
}

class _DropDownAirSiteMenuState extends State<DropDownAirSiteMenu>
    with SingleTickerProviderStateMixin {
  List<bool> _jiaobiao=[];
  List<int> _jiaobiaonum=[];
  String biaoshi='quan';
  late List<Airshebei> xuanranList;
  List<bool> xuanrancheckList=[];
  TextStyle textStyle2 = TextStyle(
    color: const Color.fromRGBO(185, 233, 255, 1),
    fontSize: Adapt.px(28),);
  TextStyle textStyle1 = TextStyle(
    color: const Color.fromRGBO(46, 228, 149, 1),
    decoration: TextDecoration.underline,
    decorationColor: const Color.fromRGBO(46, 228, 149, 1),
    fontSize: Adapt.px(28),);
  // TextStyle textStyle12 = TextStyle(
  //   color: const Color.fromRGBO(185, 233, 255, 1),
  //   fontSize: Adapt.px(28),);
  // TextStyle textStyle11 = TextStyle(
  //   color: const Color.fromRGBO(46, 228, 149, 1),
  //   decorationColor: const Color.fromRGBO(46, 228, 149, 1),
  //   fontSize: Adapt.px(28),);
  TextStyle jiaobiaotextStyle1 = TextStyle(color: Colors.transparent,fontSize: Adapt.px(20));
  TextStyle jiaobiaotextStyle2 = TextStyle(color: const Color.fromRGBO(255, 255, 255, 1),fontSize: Adapt.px(20));
  BoxDecoration boxDecoration1 =BoxDecoration(
      borderRadius: BorderRadius.circular(Adapt.px(12)),
      color:  Colors.transparent
  );
  BoxDecoration boxDecoration2 =BoxDecoration(
      borderRadius: BorderRadius.circular(Adapt.px(12)),
      color: const Color.fromRGBO(46, 228, 149, 1)
  );
  List<bool>typechecks=[];
  late Animation<Offset> _animation;
  late AnimationController _controller;
  bool biaoshi12=false;
  @override
  void initState() {
    super.initState();
    print(111);
    //默认所有单选框不选中
    xuanranList=widget.alliindexList;
    xuanrancheckList=widget.allchecks;
    for(int i=0;i<widget.siteTypelist.length;i++){
      typechecks.add(false);
      _jiaobiao.add(false);
      _jiaobiaonum.add(0);
    }
    typechecks[0]=true;


    widget.controller._bindState(this);
//动画设置
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
    int gbnum=0;
    //数字角标
    for(int i=0;i<widget.gbichecks.length;i++){
      if(widget.gbichecks[i]==true){
        gbnum++;
      }
    }
    int wgnum=0;
    for(int i=0;i<widget.wgichecks.length;i++){
      if(widget.wgichecks[i]==true){
        wgnum++;
      }
    }
    int ydnum=0;
    for(int i=0;i<widget.ydichecks.length;i++){
      if(widget.ydichecks[i]==true){
        ydnum++;
      }
    }
    int ecnum=0;
    for(int i=0;i<widget.ecichecks.length;i++){
      if(widget.ecichecks[i]==true){
        ecnum++;
      }
    }
//num>0时，显示==0时隐藏
    if(gbnum>0){
      _jiaobiao[1]=true;
      _jiaobiaonum[1]=gbnum;
    } if(wgnum>0){
      _jiaobiao[2]=true;
      _jiaobiaonum[2]=wgnum;
    } if(ydnum>0){
      _jiaobiao[3]=true;
      _jiaobiaonum[3]=ydnum;
    } if(ecnum>0){
      _jiaobiao[4]=true;
      _jiaobiaonum[4]=ecnum;
    }
    if(gbnum==0){
      _jiaobiao[1]=false;
      _jiaobiaonum[1]=gbnum;
    } if(wgnum==0){
      _jiaobiao[2]=false;
      _jiaobiaonum[2]=wgnum;
    } if(ydnum==0){
      _jiaobiao[3]=false;
      _jiaobiaonum[3]=ydnum;
    } if(ecnum==0){
      _jiaobiao[4]=false;
      _jiaobiaonum[4]=ecnum;
    }

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
                                  xuanranList=widget.gbSiteList;
                                  xuanrancheckList=widget.gbichecks;
                                  biaoshi='gb';
                                }else if(index==2){
                                  xuanranList=widget.wgSiteList;
                                  xuanrancheckList=widget.wgichecks;
                                  biaoshi='wg';
                                }else if(index==3){
                                  xuanranList=widget.ydSiteList;
                                  xuanrancheckList=widget.ydichecks;
                                  biaoshi='yd';
                                }else if(index==4){
                                  xuanranList=widget.ecSiteList;
                                  xuanrancheckList=widget.ecichecks;
                                  biaoshi='ec';
                                }


                              },
                              child: Stack(
                                children: [
                                  Container(
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
                                  Positioned(
                                      right: Adapt.px(58),
                                      top: Adapt.px(8),
                                      child: Container(
                                        height: Adapt.px(24),
                                        width: Adapt.px(24),
                                        alignment: Alignment.center,
                                        decoration: _jiaobiao[index] ? boxDecoration2:boxDecoration1,
                                        child: Text(_jiaobiaonum[index].toString(),style: _jiaobiao[index] ? jiaobiaotextStyle2:jiaobiaotextStyle1),
                                      )),
                                ],
                              ),

                            );
                          }, itemCount: widget.siteTypelist.length,

                        ),
                      ),
                      Column(children: [
                        Container(
                          color:  Color.fromRGBO(6, 36, 66, 1),
                          width: Adapt.px(510),
                          height: MediaQuery.of(context).size.height*1056/1642-Adapt.px(108),
                          child: ListView.builder(
                            padding: const EdgeInsets.only(top: 0),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                //behavior: HitTestBehavior.opaque,属性，可以让点击事件透过这个Text的区域。
                                // 如果不添加这个属性，那么只能点击到文字时才会有响应,虽然这里用不到这个属性，因为GestureDetector包裹了整个Container
                                //behavior: HitTestBehavior.opaque,
                                onTap: () {

                                  //标识判断是哪个多选列表
                                  if(biaoshi=='quan'){
                                    widget.allchecks[0]=!widget.allchecks[0];//点击取反

                                    //全部站点全选设置
                                    if(widget.allchecks[0]==true){
                                      for(int i=0;i<widget.gbichecks.length;i++){
                                        widget.gbichecks[i]=true;
                                      }
                                      for(int i=0;i<widget.wgichecks.length;i++){
                                        widget.wgichecks[i]=true;
                                      }
                                      for(int i=0;i<widget.ydichecks.length;i++){
                                        widget.ydichecks[i]=true;
                                      }
                                      for(int i=0;i<widget.ecichecks.length;i++){
                                        widget.ecichecks[i]=true;
                                      }
                                    }else{
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
                                    }

                                  }else if(biaoshi=='gb'){
                                    widget.gbichecks[index]=!widget.gbichecks[index];
                                    //分页面的全选
                                    if(index==0&&widget.gbichecks[0]==true){
                                      for(int i=0;i<widget.gbichecks.length;i++){
                                        widget.gbichecks[i]=true;
                                      }
                                    }else if(index==0&&widget.gbichecks[0]==false){
                                      for(int i=0;i<widget.gbichecks.length;i++){
                                        widget.gbichecks[i]=false;
                                      }
                                    }
                                    //全选和非全选互斥
                                    for(int i=1;i<widget.gbichecks.length;i++){
                                      if(widget.gbichecks[i]==false){ biaoshi12=false;break;}else if(widget.gbichecks[i]==true){biaoshi12=true;}
                                    }
                                    if(biaoshi12==false){widget.gbichecks[0]=false;}else if(biaoshi12==true){
                                      widget.gbichecks[0]=true;
                                    }
                                    //if(index!=0&&widget.gbichecks[index]==false){ widget.gbichecks[0]=false;}else if(widget.gbichecks[index]==true){widget.gbichecks[0]=true;}
                                    // for(int i=widget.gbichecks.length;i>0;i--){
                                    //   if(widget.gbichecks[index]==false){ widget.gbichecks[0]=false;
                                    //   break;
                                    //   }
                                    //    if(widget.gbichecks[i]==true){ widget.gbichecks[0]=true;}
                                    // }

                                    // widget.gbichecks[0]=false;
                                    widget.allchecks[0]=false;







                                  }else if(biaoshi=='wg'){
                                    widget.wgichecks[index]=!widget.wgichecks[index];
                                    if(index==0&&widget.wgichecks[0]==true){
                                      for(int i=0;i<widget.wgichecks.length;i++){
                                        widget.wgichecks[i]=true;
                                      }
                                    }else if(index==0&&widget.wgichecks[0]==false){
                                      for(int i=0;i<widget.wgichecks.length;i++){
                                        widget.wgichecks[i]=false;
                                      }
                                    }
                                    for(int i=1;i<widget.wgichecks.length;i++){
                                      if(widget.wgichecks[i]==false){ biaoshi12=false;break;}else if(widget.wgichecks[i]==true){biaoshi12=true;}
                                    }
                                    if(biaoshi12==false){widget.wgichecks[0]=false;}else if(biaoshi12==true){
                                      widget.wgichecks[0]=true;
                                    }
                                    //if(index!=0&&widget.wgichecks[index]==false){ widget.wgichecks[0]=false;}else if(widget.wgichecks[index]==true){widget.wgichecks[0]=true;}
                                    // for(int i=1;i<widget.wgichecks.length;i++){
                                    //   if(index!=0&&widget.wgichecks[i]==false){ widget.wgichecks[0]=false;}
                                    // }

                                    widget.allchecks[0]=false;

                                  }else if(biaoshi=='yd'){
                                    widget.ydichecks[index]=!widget.ydichecks[index];
                                    if(index==0&&widget.ydichecks[0]==true){
                                      for(int i=0;i<widget.ydichecks.length;i++){
                                        widget.ydichecks[i]=true;
                                      }
                                    }else if(index==0&&widget.ydichecks[0]==false){
                                      for(int i=0;i<widget.ydichecks.length;i++){
                                        widget.ydichecks[i]=false;
                                      }
                                    }
                                    for(int i=1;i<widget.ydichecks.length;i++){
                                      if(widget.ydichecks[i]==false){ biaoshi12=false;break;}else if(widget.ydichecks[i]==true){biaoshi12=true;}
                                    }
                                    if(biaoshi12==false){widget.ydichecks[0]=false;}else if(biaoshi12==true){
                                      widget.ydichecks[0]=true;
                                    }
                                    //if(index!=0&&widget.ydichecks[index]==false){ widget.ydichecks[0]=false;}else if(widget.ydichecks[index]==true){widget.ydichecks[0]=true;}
                                    // for(int i=1;i<widget.ydichecks.length;i++){
                                    //   if(index!=0&&widget.ydichecks[i]==false){ widget.ydichecks[0]=false;}
                                    // }
                                    widget.allchecks[0]=false;


                                  }else if(biaoshi=='ec'){
                                    widget.ecichecks[index]=!widget.ecichecks[index];
                                    if(index==0&&widget.ecichecks[0]==true){
                                      for(int i=1;i<widget.ecichecks.length;i++){

                                        widget.ecichecks[i]=true;
                                      }
                                    }else if(index==0&&widget.ecichecks[0]==false){
                                      for(int i=1;i<widget.ecichecks.length;i++){

                                        widget.ecichecks[i]=false;
                                      }
                                    }
                                    for(int i=1;i<widget.ecichecks.length;i++){
                                      if(widget.ecichecks[i]==false){ biaoshi12=false;break;}else if(widget.ecichecks[i]==true){biaoshi12=true;}
                                    }
                                    if(biaoshi12==false){widget.ecichecks[0]=false;}else if(biaoshi12==true){
                                      widget.ecichecks[0]=true;
                                    }
                                    // if(index!=0&&widget.ecichecks[index]==false){ widget.ecichecks[0]=false;}else if(widget.ecichecks[index]==true){widget.ecichecks[0]=true;}

                                    widget.allchecks[0]=false;

                                  }
                                  if(widget.gbichecks[0]==true&&widget.wgichecks[0]==true&&widget.ydichecks[0]==true&&widget.ecichecks[0]==true){
                                    widget.allchecks[0]=true;
                                  }else{
                                    widget.allchecks[0]=false;
                                  }
                                  setState(() {

                                  });
                                  // dismiss();
                                  // Navigator.pop(context,xuanranList[index]);
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
                                        value: xuanrancheckList[index],
                                        onChanged: (value) {

                                          setState(() {

                                            //标识判断是哪个多选列表
                                            if(biaoshi=='quan'){
                                              widget.allchecks[0]=!widget.allchecks[0];//点击取反
                                              //全部站点全选设置
                                              if(widget.allchecks[0]==true){
                                                for(int i=0;i<widget.gbichecks.length;i++){
                                                  widget.gbichecks[i]=true;
                                                }
                                                for(int i=0;i<widget.wgichecks.length;i++){
                                                  widget.wgichecks[i]=true;
                                                }
                                                for(int i=0;i<widget.ydichecks.length;i++){
                                                  widget.ydichecks[i]=true;
                                                }
                                                for(int i=0;i<widget.ecichecks.length;i++){
                                                  widget.ecichecks[i]=true;
                                                }
                                              }else{
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
                                              }

                                            }else if(biaoshi=='gb'){
                                              widget.gbichecks[index]=!widget.gbichecks[index];
                                              //分页面的全选
                                              if(index==0&&widget.gbichecks[0]==true){
                                                for(int i=0;i<widget.gbichecks.length;i++){
                                                  widget.gbichecks[i]=true;
                                                }
                                              }else if(index==0&&widget.gbichecks[0]==false){
                                                for(int i=0;i<widget.gbichecks.length;i++){
                                                  widget.gbichecks[i]=false;
                                                }
                                              }
                                              //全选和非全选互斥
                                              for(int i=1;i<widget.gbichecks.length;i++){
                                                if(widget.gbichecks[i]==false){ biaoshi12=false;break;}else if(widget.gbichecks[i]==true){biaoshi12=true;}
                                              }
                                              if(biaoshi12==false){widget.gbichecks[0]=false;}else if(biaoshi12==true){
                                                widget.gbichecks[0]=true;
                                              }
                                              //if(index!=0&&widget.gbichecks[index]==false){ widget.gbichecks[0]=false;}else if(widget.gbichecks[index]==true){widget.gbichecks[0]=true;}
                                              // for(int i=widget.gbichecks.length;i>0;i--){
                                              //   if(widget.gbichecks[index]==false){ widget.gbichecks[0]=false;
                                              //   break;
                                              //   }
                                              //    if(widget.gbichecks[i]==true){ widget.gbichecks[0]=true;}
                                              // }

                                              // widget.gbichecks[0]=false;
                                              widget.allchecks[0]=false;







                                            }else if(biaoshi=='wg'){
                                              widget.wgichecks[index]=!widget.wgichecks[index];
                                              if(index==0&&widget.wgichecks[0]==true){
                                                for(int i=0;i<widget.wgichecks.length;i++){
                                                  widget.wgichecks[i]=true;
                                                }
                                              }else if(index==0&&widget.wgichecks[0]==false){
                                                for(int i=0;i<widget.wgichecks.length;i++){
                                                  widget.wgichecks[i]=false;
                                                }
                                              }
                                              for(int i=1;i<widget.wgichecks.length;i++){
                                                if(widget.wgichecks[i]==false){ biaoshi12=false;break;}else if(widget.wgichecks[i]==true){biaoshi12=true;}
                                              }
                                              if(biaoshi12==false){widget.wgichecks[0]=false;}else if(biaoshi12==true){
                                                widget.wgichecks[0]=true;
                                              }
                                              //if(index!=0&&widget.wgichecks[index]==false){ widget.wgichecks[0]=false;}else if(widget.wgichecks[index]==true){widget.wgichecks[0]=true;}
                                              // for(int i=1;i<widget.wgichecks.length;i++){
                                              //   if(index!=0&&widget.wgichecks[i]==false){ widget.wgichecks[0]=false;}
                                              // }

                                              widget.allchecks[0]=false;

                                            }else if(biaoshi=='yd'){
                                              widget.ydichecks[index]=!widget.ydichecks[index];
                                              if(index==0&&widget.ydichecks[0]==true){
                                                for(int i=0;i<widget.ydichecks.length;i++){
                                                  widget.ydichecks[i]=true;
                                                }
                                              }else if(index==0&&widget.ydichecks[0]==false){
                                                for(int i=0;i<widget.ydichecks.length;i++){
                                                  widget.ydichecks[i]=false;
                                                }
                                              }
                                              for(int i=1;i<widget.ydichecks.length;i++){
                                                if(widget.ydichecks[i]==false){ biaoshi12=false;break;}else if(widget.ydichecks[i]==true){biaoshi12=true;}
                                              }
                                              if(biaoshi12==false){widget.ydichecks[0]=false;}else if(biaoshi12==true){
                                                widget.ydichecks[0]=true;
                                              }
                                              //if(index!=0&&widget.ydichecks[index]==false){ widget.ydichecks[0]=false;}else if(widget.ydichecks[index]==true){widget.ydichecks[0]=true;}
                                              // for(int i=1;i<widget.ydichecks.length;i++){
                                              //   if(index!=0&&widget.ydichecks[i]==false){ widget.ydichecks[0]=false;}
                                              // }
                                              widget.allchecks[0]=false;


                                            }else if(biaoshi=='ec'){
                                              widget.ecichecks[index]=!widget.ecichecks[index];
                                              if(index==0&&widget.ecichecks[0]==true){
                                                for(int i=1;i<widget.ecichecks.length;i++){

                                                  widget.ecichecks[i]=true;
                                                }
                                              }else if(index==0&&widget.ecichecks[0]==false){
                                                for(int i=1;i<widget.ecichecks.length;i++){

                                                  widget.ecichecks[i]=false;
                                                }
                                              }
                                              for(int i=1;i<widget.ecichecks.length;i++){
                                                if(widget.ecichecks[i]==false){ biaoshi12=false;break;}else if(widget.ecichecks[i]==true){biaoshi12=true;}
                                              }
                                              if(biaoshi12==false){widget.ecichecks[0]=false;}else if(biaoshi12==true){
                                                widget.ecichecks[0]=true;
                                              }
                                              // if(index!=0&&widget.ecichecks[index]==false){ widget.ecichecks[0]=false;}else if(widget.ecichecks[index]==true){widget.ecichecks[0]=true;}

                                              widget.allchecks[0]=false;

                                            }
                                            if(widget.gbichecks[0]==true&&widget.wgichecks[0]==true&&widget.ydichecks[0]==true&&widget.ecichecks[0]==true){
                                              widget.allchecks[0]=true;
                                            }else{
                                              widget.allchecks[0]=false;
                                            }
                                          });
                                        },
                                      ),),
                                    // _check(checkboxSelected),
                                    SizedBox(width: Adapt.px(16),),
                                    Text(
                                      xuanranList[index].name.toString(),
                                      style: TextStyle(color:const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28) ),
                                    ),
                                  ],),
                                ),
                              );
                            }, itemCount: xuanranList.length,

                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color:  Color.fromRGBO(6, 36, 66, 1),
                            border: Border(bottom: BorderSide(
                                color: Color.fromRGBO(6, 36, 66, 1), width: 0)),
                          ),
                          width: Adapt.px(510),
                          height: Adapt.px(108),
                          padding: EdgeInsets.only(top: Adapt.px(20),bottom: Adapt.px(20)),
                          child: Row(
                            children: [
                              SizedBox(width: Adapt.px(40),),
                              InkWell(child: Container(
                                width: Adapt.px(205),
                                height: Adapt.px(64),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Adapt.px(32)),
                                  border: Border.all(width: Adapt.px(1),color: Color.fromRGBO(185, 233, 255, 1)),
                                ),
                                alignment: Alignment.center,
                                child:  Text('重置',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28)),),
                              ),onTap: (){
                                setState(() {
                                  widget.allchecks[0]=false;
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
                                  // ecnum=0;
                                  for(int i=0;i<widget.siteTypelist.length;i++){
                                    _jiaobiao[i]=false;
                                    _jiaobiaonum[i]=0;
                                  }
                                });

                              },),
                              SizedBox(width: Adapt.px(20),),
                              InkWell(child: Container(
                                width: Adapt.px(205),
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
                                Map<String,String> backMap={};
                                if(widget.allchecks[0]==true){
                                  backIdList.add('-1');
                                  backNameList.add('全部站点');
                                }
                                for(int i=0;i<widget.gbSiteList.length;i++){
                                  if(widget.gbichecks[i]==true){
                                    backIdList.add(widget.gbSiteList[i].sn.toString());
                                    backNameList.add(widget.gbSiteList[i].name.toString());
                                  }
                                }for(int i=0;i<widget.wgSiteList.length;i++){
                                  if(widget.wgichecks[i]==true){
                                    backIdList.add(widget.wgSiteList[i].sn.toString());
                                    backNameList.add(widget.wgSiteList[i].name.toString());
                                  }
                                }for(int i=0;i<widget.ydSiteList.length;i++){
                                  if(widget.ydichecks[i]==true){
                                    backIdList.add(widget.ydSiteList[i].sn.toString());
                                    backNameList.add(widget.ydSiteList[i].name.toString());
                                  }
                                }for(int i=0;i<widget.ecSiteList.length;i++){
                                  if(widget.ecichecks[i]==true){
                                    backIdList.add(widget.ecSiteList[i].sn.toString());
                                    backNameList.add(widget.ecSiteList[i].name.toString());
                                  }
                                }
                                backMap['id']=listToString(backIdList);
                                backMap['name']=listnameToString(backNameList);
                                dismiss();
                                Navigator.pop(context,backMap);
                              },),
                            ],
                          ),),
                      ],),


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
      return '全部站点';
    }
    String ? result;
    list.forEach((string) =>
    {if (result == null) result = string else result = '$result,$string'});
    return result.toString();
  }
}

class _PopController {
  late _DropDownAirSiteMenuState state;

  _bindState(_DropDownAirSiteMenuState state) {
    this.state = state;
  }

  dismiss() {
    state?.dismiss();
  }
}
