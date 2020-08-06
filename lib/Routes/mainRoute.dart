import 'package:flutter/material.dart';

class MainRouter extends PageRouteBuilder {
  final Widget widget;

  MainRouter(this.widget)
      : super(
          opaque: false,
          barrierColor: null,
          barrierLabel: null,
          maintainState: true,
          transitionDuration: Duration(milliseconds: 350),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
                child: Semantics(
                  scopesRoute: true,
                  explicitChildNodes: true,
                  child: child,
                ));
          },
        );
  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);
}
