import 'package:flutter/material.dart';
import 'package:goplus/formulaire/facilitation.dart';
import 'package:goplus/utils/datas.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/card_dashboard_item_image.dart';
import 'package:goplus/widget/logo_text.dart';
import 'package:goplus/widget/tab_item_dashboard.dart';

import 'catalogue.dart';
import 'tourisme.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard>{

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              right: 16.0,
              top: 40.0,
              child: BackButtons(context)
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                LogoText(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: dashboardFormulaire(context).map((e) => Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: CardPicture(
                          imagePath: '${e['imagePath']}',
                          title: '${e['title']}',
                          description: '${e['description']}',
                          onTap: e['onTap'],
                        ),
                      )).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}

