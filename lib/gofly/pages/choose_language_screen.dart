import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:texi_booking/models/locales_provider_model.dart';
import 'package:texi_booking/pages/intro_screen.dart';
import 'package:texi_booking/utils/app_colors.dart';
import 'package:texi_booking/utils/strings.dart';
import 'package:texi_booking/widgets/app_widgets/app_loader.dart';

import '../utils/application_localizations.dart';

class ChooseALanguageScreen extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<ChooseALanguageScreen> {
  Size size;
  int selectedLanguage = 1;

  ApplicationLocalizations localization =
      ApplicationLocalizations(Locale("en"));

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<bool>(
          future: localization.loadLangs(context),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return AppLoader();
            } else {
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              else
                return Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Texi",
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: " Booking",
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Text(
                      Provider.of<LocalesProviderModel>(context, listen: false)
                          .getLocalizedStrings
                          .chooseLang,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3.0,
                              color: Colors.grey[300],
                              spreadRadius: 2)
                        ],
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguage = 0;
                                localization.changeLang(context,
                                    langCode: "hn");
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(microseconds: 500),
                              margin: EdgeInsets.all(5.0),
                              height: size.height * 0.07,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: selectedLanguage == 0
                                    ? AppColors.primaryColor
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "Hindi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguage = 1;
                                localization.changeLang(context,
                                    langCode: "en");
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              margin: EdgeInsets.all(5.0),
                              height: size.height * 0.07,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: selectedLanguage == 1
                                    ? AppColors.primaryColor
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "English",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedLanguage = 2;
                                localization.changeLang(context,
                                    langCode: "gj");
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              margin: EdgeInsets.all(5.0),
                              height: size.height * 0.07,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: selectedLanguage == 2
                                    ? AppColors.primaryColor
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(
                                  "Gujarati",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.height * 0.08,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                offset: Offset(0, 5),
                                blurRadius: 10,
                                spreadRadius: 1)
                          ]),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IntroScreen()));
                        },
                      ),
                    ),
                    Spacer(),
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: size.width,
                          child: SvgPicture.asset(
                            StringValue.SPLASH,
                            fit: BoxFit.cover,
                            height: size.height * 0.45,
                          ),
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: size.width * 0.6,
                          margin: EdgeInsets.only(bottom: size.height * 0.05),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.white.withOpacity(0.8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  offset: Offset(0, 5),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.call, size: 18),
                              Text(
                                "   +91 1234567890",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                );
            }
          }),
    );
  }
}
