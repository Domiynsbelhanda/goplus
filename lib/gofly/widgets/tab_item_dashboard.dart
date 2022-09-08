import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TabItem extends StatelessWidget{

  TabItem({required this.size, required this.title, required this.activate, required this.onTap});

  final Size size;
  final String title;
  final bool activate;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: ()=>onTap(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${title}',
            style: activate ? TextStyle(
                fontSize: size.width / 25,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold
            ) : TextStyle(
              fontSize: size.width / 25,
              color: Colors.grey
            ),
          ),
          activate ? Container(
            height: 4,
            width: size.width / 15,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(2.0)
            ),
          ) : SizedBox()
        ],
      ),
    );
  }
}