import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';

class LoadingWidget extends StatelessWidget{

  late Size size;


  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,

      child : Stack(
        children: [
          LoadingAnimationWidget.twistingDots(
            leftDotColor: AppColors.primaryColor,
            rightDotColor: AppColors.primaryColor,
            size: 30,
          ),

          Positioned(
            bottom: size.height / 2 - 30,
            child: Text(
              'Veuillez patienter'
            ),
          )
        ],
      )
    );
  }
}