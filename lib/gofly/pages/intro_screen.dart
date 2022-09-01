import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/slider_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'auth/login_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late Size size;
  int selectedImage = 0;
  CarouselController buttonController = CarouselController();
  late IntroModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .introScreen!;
    print('Belhanda : ${_localeText}');
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 80.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Texi",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  "Booking",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          CarouselSlider(
            items: [
              Sliders(
                image: StringValue.INTRO1,
                name: _localeText.titleLocateDesti,
                intro: _localeText.bodyLocateDesti,
              ),
              Sliders(
                image: StringValue.INTRO2,
                name: _localeText.titleSelectYourRoot,
                intro: _localeText.bodySelectYourRoot,
              ),
              Sliders(
                image: StringValue.INTRO3,
                name: _localeText.titleGetYourTexi,
                intro: _localeText.bodyGetYourTexi,
              ),
            ],
            carouselController: buttonController,
            options: CarouselOptions(
                height: size.height * 0.55,
                autoPlay: false,
                scrollPhysics: ClampingScrollPhysics(),
                enableInfiniteScroll: false,
                viewportFraction: 1,
                aspectRatio: 2.0,
                reverse: false,
                onPageChanged: (index, context) {
                  setState(() {
                    selectedImage = index;
                  });
                }),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(2.0),
                height: size.height * 0.01,
                width: size.height * 0.01,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedImage == 0
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    border: selectedImage == 0
                        ? Border.all(color: AppColors.primaryColor)
                        : Border.all(color: Colors.black54)),
              ),
              Container(
                margin: EdgeInsets.all(2.0),
                height: size.height * 0.01,
                width: size.height * 0.01,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedImage == 1
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    border: selectedImage == 1
                        ? Border.all(color: AppColors.primaryColor)
                        : Border.all(color: Colors.black54)),
              ),
              Container(
                margin: EdgeInsets.all(2.0),
                height: size.height * 0.01,
                width: size.height * 0.01,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedImage == 2
                        ? AppColors.primaryColor
                        : Colors.transparent,
                    border: selectedImage == 2
                        ? Border.all(color: AppColors.primaryColor)
                        : Border.all(color: Colors.black54)),
              ),
            ],
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.all(10.0),
            height: size.height * 0.09,
            width: size.width * 0.9,
            child: selectedImage == 2
                ? Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(),
                              ));
                        },
                        child: Container(
                          height: size.width * 0.13,
                          width: size.width * 0.13,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 5))
                              ]),
                          child: Center(
                            child: Text(
                              _localeText.startBtn,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LoginScreen(),
                              ));
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.06,
                        width: size.height * 0.06,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                offset: Offset(0, 5),
                                blurRadius: 10,
                                spreadRadius: 1)
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              buttonController.nextPage(
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.bounceIn);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
