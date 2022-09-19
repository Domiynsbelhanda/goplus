import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplus/formulaire/facilitation.dart';
import 'package:goplus/placeDetails.dart';
import 'package:goplus/gofly/pages/set_pickup_time_screen.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/card_dashboard_item_image.dart';
import 'package:goplus/gofly/widgets/tab_item_dashboard.dart';
import 'package:provider/provider.dart';

import 'formulaire/catalogue.dart';
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
        'imagePath' : 'assets/images/voyage-de-reve-etude.png',
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
        'imagePath' : 'assets/images/voyage-de-reve-etude.png',
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
      },

      {
        'imagePath' : 'assets/images/credit-voyage-etude.png',
        'title': 'ETUDE',
        'subtitle': 'Crédit Voyage',
        'description' : 'Réalisez vos rêves de tourisme.',
        'status': false,
        'country' : [
          'BIELORUSSIE',
          'CANADA',
          'CHYPRE',
          'DUBAI',
          'FRANCE',
          'TUNISIE'
        ],
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TourismForm(
                  placeList[2]
              ))
          );
        }
      },

      {
        'imagePath' : 'assets/images/credit-voyage-tourisme.png',
        'title': 'TOURISME',
        'subtitle': 'Crédit Voyage',
        'description' : 'Réalisez vos rêves de tourisme.',
        'status': false,
        'country' : [
          'DUBAI',
          'CANADA'
        ],
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TourismForm(
                  placeList[3]
              ))
          );
        }
      },

      {
        'imagePath' : 'assets/images/bourse-etude.png',
        'title': 'BOURSE D\'ETUDE',
        'subtitle': 'BOURSE D\'ETUDE',
        'description' : 'Réalisez vos rêves de tourisme.',
        'status': false,
        'country' : [
          'BIELORUSSIE',
          'CANADA',
          'CHYPRE',
          'ESPAGNE',
          'TUNISIE'
        ],
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TourismForm(
                  placeList[4]
              ))
          );
        }
      },

      {
        'imagePath' : 'assets/images/facilitation-visa.png',
        'title': 'FACILITATION VISA',
        'subtitle': 'FACILITATION VISA',
        'description' : 'Obtenez votre visa ...',
        'status': false,
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FacilitationForm(
                  placeList[5]
              ))
          );
        }
      },

      {
        'imagePath' : 'assets/images/question-pour-un-voyage.png',
        'title': 'QUESTIONS POUR UN VOYAGE',
        'subtitle': 'QUESTIONS POUR UN VOYAGE',
        'description' : 'Réalisez vos rêves de tourisme.',
        'status': false,
        'country' : [
          'ETUDE',
          'TOURISME'
        ],
        'format': [
          'AUDIO',
          'PDF'
        ],
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CatalogueForm(
                  placeList[6]
              ))
          );
        }
      },

      {
        'imagePath' : 'assets/images/reservez-taxi.png',
        'title': 'RESERVEZ UN TAXI',
        'subtitle': 'RESERVEZ UN TAXI',
        'description' : 'Réalisez vos rêves de tourisme.',
        'status': false,
        'country' : [
          'ETUDE',
          'TOURISME'
        ],
        'format': [
          'AUDIO',
          'PDF'
        ],
        'onTap': (){

        }
      },

      {
        'imagePath' : 'assets/images/catalogue.png',
        'title': 'CATALOGUE',
        'subtitle': 'CATALOGUE',
        'description' : 'Réalisez vos rêves de tourisme.',
        'status': false,
        'country' : [
          'ETUDE',
          'TOURISME'
        ],
        'format': [
          'AUDIO',
          'PDF'
        ],
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CatalogueForm(
                  placeList[5]
              ))
          );
        }
      },
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
          ],
        ),
      )
    );
  }
}

