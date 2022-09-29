import 'dart:io';
import 'package:flutter/material.dart';

class MiniCardPicture extends StatelessWidget {
  MiniCardPicture({this.onTap, this.imagePath, this.title, this.description});

  final Function? onTap;
  final String? imagePath;
  final String? title;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: ()=>onTap!(),
      child: Stack(
        children: [
          Container(
            height: size.width / 2,
            padding: EdgeInsets.all(10.0),
            width: size.width / 1.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      '${imagePath!}'
                  )
              ),
            ),
          ),

          Container(
            height: size.width / 2,
            padding: EdgeInsets.all(10.0),
            width: size.width / 1.4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [
                      Colors.grey.withOpacity(0.0),
                      Colors.black.withOpacity(.5),
                    ],
                    stops: [
                      0.0,
                      1.0
                    ]
                )
            ),
          ),

          // Positioned(
          //   bottom: 0.0,
          //     child: Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             '${title!}',
          //             style: TextStyle(
          //                 fontSize: size.width / 25,
          //               color: Colors.white
          //             ),
          //           )
          //         ],
          //       ),
          //     )
          // )
        ],
      ),
    );
  }
}