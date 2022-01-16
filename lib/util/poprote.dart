import 'package:flutter/material.dart';
class PopRoute extends PopupRoute {
  final Duration _duration = const Duration(milliseconds: 300);
  late Widget child;

  PopRoute( this.child);
  @override
  // TODO: implement barrierColor
  Color? get barrierColor => null;

  @override
  // TODO: implement barrierDismissible
  bool get barrierDismissible => true;

  @override
  // TODO: implement barrierLabel
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // TODO: implement buildPage
    return child;
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => _duration;

}
