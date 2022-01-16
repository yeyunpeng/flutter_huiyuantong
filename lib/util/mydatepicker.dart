

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/util/adapt.dart';
typedef OnSelectedDate = void Function(String startdate,String enddate);
class MyDatePicker extends StatefulWidget {
  // 结果返回
   OnSelectedDate ? onSelectedDate;
   String ? selectedDate; //选中的时间
   int startYear;
   int endYear;
  MyDatePicker(
      {Key? key,  this.onSelectedDate,
         this.selectedDate,
        this.startYear = 1970,
        this.endYear = 2500}) : super(key: key);
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}
class _MyDatePickerState extends State<MyDatePicker>{
  late String year='';
  late String month='';
  late String day='';
  String  startDate="";
  String  endDate="";
   String startTime='开始时间';
   String endTime='结束时间';
  String biaoshi='1';
  //年数组
  List<String> yearList = [];
  //月数组
  List<String> monthList = [];
  //天数组
  List<String> dayList = [];
  //年的索引
  late int yearIndex;
  //月的索引
  late int monthIndex;
  //天的索引
  late int dayIndex;
  //每列的宽度
  late double _columnWidth;
  late FixedExtentScrollController yearScrollController;
  late FixedExtentScrollController monthScrollController;
  late FixedExtentScrollController dayScrollController;

  @override
  void initState() {
    super.initState();

    _columnWidth = Adapt.px(200);

    _setupData();

    _initSelectedIndex();
  }
  ///初始化数据
  void _setupData() {
    for (int i = widget.startYear; i <= widget.endYear; i++) {
      yearList.add(i.toString());
    }

    for (int i = 1; i <= 12; i++) {
      monthList.add(i.toString().padLeft(2, '0'));
    }

    // 初始化天数(当前时间系统时间的天数)
    int year = DateTime.now().year;
    int month;
    if (widget.selectedDate == null || widget.selectedDate!.isEmpty) {
      month = DateTime.now().month;
    } else {
      List<String> date = widget.selectedDate!.split('-');
      month = int.parse(date[1]);
    }

    dayList = _getDayList(year: year, month: month);
  }

  int _getDayCount({required int year, required int month}) {
    int dayCount = DateTime(year, month + 1,0).day;
    return dayCount;
  }

  List<String> _getDayList({required int year, required int month}) {
    List<String> dayList = [];
    int days = _getDayCount(year: year, month: month);
    for (int i = 1; i <= days; i++) {
      dayList.add(i.toString().padLeft(2, '0'));
    }

    return dayList;
  }

  ///选中年月后更新天
  void _updateDayList() {
    int year = int.parse(yearList[yearIndex]);
    int month = int.parse(monthList[monthIndex]);

    setState(() {
      dayIndex = 0;
      dayList = _getDayList(year: year, month: month);

      // if (dayScrollController.positions.length > 0) {
      //   dayScrollController.jumpTo(0);
      // }
    });
  }

  ///初始化时间索引
  void _initSelectedIndex() {
    final List uniqueYearList = Set.from(yearList).toList();
    final List uniqueMonthList = Set.from(monthList).toList();
    final List uniqueDayList = Set.from(dayList).toList();

    ///获取索引
    if (widget.selectedDate != null && widget.selectedDate!.isNotEmpty) {
      ///传了选中日期的时候
      List<String> date = widget.selectedDate!.split('-');

      setState(() {
        yearIndex = uniqueYearList.indexOf(date[0]);
        monthIndex = uniqueMonthList.indexOf(date[1]);
        dayIndex = uniqueDayList.indexOf(date[2]);
      });
    } else {
      ///没有传选中日期默认当前系统时间
      String year1 = DateTime.now().year.toString();
      String month1 = DateTime.now().month.toString().padLeft(2, '0');
      String day1 = DateTime.now().day.toString().padLeft(2, '0');
        year=year1;
      month=month1;
      day=day1;
      setState(() {
        yearIndex = uniqueYearList.indexOf(year1);
        monthIndex = uniqueMonthList.indexOf(month1);
        dayIndex = uniqueDayList.indexOf(day1);
      });

    }
    startDate='$year-$month-$day';
    endDate='$year-$month-$day';
    yearScrollController = FixedExtentScrollController(initialItem: yearIndex);
    monthScrollController =
        FixedExtentScrollController(initialItem: monthIndex);
    dayScrollController = FixedExtentScrollController(initialItem: dayIndex);
  }
  ///年
  Widget _yearPickerView() {
    return Container(
      child: CupertinoPicker(
        scrollController: yearScrollController,
        children: _buildYearWidget(),
        useMagnifier: true,
        magnification: 1.2,

        selectionOverlay: Center(),
        onSelectedItemChanged: (index) {
          setState(() {
            yearIndex = index;
          });
          year=yearList[yearIndex];
          _updateDayList();
        },
        itemExtent: 44,
      ),
    );
  }
  ///月
  Widget _monthPickerView() {
    return Container(
      child: CupertinoPicker(
        scrollController: monthScrollController,
        children: _buildMonthWidget(),
        useMagnifier: true,
        magnification: 1.2,
        selectionOverlay: Center(),
        onSelectedItemChanged: (index) {
          setState(() {
            monthIndex = index;
          });
          month=monthList[monthIndex];
          _updateDayList();
        },
        itemExtent: 44,
      ),
    );
  }

