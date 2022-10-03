import 'package:flutter/material.dart';
import 'package:goplus/pages/homePage.dart';

class BackButtons extends StatelessWidget{
  BackButtons(this.context);
  BuildContext context;
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return GestureDetector(
      onTap: ()=>Navigator.pop(context),
      child: Container(
        height: size.width / 10,
        width: size.width / 10,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width / 10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(
                  2.0,
                  2.0,
                ),
                blurRadius: 3.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              const BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ]
        ),
        child: const Center(
          child: Icon(
            Icons.arrow_back,
            size: 32,
          ),
        ),
      ),
    );
  }
}

class CloseButtons extends StatelessWidget{
  CloseButtons(this.context);
  BuildContext context;
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return GestureDetector(
      onTap: ()=>Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  HomePage()
          ),
              (Route<dynamic> route) => false
      ),
      child: Container(
        height: size.width / 10,
        width: size.width / 10,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width / 10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(
                  2.0,
                  2.0,
                ),
                blurRadius: 3.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              const BoxShadow(
                color: Colors.black,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ]
        ),
        child: const Center(
          child: Icon(
            Icons.close,
            size: 32,
          ),
        ),
      ),
    );
  }
}