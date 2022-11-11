import 'package:flutter/material.dart';
import 'package:goplus/utils/app_colors.dart';

class BottomTypeCar extends StatelessWidget{

  String image;
  String type;
  String place;
  String prices;
  Function() onTap;
  bool active;
  BottomTypeCar({required this.image, required this.type, required this.place, required this.prices, required this.onTap, required this.active});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                image,
                height: MediaQuery.of(context).size.width / 11,
              ),
              const SizedBox(width: 8.0),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          type,
                          style: TextStyle(
                              fontFamily: 'Anton',
                            fontSize: MediaQuery.of(context).size.width / 15,
                          ),
                        ),

                        Text(
                          prices,
                          style: TextStyle(
                            fontFamily: 'Anton',
                            fontSize: MediaQuery.of(context).size.width / 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Text(
                      place,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 27,
                        color: active ? AppColors.primaryColor : Colors.black
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}