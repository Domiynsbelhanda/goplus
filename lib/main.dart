import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:goplus/pages/homePage.dart';
import 'package:goplus/screens/enter_phone_number_screen.dart';
import 'package:goplus/services/auth.dart';
import 'package:goplus/services/formulaireRequest.dart';
import 'package:provider/provider.dart';
import 'package:goplus/widget/theme_data.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> Datas()),
      ChangeNotifierProvider(create: (context)=> Auth())
    ],
    child: MyApp(),
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State<MyApp>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      title: "Go Plus",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', ''),
        Locale('lg', ''),
      ],
      builder: EasyLoading.init(),
      home: AnimatedSplashScreen(
        nextScreen: FutureBuilder(
          future: Provider.of<Auth>(context,listen: false).getToken(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const PhoneNumberScreen();
            } else {
              return HomePage();
            }
          }
        ),
        duration: 2500,
        splash: "assets/icon/white-text.png",
        backgroundColor : Color(0xFFFFD80E),
      ),
    );
  }
}