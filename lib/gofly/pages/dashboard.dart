import 'package:flutter/material.dart';
import 'package:goplus/gofly/utils/app_colors.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard>{

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cardDashboard('Go Taxi', 'taxi', 1)
        ],
      )
    );
  }

  Widget cardDashboard(String text, String icons, int notification){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: size.width / 2,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor,
              offset: const Offset(
                2.0,
                2.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ),
          ]
        ),
      ),
    );
  }
}

