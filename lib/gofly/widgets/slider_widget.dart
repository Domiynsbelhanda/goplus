import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: size.height * 0.3,
          child: SvgPicture.asset(widget.image),
        ),
        SizedBox(height: 45.0),
        Text(
          widget.name,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          widget.intro,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey[400]),
        )
      ],
    );
  }
}
