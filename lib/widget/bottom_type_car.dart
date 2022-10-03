import 'package:flutter/material.dart';

class BottomTypeCar extends StatelessWidget{

  String image;
  String type;
  String place;
  String prices;
  BottomTypeCar({required this.image, required this.type, required this.place, required this.prices});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.width / 2.6,
      width: MediaQuery.of(context).size.width / 2.6,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                blurRadius: 3.0,
                offset: Offset.fromDirection(2)
            )
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
            ),
            const SizedBox(height: 10.0),
            Flexible(
              child: Text(
                type,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Anton'
                ),
              ),
            ),
            Flexible(
              child: Text(
                place,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Anton'
                ),
              ),
            ),
            Flexible(
              child: Text(
                prices,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}