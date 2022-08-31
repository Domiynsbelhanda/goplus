import 'package:flutter/material.dart';

class CustomRRectClipper extends CustomClipper<Path> {
  bool left;
  CustomRRectClipper({this.left});
  @override
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height);
    left ? path.lineTo(0.0, size.height) : path.lineTo(0.0, size.height * 0.60);
    left
        ? path.lineTo(15, size.height * 0.8)
        : path.quadraticBezierTo(0, size.height * 0.80, 15, size.height * 0.80);
    path.lineTo(size.width - 20, size.height * 0.80);

    left
        ? path.quadraticBezierTo(
            size.width,
            size.height * 0.80,
            size.width,
            size.height * 0.65,
          )
        : path.lineTo(size.width, size.height);

    path.lineTo(size.width, 00);
    path.lineTo(15.0, 0.0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
