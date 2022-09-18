import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplus/placeDetails.dart';
import 'package:goplus/gofly/pages/set_pickup_time_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/card_dashboard_item_image.dart';
import 'package:goplus/gofly/widgets/tab_item_dashboard.dart';
import 'package:provider/provider.dart';

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

  late DestinationModel _localeText;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .destinationScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    placeList = [
      {
        'imagePath' : 'https://s.yimg.com/uu/api/res/1.2/U1yjMObipSzabrdKnKRe5A--~B/aD01NzY7dz0xMDI0O2FwcGlkPXl0YWNoeW9u/https://media.zenfs.com/fr/rfi_475/37d66899f6929e74c54fd4ce5e51f6c1',
        'title': 'Bâtiment Hypnose',
        'description' : 'Rejoignez le grand bâtiment',
        'onTap': (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                placeList[0]
              ))
            );
        }
      },

      {
        'imagePath' : 'https://miningandbusiness.com/wp-content/uploads/2019/09/LUBUMBASHI-LA-KATANGAISE.jpg',
        'title': 'La Poste',
        'description' : 'Le milieu de la ville',
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                  placeList[1]
              ))
          );
        }
      },

      {
        'imagePath' : 'https://mapio.net/images-p/35534226.jpg',
        'title': 'Basilique Sainte Marie',
        'description' : 'La commune Kenya, le coin show.',
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                  placeList[2]
              ))
          );
        }
      },

      {
        'imagePath' : 'https://www.sunna-design.com/wp-content/uploads/2020/02/DJI_0921-logo.jpg',
        'title': 'Square Lubumbashi',
        'description' : 'Un meilleur endroit de divertissement.',
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                  placeList[3]
              ))
          );
        }
      },

      {
        'imagePath' : 'https://mnctvcongo.net/wp-content/uploads/2022/08/IMG-20220827-WA0003-780x470.jpg',
        'title': 'Commune Ruashi',
        'description' : 'Atteignez les coins réculés.',
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                  placeList[4]
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
                        _localeText.bodyWhereGoing,
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
                          hintText: _localeText.enterDestination,
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

