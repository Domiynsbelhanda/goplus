import 'package:flutter/material.dart';

class AppSafeArea extends StatelessWidget {
  final Widget? child;
  AppSafeArea({this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: child,
    );
  }
}
