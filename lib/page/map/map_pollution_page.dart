 import 'dart:async';
 import 'dart:io';
 import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
 import 'package:flutter/material.dart';

 import 'package:flutter/services.dart';
 import 'package:permission_handler/permission_handler.dart';

 import 'const_config.dart';
 import 'package:amap_flutter_base/amap_flutter_base.dart';
class MapPollutionPage extends StatefulWidget{
  const MapPollutionPage({Key? key}) : super(key: key);
  @override
  _MapPollutionPageState createState()=>_MapPollutionPageState();
}
class _MapPollutionPageState extends State<MapPollutionPage>{


  bool _mapCreated = false;
  CustomStyleOptions _customStyleOptions = CustomStyleOptions(false);

   Map<String, Object> _locationResult={};

  late StreamSubscription<Map<String, Object>> _locationListener;

  final AMapFlutterLocation _locationPlugin = AMapFlutterLocation();
  //加载自定义地图样式
  void _loadCustomData() async {
    _customStyleOptions ??= CustomStyleOptions(false);
    ByteData styleByteData = await rootBundle.load('assets/style.data');
    _customStyleOptions.styleData = styleByteData.buffer.asUint8List();
    ByteData styleExtraByteData =
    await rootBundle.load('assets/style_extra.data');
    _customStyleOptions.styleExtraData =
        styleExtraByteData.buffer.asUint8List();
    //如果需要加载完成后直接展示自定义地图，可以通过setState修改CustomStyleOptions的enable为true
    setState(() {
      _customStyleOptions.enabled = true;
    });
  }
  ///设置定位参数
  void _setLocationOption() {
    if (null != _locationPlugin) {
      AMapLocationOption locationOption = AMapLocationOption();

      ///是否单次定位
      locationOption.onceLocation = true;

      ///是否需要返回逆地理信息
      locationOption.needAddress = true;

      ///逆地理信息的语言类型
      locationOption.geoLanguage = GeoLanguage.DEFAULT;

      locationOption.desiredLocationAccuracyAuthorizationMode =
          AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

      locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

      ///设置Android端连续定位的定位间隔
      locationOption.locationInterval = 2000;

      ///设置Android端的定位模式<br>
      ///可选值：<br>
      ///<li>[AMapLocationMode.Battery_Saving]</li>
      ///<li>[AMapLocationMode.Device_Sensors]</li>
      ///<li>[AMapLocationMode.Hight_Accuracy]</li>
      locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

      ///设置iOS端的定位最小更新距离<br>
      locationOption.distanceFilter = -1;

      ///设置iOS端期望的定位精度
      /// 可选值：<br>
      /// <li>[DesiredAccuracy.Best] 最高精度</li>
      /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
      /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
      /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
      /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
      locationOption.desiredAccuracy = DesiredAccuracy.Best;

      ///设置iOS端是否允许系统暂停定位
      locationOption.pausesLocationUpdatesAutomatically = false;

      ///将定位参数设置给定位插件
      _locationPlugin.setLocationOption(locationOption);
    }
  }
  ///开始定位
  void _startLocation() {
    if (null != _locationPlugin) {
      ///开始定位之前设置定位参数
      _setLocationOption();
      _locationPlugin.startLocation();
    }
  }

  ///停止定位
  void _stopLocation() {
    if (null != _locationPlugin) {
      _locationPlugin.stopLocation();
    }
  }
  @override
  void initState() {
    super.initState();
    _loadCustomData();
    AMapFlutterLocation.setApiKey(
           '787dc18adfa7c2705eb11ab4994061c5', "a57d31271de2c454cc30206974e0ace2");
    /// [hasShow] 隐私权政策是否弹窗展示告知用户
    AMapFlutterLocation.updatePrivacyShow(true, true);
    /// [hasAgree] 隐私权政策是否已经取得用户同意
    AMapFlutterLocation.updatePrivacyAgree(true);

    /// 动态申请定位权限
    requestPermission();
    ///iOS 获取native精度类型
    if (Platform.isIOS) {
      requestAccuracyAuthorization();
    }

    ///注册定位结果监听
    _locationListener = _locationPlugin
        .onLocationChanged()
        .listen((Map<String, Object> result) {
      setState(() {
        _locationResult = result;
      });
    });
    _startLocation();
  }
  ///获取iOS native的accuracyAuthorization类型
  void requestAccuracyAuthorization() async {
    AMapAccuracyAuthorization currentAccuracyAuthorization =
    await _locationPlugin.getSystemAccuracyAuthorization();
    if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationFullAccuracy) {
      print("精确定位类型");
    } else if (currentAccuracyAuthorization ==
        AMapAccuracyAuthorization.AMapAccuracyAuthorizationReducedAccuracy) {
      print("模糊定位类型");
    } else {
      print("未知定位类型");
    }
  }

  /// 动态申请定位权限
  void requestPermission() async {
    // 申请权限
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      print("定位权限申请通过");
    } else {
      print("定位权限申请不通过");
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
  @override
  void dispose() {
    super.dispose();

    ///移除定位监听
    _locationListener.cancel();

    ///销毁定位
    _locationPlugin.destroy();
  }
  @override
  Widget build(BuildContext context) {
    print('111111+${_locationResult['latitude']}');
    print('111111+${_locationResult['longitude']}');
    // TODO: implement build
    final AMapWidget map = AMapWidget(
      privacyStatement: ConstConfig.amapPrivacyStatement,
      apiKey: ConstConfig.amapApiKeys,
      onMapCreated: onMapCreated,
      customStyleOptions: _customStyleOptions,
      initialCameraPosition: CameraPosition(
        target: LatLng(double.parse(_locationResult['latitude'].toString()), double.parse(_locationResult['longitude'].toString())),
        zoom: 12.0,
      ),

    );
    // TODO: implement build
    return  ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: map,
          ),
          // Positioned(
          //     right: 10,
          //     bottom: 15,
          //     child: Container(
          //       alignment: Alignment.centerLeft,
          //       child: Column(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: _approvalNumberWidget),
          //     ))
        ],
      ),
    );
  }
  void onMapCreated(AMapController controller) {
    if (null != controller) {
      _mapCreated = true;
    }
  }
}

