import 'package:flutter/material.dart';

import '../formulaire/facilitation.dart';
import '../formulaire/tourisme.dart';

List dashboardFormulaire(BuildContext context){
  late List placeList;

  placeList = [
    {
      'imagePath' : 'assets/images/voyage-de-reve-tourisme.png',
      'title': 'TOURISME',
      'subtitle': 'Voyage de rêve',
      'description' : 'Réalisez vos rêves de tourisme.',
      'status': false,
      'key': 'form_1',
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
      'key': 'form_2',
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
      'key': 'form_3',
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
      'key': 'form_4',
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
      'key': 'form_5',
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
      'key': 'form_6',
      'onTap': (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FacilitationForm(
                placeList[5]
            ))
        );
      }
    },

    // {
    //   'imagePath' : 'assets/images/question-pour-un-voyage.png',
    //   'title': 'QUESTIONS POUR UN VOYAGE',
    //   'subtitle': 'QUESTIONS POUR UN VOYAGE',
    //   'description' : 'Réalisez vos rêves de tourisme.',
    //   'status': false,
    //   'country' : [
    //     'ETUDE',
    //     'TOURISME'
    //   ],
    //   'format': [
    //     'AUDIO',
    //     'PDF'
    //   ],
    //   'onTap': (){
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => CatalogueForm(
    //             placeList[6]
    //         ))
    //     );
    //   }
    // },

    // {
    //   'imagePath' : 'assets/images/reservez-taxi.png',
    //   'title': 'RESERVEZ UN TAXI',
    //   'subtitle': 'RESERVEZ UN TAXI',
    //   'description' : 'Réalisez vos rêves de tourisme.',
    //   'status': false,
    //   'country' : [
    //     'ETUDE',
    //     'TOURISME'
    //   ],
    //   'format': [
    //     'AUDIO',
    //     'PDF'
    //   ],
    //   'onTap': (){
    //
    //   }
    // },
    //
    // {
    //   'imagePath' : 'assets/images/catalogue.png',
    //   'title': 'CATALOGUE',
    //   'subtitle': 'CATALOGUE',
    //   'description' : 'Réalisez vos rêves de tourisme.',
    //   'status': false,
    //   'country' : [
    //     'GOFLY ETUDE',
    //     'VOYAGE DE REVE'
    //   ],
    //   'format': [
    //     'AUDIO',
    //     'PDF'
    //   ],
    //   'onTap': (){
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(builder: (context) => CatalogueForm(
    //             placeList[7]
    //         ))
    //     );
    //   }
    // },
  ];

  return placeList;
}