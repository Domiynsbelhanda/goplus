import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:goplus/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/pages/choose_language_screen.dart';
import 'package:goplus/gofly/utils/class_builder.dart';
import 'package:goplus/gofly/widgets/theme_data.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LocalesProviderModel(),
      )
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
        nextScreen: Dashboard(), //Dashboard(), //Dashboard(), //
        duration: 2500,
        splash: "assets/icon/white-text.png",
        backgroundColor : Color(0xFFFFD80E),
      ),
    );
  }
}
