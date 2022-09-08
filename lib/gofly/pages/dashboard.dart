import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:goplus/gofly/pages/placeDetails.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/card_dashboard_item_image.dart';
import 'package:goplus/gofly/widgets/tab_item_dashboard.dart';

import '../utils/strings.dart';
import '../widgets/card_dashboard_item_seller.dart';
import 'choose_language_screen.dart';

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
  late List townList;
  late List itemSeller;

  int tabActive = 0;

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

    townList = [
      {
        'imagePath' : 'https://tourisme.gouv.cd/wp-content/uploads/2020/01/lubumbashi2.jpg',
        'title': 'Lubumbashi',
        'description' : 'La ville cuprifère.',
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                  townList[0]
              ))
          );
        }
      },

      {
        'imagePath' : 'https://img.20mn.fr/OUwnBcNCQ669K-HCXsa3rw/830x532_bruxelles_une_cite_a_taille_humaine0',
        'title': 'Bruxelles',
        'description' : 'Le centre de l\'europe.',
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                  townList[1]
              ))
          );
        }
      },

      {
        'imagePath' : 'https://hotel-leon-kinshasa.com/wp-content/uploads/2022/01/istockphoto-497156586-612x612-1.jpg',
        'title': 'Kinshasa',
        'description' : 'La capitale de la rumba et culture africaine.',
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                  townList[2]
              ))
          );
        }
      },

      {
        'imagePath' : 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0f/a6/9f/24/mosque.jpg?w=700&h=500&s=1',
        'title': 'Dakar',
        'description' : 'L\'Authenticité africaine.',
        'onTap': (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlaceDetailScreen(
                  townList[3]
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
                  townList[4]
              ))
          );
        }
      }];

    itemSeller = [
    {
    'imagePath' : 'https://zoom-eco.net/wp-content/uploads/2019/12/IMG_20191214_092058.jpg',
    'title': 'Congo Airways',
    'onTap': ()=>print('belhanda')
    },

    {
    'imagePath' : 'https://cdn.uc.assets.prezly.com/83477061-4765-40db-97df-dc2cbd6c30da/-/resize/1108x/-/quality/best/-/format/auto/',
    'title': 'Bruxelles Airlines',
    'onTap': ()=>print('belhanda')
    },

    {
    'imagePath' : 'https://newsaero.info/news/admin/assets/image/actualite/actualite3618.jpg',
    'title': 'SA Airlines',
    'onTap': ()=>print('belhanda')
    },

    {
    'imagePath' : 'https://www.tourmag.com/photo/art/default/53441096-40459454.jpg?v=1611779069',
    'title': 'Ethipian Airways',
    'onTap': ()=>print('belhanda')
    },

    {
    'imagePath' : 'https://www.financialafrik.com/wp-content/uploads/2020/09/kenya-airways-600x311.jpg',
    'title': 'Kenya Airways',
    'onTap': ()=>print('belhanda')
    }
    ];

    itemDashboard = tabActive == 0 ? placeList : townList;
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
              child: Text(
                'Discover',
                style: TextStyle(
                  fontSize: size.width / 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  TabItem(
                    size: size,
                    title: 'Best Place',
                    activate: tabActive == 0 ? true : false,
                    onTap: (){
                      setState(() {
                        if(tabActive == 1){
                          tabActive = 0;
                        }
                      });
                    },
                  ),

                  SizedBox(width: 16.0,),
                  TabItem(
                    size: size,
                    title: 'Best Destination',
                    activate: tabActive == 1 ? true : false,
                    onTap: (){
                      setState(() {
                        if(tabActive == 0){
                          tabActive = 1;
                        }
                      });
                    },
                  ),
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                cardDashboard('Besoin d\'un Taxi?', StringValue.TAXI, (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseALanguageScreen())
                  );
                }),

                cardDashboard('Besoin d\'un Billet?', StringValue.PLANE, (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseALanguageScreen())
                  );
                }),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Best Seller',
                style: TextStyle(
                    fontSize: size.width / 15,
                    fontWeight: FontWeight.w500
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: itemSeller.map((e) => Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: CardPictureSeller(
                      imagePath: '${e['imagePath']}',
                      title: '${e['title']}',
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

  Widget cardDashboard(String text, String icons, Function click){
    return GestureDetector(
      onTap: ()=> click(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: size.width / 2.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(
                  1.0,
                  1.0,
                ),
                blurRadius: 3.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ]
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size.width / 3.5,
                  width: size.width / 3,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(
                            2.0,
                            2.0,
                          ),
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ),
                      ]
                  ),
                  child: SvgPicture.asset(
                    icons,
                  ),
                ),

                SizedBox(height: 16.0,),

                Text(
                  '${text}',
                  style: TextStyle(
                    fontFamily: 'Anton',
                    color: Colors.grey,
                    fontSize: size.width / 20
                  ),
                ),

                SizedBox(width: 8.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

