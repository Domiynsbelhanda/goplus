import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:goplus/pages/homePage.dart';
import 'package:goplus/screens/enter_phone_number_screen.dart';
import 'package:goplus/services/auth.dart';
import 'package:goplus/utils/class_builder.dart';
import 'package:goplus/widget/NetworkStatus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:goplus/widget/theme_data.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  ClassBuilder.registerClasses();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> Auth())
    ],
    child: const MyApp(),
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

  const MyApp({super.key});

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
      builder: EasyLoading.init(),
      home: AnimatedSplashScreen(
        nextScreen: FutureBuilder(
          future: Provider.of<Auth>(context,listen: false).getToken(),
          builder: (context, snapshot){
            return Stack(
              children: [
                !snapshot.hasData ?
                    const PhoneNumberScreen()
                    : HomePage(),

                Positioned(
                  bottom: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: FutureBuilder<bool>(
                        future: InternetConnectionChecker().hasConnection,
                        builder: (context, connected) {
                          bool visible = false;
                          if(connected.hasData){
                            visible = !(connected.data!);
                          }
                          return Visibility(
                            visible: visible,
                            child: const InternetNotAvailable(),
                          );
                        }
                    ),
                  ),
                ),
              ],
            );
          }
        ),
        duration: 2500,
        splash: "assets/icon/white-text.png",
        backgroundColor : const Color(0xFFFFD80E),
      ),
    );
  }
}