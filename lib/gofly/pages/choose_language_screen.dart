import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/pages/intro_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_loader.dart';

import '../models/locales_models.dart';
import '../utils/application_localizations.dart';

class ChooseALanguageScreen extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<ChooseALanguageScreen> {
  late Size size;
  int selectedLanguage = 1;

  @override
  void initState() {
    Provider.of<LocalesProviderModel>(context, listen: false).updateLocalizedString(
        LocaleModel(chooseLang: 'fr')
    );
  }

  ApplicationLocalizations localization =
      ApplicationLocalizations(Locale("fr"));


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
              else {
                return Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "GO+",
                            style: TextStyle(
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: " TAXI",
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
                      '${Provider.of<LocalesProviderModel>(context, listen: false)
                          .getLocalizedStrings
                          .chooseLang!}',
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
                              color: Colors.grey,
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
                                    langCode: "fr");
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
                                  "Français",
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
                                    langCode: "lg");
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
                                  "Lingala",
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
                                "   +243 999 999 999",
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
            }
          }),
    );
  }
}
