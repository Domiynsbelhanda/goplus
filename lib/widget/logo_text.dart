import 'package:flutter/material.dart';

class LogoText extends StatelessWidget{

  late Size size;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 32.0, bottom: 16.0),
      child: Text(
        'GO PLUS',
        style: TextStyle(
            fontSize: size.width / 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Anton'
        ),
      ),
    );
  }
}