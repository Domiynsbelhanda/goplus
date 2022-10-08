import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';

class LoadingWidget extends StatelessWidget{

  late Size size;

  LoadingWidget({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,

        child : Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: AppColors.primaryColor,
                rightDotColor: AppColors.primaryColor,
                size: 30,
              ),
            ),

            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top : 96.0),
                child: Text(
                  'Veuillez patienter'
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}