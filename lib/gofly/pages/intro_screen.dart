import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/slider_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'auth/enter_phone_number_screen.dart';
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
                  .getLocalizedStrings.introScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CarouselSlider(
            items: [
              Sliders(
                image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Tour_de_l%27%C3%89changeur_de_Limete.jpg/800px-Tour_de_l%27%C3%89changeur_de_Limete.jpg',
                name: 'Echangeur de limété',
                intro: _localeText.bodyLocateDesti,
              ),
              Sliders(
                image: 'https://www.gospelmuzik.cd/sites/default/files/styles/background_la_une/public/2021-10/fikin-batteur-tam-tam-210718-800px.jpg?itok=zHFEUu64',
                name: 'Foire Internationale de Kinshasa',
                intro: _localeText.bodySelectYourRoot,
              )
            ],
            carouselController: buttonController,
            options: CarouselOptions(
                height: size.height,
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 80.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "GO+",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        fontFamily: 'Anton'
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      "Taxi",
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
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
                                    builder: (_) => PhoneNumberScreen(),
                                  ));
                            },
                            child: Container(
                              height: size.width * 0.21,
                              width: size.width * 0.21,
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
                                    builder: (_) => PhoneNumberScreen(),
                                  ));
                            },
                            child: Text(
                              "Sauter",
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
        ],
      ),
    );
  }
}
