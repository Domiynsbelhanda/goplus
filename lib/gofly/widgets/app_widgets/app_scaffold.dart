import 'package:flutter/material.dart';
import 'package:goplus/gofly/utils/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? flexibleSpace;
  final Widget? actionHeader;
  const AppScaffold(
      {Key? key,
      this.body,
      this.bottomNavigationBar,
      this.flexibleSpace,
      this.actionHeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _header(context),
          Expanded(child: body ?? Container()),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  _header(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            blurRadius: 6.0,
            color: AppColors.appBarShadow,
          )
        ]),
        child: Column(
          children: [
            actionHeader ?? Container(),
            flexibleSpace ?? Container(),
          ],
        ),
      );
}
