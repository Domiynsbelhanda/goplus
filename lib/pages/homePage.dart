import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/formulaire/dashboard.dart';
import 'package:goplus/screens/quizwebview.dart';
import 'package:goplus/taxi/screens/driver_tracker.dart';
import 'package:goplus/taxi/screens/mapsPickLocation.dart';
import 'package:goplus/widget/logo_text.dart';
import 'package:goplus/widget/mini_card_picture.dart';
import '../main.dart';
import '../screens/signup_screen.dart';
import '../utils/app_colors.dart';
import '../utils/datas.dart';

class HomePage extends StatefulWidget{
  LatLng? destination;
  LatLng? depart;
  HomePage({this.destination, this.depart});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  late Size size;
  LatLng? selectedPlace;
  LatLng? depart;
  LatLng airport = const LatLng(-4.3884214, 15.4416188);
  bool menuDepart = false;
  bool checkairport = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    selectedPlace = widget.destination;
    depart = widget.depart;


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoText(),

                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(48.0)
                  ),
                  child: IconButton(
                    onPressed: () async {
                      final storage = const FlutterSecureStorage();
                      await storage.delete(key: 'token');
                      await storage.delete(key: 'sid');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MyApp()
                          ),
                              (Route<dynamic> route) => false
                      );
                    },
                    icon: Icon(
                      Icons.logout,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Card(
                elevation: 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
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
                        setState(() {
                          menuDepart = !menuDepart;

                        });
                      },
                      child: Container(
                        height: size.width / 7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            border: Border.all(
                                color: Colors.black,
                                width: 0.5
                            )
                        ),
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: const [
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

                    menuDepart ?
                    Padding(
                      padding: const EdgeInsets.only(left: 64.0, right: 64.0, bottom: 16.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                menuDepart = !menuDepart;
                                checkairport = false;
                              });

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PickLocation(
                                          destination: true,
                                        )
                                ),
                              );
                            },
                            child: Container(
                              height: size.width / 8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 0.5
                                  )
                              ),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(
                                            Icons.map_outlined
                                        ),
                                        SizedBox(width: 4.0,),
                                        Text(
                                          'Choisir sur la carte',
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ),

                          const SizedBox(height: 8.0),

                          GestureDetector(
                            onTap: (){
                              setState(() {
                                menuDepart = !menuDepart;
                                checkairport = true;
                              });
                            },
                            child: Container(
                              height: size.width / 7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(48),
                                  border: Border.all(
                                      color: Colors.black,
                                      width: 0.5
                                  )
                              ),
                              child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: const [
                                        Icon(
                                            Icons.map_outlined
                                        ),
                                        SizedBox(width: 4.0,),
                                        Text(
                                          'Aéroport de N\'djili',
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ) : const SizedBox(),

                    !checkairport ?
                    selectedPlace != null ?
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      child: Text(
                        '${selectedPlace!.latitude} - ${selectedPlace!.longitude}',
                        style: const TextStyle(
                          fontSize: 12
                        ),
                      ),
                    ) : const SizedBox()
                        : const Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      child: Text(
                        'Aeroport de NDJILI',
                        style: TextStyle(
                            fontSize: 12
                        ),
                      ),
                    ),

                    selectedPlace != null ?
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => PickLocation(
                                    place: selectedPlace,
                                    destination: false,
                                  )
                              ),
                            );
                          },
                          child: Container(
                            height: size.width / 7,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(48),
                                border: Border.all(
                                    color: Colors.black,
                                    width: 0.5
                                )
                            ),
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: const [
                                      Icon(
                                          Icons.map_rounded
                                      ),
                                      SizedBox(width: 4.0,),
                                      Text(
                                        'Selectionner lieu de départ',
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        )
                    )
                        : const SizedBox(),

                    depart != null ?
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                      child: Text(
                        '${depart!.latitude} - ${depart!.longitude}',
                        style: const TextStyle(
                            fontSize: 12
                        ),
                      ),
                    ) : const SizedBox(),


                    selectedPlace != null && depart != null ?
                    Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => DriverTracker(
                                    depart: depart!,
                                    destination: checkairport ? airport : selectedPlace!,
                                    airport: checkairport,
                                  )
                              ),
                            );
                          },
                          child: Container(
                            height: size.width / 7,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(48),
                                border: Border.all(
                                    color: Colors.black,
                                    width: 0.5
                                )
                            ),
                            child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'TROUVEZ UN TAXI',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: 'Anton',
                                          color: Colors.white,
                                          fontSize: 24
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        )
                    )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 36.0
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Text(
                      'Tous les services du',
                      style: TextStyle(
                          fontSize: size.width / 20
                      )
                  ),
                  Text(
                      ' GO FLY SERVICES',
                      style: TextStyle(
                          fontSize: size.width / 20,
                          fontFamily: 'Anton'
                      )
                  ),
                ],
              )
            ),

            Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: dashboardFormulaire(context).map((e) => Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: MiniCardPicture(
                        imagePath: '${e['mini_imagePath']}',
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

            Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 16.0),
                child: Row(
                  children: [
                    Text(
                        'Offres sur mesures',
                        style: TextStyle(
                            fontSize: size.width / 20
                        )
                    )
                  ],
                )
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MiniCardPicture(
                      imagePath: 'assets/images/driver.png',
                      title: 'Devenir chauffeur',
                      description: 'Voulez-vous devenir chauffeur?',
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()
                            )
                        );
                      },
                    ),

                    const SizedBox(width: 16.0),

                    MiniCardPicture(
                      imagePath: 'assets/images/aeroport.png',
                      title: 'VOYAGE VERS L\'AEROPORT',
                      description: '',
                      onTap: (){
                        setState(() {
                          menuDepart = !menuDepart;
                          checkairport = true;
                        });
                      },
                    ),

                    const SizedBox(width: 16.0),

                    MiniCardPicture(
                      imagePath: 'assets/images/qcm.png',
                      title: 'GO FLY QUIZ',
                      description: 'Jouez et essayez de gagner',
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuizWebView()
                            )
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}