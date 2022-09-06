import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplus/gofly/utils/app_colors.dart';

import '../utils/strings.dart';
import 'choose_language_screen.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard>{

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cardDashboard('Go Taxi', StringValue.TAXI, (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChooseALanguageScreen())
            );
          }),

          cardDashboard('Go Fly', StringValue.PLANE, (){
          }),

          cardDashboard('Go Shop', StringValue.SHOPPING, (){
          })
        ],
      )
    );
  }

  Widget cardDashboard(String text, String icons, Function click){
    return GestureDetector(
      onTap: ()=> click(),
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 16.0, top: 16.0),
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.3),
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 3.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 8.0,),
                Container(
                  height: size.width / 3.5,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(
                            2.0,
                            2.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ]
                  ),
                  child: SvgPicture.asset(
                    icons,
                  ),
                ),

                Text(
                  '${text}',
                  style: TextStyle(
                    fontFamily: 'Anton',
                    color: AppColors.primaryColor,
                    fontSize: size.width / 10
                  ),
                ),

                SizedBox(width: 8.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