  ///日
  Widget _dayPickerView() {
    return CupertinoPicker(
      scrollController: dayScrollController,
      children: _buildDayWidget(),
      useMagnifier: true,
      magnification: 1.2,
      selectionOverlay:  Center(),
      onSelectedItemChanged: (index) {
        setState(() {
          dayIndex = index;
        });
        day=dayList[dayIndex];
      },
      itemExtent: 44,
    );
  }

  ///年Widget
  List<Widget> _buildYearWidget() {
    List<Widget> yearListWidget = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    print((yearIndex).toString());
    for (var item in yearList) {
      yearListWidget.add(
        Center(
          child: Text(
            "$item年",
            style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(28)),
            maxLines: 1,
          ),
        ),
      );
      // if(item.toString()==yearList[yearIndex].toString()){
      // yearListWidget.add(
      //   Center(
      //     child: Text(
      //       "$item年",
      //       style: TextStyle(color: const Color.fromRGBO(46, 228, 149, 1), fontSize: Adapt.px(28)),
      //       maxLines: 1,
      //     ),
      //   ),
      // );}else{
      //
      // }
    }

    return yearListWidget;
  }

  ///月Widget
  List<Widget> _buildMonthWidget() {
    List<Widget> monthListWidget = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (var item in monthList) {
      monthListWidget.add(
        Center(
          child: Text(
            item+'月',
            style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(28)),
            maxLines: 1,
          ),



        ),
      );

    }

    return monthListWidget;
  }

  ///日Widget
  List<Widget> _buildDayWidget() {
    List<Widget> dayListWidget = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget

    for (var item in dayList) {
      dayListWidget.add(
        Center(
          child: Text(
            item+'日',
            style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(28)),
            maxLines: 1,
          ),
        ),
      );
      // if(item.toString()==(dayIndex+1).toString().padLeft(2, '0')){
      //   //Color mycolor=Color.fromRGBO(46, 228, 149, 1);
      //   dayListWidget.add(
      //     Center(
      //       child: Text(
      //         item+'日',
      //         style: TextStyle(color: const Color.fromRGBO(46, 228, 149, 1), fontSize: Adapt.px(28)),
      //         maxLines: 1,
      //       ),
      //     ),
      //   );
      // }else{
      // dayListWidget.add(
      //    Center(
      //     child: Text(
      //       item+'日',
      //       style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(28)),
      //       maxLines: 1,
      //     ),
      //   ),
      // );}
    }

    return dayListWidget;
  }
  Widget _headerWidget() {
    return Container(
      decoration:  BoxDecoration(
        color: const Color.fromRGBO(8, 37, 68, 1),
        border: Border.all(color:const Color.fromRGBO(8, 37, 68, 1), width: 0),
      ),
      height: Adapt.px(96),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: (){
                 Navigator.pop(context);
              },
              child: Text('取消',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1),fontSize: Adapt.px(28)))
          ),
          TextButton(
              onPressed: (){

                  widget.onSelectedDate!(startDate,endDate);

              },
              child: Text('确定',style: TextStyle(color: const Color.fromRGBO(46, 228, 149, 1),fontSize: Adapt.px(28)))
          ),
        ],
      ),
    );
  }
  Widget _startEnd() {
    if(biaoshi=='1'){
      startTime='$year年-$month月-$day日';
      startDate='$year-$month-$day';
      return Container(
        decoration:  BoxDecoration(
          color: const Color.fromRGBO(8, 37, 68, 1),
          border: Border.all(color:const Color.fromRGBO(8, 37, 68, 1), width: 0),
        ),

        height: Adapt.px(96),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: Adapt.px(32),),
            InkWell(
              child: Container(
            decoration:  BoxDecoration(
            color: const Color.fromRGBO(46, 228, 149, 1),
            borderRadius: BorderRadius.all(Radius.circular(Adapt.px(36))),
            ),
            width: Adapt.px(304),
            height: Adapt.px(64),
            child: Center(child:  Text(startTime,style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1), fontSize: Adapt.px(30)),),),

    ),
              onTap: (){
                print(11111);
                setState(() {
                  biaoshi='1';
                });
                },
            ),

            Container(
              width: Adapt.px(78),
              height: Adapt.px(64),
              child: Center(child:  Text('至',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(30)),),),

            ),
            InkWell(child: Container(
              decoration:  BoxDecoration(
                color: const Color.fromRGBO(185, 233, 255, 0.05),
                borderRadius: BorderRadius.all(Radius.circular(Adapt.px(36))),
              ),
              width: Adapt.px(304),
              height: Adapt.px(64),
              child: Center(child:  Text(endTime,style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(30)),),),

            ),onTap: (){
              setState(() {
                biaoshi='2';
              });
            },),

            SizedBox(width: Adapt.px(32),),
          ],
        ),
      );

    }
    else{
      endTime='$year年-$month月-$day日';
      endDate='$year-$month-$day';
    return Container(
      decoration:  BoxDecoration(
        color: const Color.fromRGBO(8, 37, 68, 1),
        border: Border.all(color:const Color.fromRGBO(8, 37, 68, 1), width: 0),
      ),

      height: Adapt.px(96),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: Adapt.px(32),),
          InkWell(child: Container(
            decoration:  BoxDecoration(
              color: const Color.fromRGBO(185, 233, 255, 0.05),
              borderRadius: BorderRadius.all(Radius.circular(Adapt.px(36))),
            ),
            width: Adapt.px(304),
            height: Adapt.px(64),
            child: Center(child:  Text(startTime,style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(30)),),),

          ),onTap: (){ setState(() {
            biaoshi='1';
          });},),

          Container(
            width: Adapt.px(78),
            height: Adapt.px(64),
            child: Center(child:  Text('至',style: TextStyle(color: const Color.fromRGBO(185, 233, 255, 1), fontSize: Adapt.px(30)),),),

          ),
          InkWell(child: Container(
            decoration:  BoxDecoration(
              color: const Color.fromRGBO(46, 228, 149, 1),
              borderRadius: BorderRadius.all(Radius.circular(Adapt.px(36))),
            ),
            width: Adapt.px(304),
            height: Adapt.px(64),
            child: Center(child:  Text(endTime,style: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1), fontSize: Adapt.px(30)),),),

          ),onTap: (){ setState(() {
            biaoshi='2';
          });},),

          SizedBox(width: Adapt.px(32),),
        ],
      ),
    );
    }

  }
  Widget _datePicker() {
    return Container(
      color: const Color.fromRGBO(8, 37, 68, 1),
      height: Adapt.px(492),
      child: Row(
        children: <Widget>[
          Expanded(child: _yearPickerView()),
          Expanded(child: _monthPickerView()),
          Expanded(child: _dayPickerView()),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize:MainAxisSize.min ,
        children: [
          _headerWidget(),
          _startEnd(),
          _datePicker(),
        ],
      )

    );
  }
  @override
  void dispose() {
    yearScrollController.dispose();
    monthScrollController.dispose();
    dayScrollController.dispose();

    super.dispose();
  }
}



