import 'package:flutter/material.dart';
import 'package:goplus/formulaire/dashboard.dart';
import 'package:goplus/taxi/screens/mapsPickLocation.dart';
import 'package:goplus/widget/buildTextField.dart';
import 'package:goplus/widget/logo_text.dart';
import 'package:goplus/widget/mini_card_picture.dart';
import 'package:goplus/widget/notification_dialog.dart';

import '../utils/datas.dart';
import '../widget/card_dashboard_item_image.dart';

class HomePage extends StatefulWidget{
  var destination;
  HomePage({this.destination});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  late Size size;
  TextEditingController destinationController = TextEditingController();
  TextEditingController departController = TextEditingController();
  var selectedPlace;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    selectedPlace = widget.destination;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoText(),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Card(
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Text(
                          'Où Allez-vous?',
                          style: TextStyle(
                              fontSize: size.width / 20,
                              fontFamily: 'Anton',
                          )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                      child: Text(
                          'Nos taxis vous y conduirons en toute sécurité et convivialité à bord.',
                          style: TextStyle(
                              fontSize: size.width / 25
                          )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => PickLocation()
                              ),
                          );
                        },
                        child: Container(
                          height: size.width / 7,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2
                              )
                          ),
                          child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                        Icons.map_outlined
                                    ),
                                    SizedBox(width: 4.0,),
                                    Text(
                                      'Selectionner votre destination',
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              )
                          ),
                        ),
                      )
                    ),

                    selectedPlace != null ?
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      child: Text(
                        '${selectedPlace!.name} - ${selectedPlace!.formattedAddress}'
                      ),
                    ) : SizedBox(),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                  'GO FLY SERVICES',
                  style: TextStyle(
                      fontSize: size.width / 20,
                      fontFamily: 'Anton'
                  )
              )
            ),

            Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: dashboardFormulaire(context).map((e) => Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: MiniCardPicture(
                        imagePath: '${e['imagePath']}',
                        title: '${e['title']}',
                        description: '${e['description']}',
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dashboard()
                              )
                          );
                        },
                      ),
                    )).toList(),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}