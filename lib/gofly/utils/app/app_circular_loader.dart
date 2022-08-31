import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppCircularProgress extends StatelessWidget {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: size.width * 0.05,
              height: size.width * 0.05,
              child: getLoader(),
            ),
          ],
        ),
      ),
    );
  }

  getLoader() {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator();
    } else {
      return CircularProgressIndicator(
          strokeWidth: 3,
          valueColor:
              new AlwaysStoppedAnimation<Color>(AppColors.primaryColor));
    }
  }
}

class AppCircularProgressForImage extends StatelessWidget {
  final ImageChunkEvent loadingProgress;
  AppCircularProgressForImage(this.loadingProgress);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20,
        height: 20,
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor:
                new AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        ));
  }
}
