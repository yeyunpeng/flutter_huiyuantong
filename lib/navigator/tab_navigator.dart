import 'package:flutter/material.dart';
import 'package:flutter_huiyuantong/page/alarm_page.dart';
import 'package:flutter_huiyuantong/page/home_page.dart';
import 'package:flutter_huiyuantong/page/map_page.dart';
import 'package:flutter_huiyuantong/page/my_page.dart';
class TabNavigator extends StatefulWidget{

  @override
  _TabNavigatorState createState()=>_TabNavigatorState();
}
class _TabNavigatorState extends State<TabNavigator> {

  final _defaultColor=Color.fromRGBO(140, 184, 207, 1);
  final _activeColor=Color.fromRGBO(46, 228, 149, 1);
  int _mycurrentIndex = 0;
  final PageController _controller=PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {

    int _currentIndex=0;
    // TODO: implement build
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller:_controller,
        children: <Widget>[
          HomePage(),
          MapPage(),
          AlarmPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(1, 20, 43, 1),
        currentIndex: _mycurrentIndex,
        selectedItemColor:_activeColor ,
        unselectedItemColor: _defaultColor,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          _controller.jumpToPage(index);
          setState(() {
            _mycurrentIndex=index;
          });
        },
        items:    const [
          BottomNavigationBarItem(
            icon:Image(image: AssetImage('images/home.png'),width: 25,height: 25,),
            activeIcon: Image(image: AssetImage('images/home_active.png'),width: 25,height: 25,),
            label: '首页',

          ),
          BottomNavigationBarItem(
            icon:Image(image: AssetImage('images/map.png'),width: 25,height: 25,),
            activeIcon: Image(image: AssetImage('images/map_active.png'),width: 25,height: 25,),
            label: '地图',
          ),
          BottomNavigationBarItem(
            icon:Image(image: AssetImage('images/alarm.png'),width: 25,height: 25,),
            activeIcon: Image(image: AssetImage('images/alarm_active.png'),width: 25,height: 25,),
            label: '报警',
          ),
          BottomNavigationBarItem(
            icon:Image(image: AssetImage('images/my.png'),width: 25,height: 25,),
            activeIcon: Image(image: AssetImage('images/my_active.png'),width: 25,height: 25,),
            label: '我的',
          ),
        ],
      ),
    );
  }

}