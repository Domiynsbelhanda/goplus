import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:texi_booking/models/locales_provider_model.dart';
import 'package:texi_booking/pages/choose_language_screen.dart';
import 'package:texi_booking/utils/class_builder.dart';
import 'package:texi_booking/widgets/theme_data.dart';

void main() async {
  ClassBuilder.registerClasses();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LocalesProviderModel(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      title: "Taxi Booking",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('fr', ''),
        Locale('gj', ''),
        Locale('hn', ''),
      ],
      home: ChooseALanguageScreen(),
    );
  }
}
