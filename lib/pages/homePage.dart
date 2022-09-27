import 'package:flutter/material.dart';
import 'package:goplus/widget/logo_text.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoText(),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Où Allez-vous?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: size.width / 20
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                  'Nos taxis vous y conduirons en toute sécurité et convivialité à bord.',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: size.width / 25
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}