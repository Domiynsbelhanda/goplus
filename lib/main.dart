import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> Datas()),
      ChangeNotifierProvider(create: (context)=> Auth())
    ],
    child: MyApp(),
  ));
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
      home: AnimatedSplashScreen(
        nextScreen: FutureBuilder(
          future: Provider.of<Auth>(context,listen: false).getToken(),
          builder: (context, snapshot){
            if(snapshot == null){
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