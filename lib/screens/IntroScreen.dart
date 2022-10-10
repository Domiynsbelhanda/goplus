import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../pages/homePage.dart';
import '../services/auth.dart';
import '../utils/app_colors.dart';
import '../widget/slider_widget.dart';
import 'enter_phone_number_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late Size size;
  int selectedImage = 0;
  CarouselController buttonController = CarouselController();

  @override
  void initState() {
    super.initState();
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
                image: 'assets/images/echangeur.jpg',
                name: 'Echangeur de limété',
                intro: 'Réjoignez les meilleures places de Kinshasa.',
              ),
              Sliders(
                image: 'assets/images/fikin.jpg',
                name: 'Foire Internationale de Kinshasa',
                intro: 'Meilleure application pour vos déplacements.',
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
                child: selectedImage == 1
                    ? Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Provider.of<Auth>(context,listen: false).getToken()
                                .then((value){
                                if(value == null){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                        const PhoneNumberScreen(),
                                      )
                                  );
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                        HomePage(),
                                      )
                                  );
                                }
                              });
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
                                        offset: const Offset(0, 5))
                                  ]),
                              child: const Center(
                                child: Text(
                                  'Lancer',
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
                              Provider.of<Auth>(context,listen: false).getToken()
                                  .then((value){
                                if(value == null){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                        const PhoneNumberScreen(),
                                      )
                                  );
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            HomePage(),
                                      )
                                  );
                                }
                              });
                            },
                            child: Text(
                              "Ignorer",
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
