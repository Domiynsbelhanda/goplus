import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplus/gofly/utils/app_colors.dart';

class Sliders extends StatefulWidget {
  final String image;
  final String name;
  final String intro;
  Sliders({required this.image, required this.name, required this.intro});
  @override
  _SlidersState createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  '${widget.image}'
                ),
              fit: BoxFit.fitHeight
            )
          ),
        ),

        Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.0),
                Colors.white.withOpacity(1.0),
              ],
            ),
          ),
        ),

        Positioned(
          bottom: 100.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            width: size.width / 1.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 45.0),
                Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  widget.intro,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
