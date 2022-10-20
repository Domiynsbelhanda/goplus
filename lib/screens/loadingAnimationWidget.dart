import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../utils/app_colors.dart';

class LoadingWidget extends StatefulWidget{

  String message;

  LoadingWidget({Key? key, required this.message}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoadingWidget();
  }
}

class _LoadingWidget extends State<LoadingWidget>{

  late Size size;
  late String message;
  bool _showWidget = false;

  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;
    message = widget.message;

    Future.delayed(const Duration(seconds: 15)).then((value) {
      setState(() {
        _showWidget = true;
      });
    });

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

              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top : 96.0),
                  child: message != null ?
                  Text(
                       'Veuillez patienter\n${message}',
                    textAlign: TextAlign.center
                  ) : const Text(
                    'Veuillez patienter...',
                      textAlign: TextAlign.center
                  ),
                ),
              ),

              _showWidget ? Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom : 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                          'Connection lente ...'
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'CLIQUEZ ICI',
                                style: TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 20
                                ),
                              )
                          ),

                          const Text(
                              'pour fermer et reesayez.'
                          ),
                        ]
                      ),
                    ],
                  )
                ),
              ) : const SizedBox()
            ],
          )
      ),
    );
  }
}