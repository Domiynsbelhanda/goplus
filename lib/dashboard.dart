import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplus/placeDetails.dart';
import 'package:goplus/gofly/pages/set_pickup_time_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/card_dashboard_item_image.dart';
import 'package:goplus/gofly/widgets/tab_item_dashboard.dart';
import 'package:provider/provider.dart';

import 'formulaire/tourisme.dart';
import 'gofly/models/locales_models.dart';
import 'gofly/models/locales_provider_model.dart';
import 'gofly/utils/strings.dart';
import 'gofly/widgets/card_dashboard_item_seller.dart';
import 'gofly/pages/choose_language_screen.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard>{

  late Size size;

  late List itemDashboard;
  late List placeList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    placeList = [
      {
        'imagePath' : 'assets/images/tourism.jpg',
        'title': 'TOURISME',
        'subtitle': 'Voyage de rêve',
        'description' : 'Réalisez vos rêves de tourisme.',
        'status': false,
        'country' : [
          'CANADA',
          'DUBAI',
          'ESPAGNE',
          'FRANCE',
          'TURQUIE'
        ],
        'onTap': (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TourismForm(
                placeList[0]
              ))
            );
        }
      },

      {
        'imagePath' : 'assets/images/tourism.jpg',
        'title': 'ETUDE',
        'subtitle': 'Voyage de rêve',
        'description' : 'Réalisez vos rêves de tourisme.',
        'status': false,
        'country' : [
          'AFRIQUE DU SUD',
          'BIELORUSSIE',
          'CANADA'
          'CHYPRE',
          'FRANCE',
          'TUNISIE'
        ],
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TourismForm(
                  placeList[1]
              ))
          );
        }
      }
    ];

    itemDashboard = placeList;
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 32.0),
              child: Text(
                'GO PLUS',
                style: TextStyle(
                  fontSize: size.width / 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Anton'
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  TabItem(
                    size: size,
                    title: 'Nos suggestions',
                    activate: true,
                    onTap: (){
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: itemDashboard.map((e) => Padding(
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

            Container(
              width: size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Où Allez-vous?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Réjoignez votre destination grâce à nos taxis disponibles',
                        style:
                        TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      margin:
                      EdgeInsets.only(bottom: 20, top: 20, right: 20),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10)
                          ]),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Entrez votre destination ici',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SetPickupTimeScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}

