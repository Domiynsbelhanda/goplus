import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/screens/mapsPickLocation.dart';
import 'package:goplus/widget/app_button.dart';
import 'package:goplus/widget/logo_text.dart';
import 'package:permission_handler/permission_handler.dart';
import '../main.dart';
import '../utils/global_variable.dart';
import 'driverTrackingPage.dart';
import '../utils/app_colors.dart';

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
  bool checkairport = false;

  void requestPermission() async{
    Map<Permission, PermissionStatus> request =  await [
      Permission.location
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    selectedPlace = widget.destination;
    depart = widget.depart;


    return Scaffold(
      body: FutureBuilder<bool>(
        future: Permission.location.serviceStatus.isEnabled,
        builder: (context, snapshot) {
          if(snapshot.data!){
            return FutureBuilder<PermissionStatus>(
              future: Permission.location.status,
              builder: (context, status){
                if(!status.hasData){
                  requestPermission();
                }
                if(status.data!.isGranted){
                  return Builder(
                    builder: (context){
                      return body();
                    },
                  );
                } else{
                  requestPermission();
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Autorisé l'aplication à utiliser votre position. \nAllez dans les paramètres pour forcer l'autorisation.",
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 16.0,),

                          AppButton(
                            onTap: ()=>openAppSettings(),
                            name: "Paramètre",
                            color: AppColors.primaryColor,
                          )
                        ],
                      ),
                    ),
                  );
                }
              }
            );
          } else {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Activez la localisation puis relancer l'application pour utiliser GoPlus",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        }
      ),
    );
  }

  Widget body(){
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: position,
              zoom: zoom
          ),
          // Markers to be pointed
        ),
        SingleChildScrollView(
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
                            'Nos taxis vous y conduiront en toute sécurité et convivialité à bord.',
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
                                    builder: (BuildContext context) =>
                                        PickLocation(
                                          destination: true,
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

                      !checkairport ?
                      selectedPlace != null ?
                      Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                          child: Card(
                            elevation: 2.0,
                            child: SizedBox(
                              width: size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Destination : \n     Longitude: ${selectedPlace!.latitude} \n     Latitude : ${selectedPlace!.longitude}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                          )
                      ) : const SizedBox()
                          : Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                        child: Card(
                          elevation: 2.0,
                          child: SizedBox(
                            width: size.width,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Destination : Aeroport de NDJILI',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      selectedPlace != null || airport != null ?
                      Padding(
                          padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => PickLocation(
                                      place: checkairport ? airport : selectedPlace,
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
                        child: Card(
                          elevation: 2.0,
                          child: SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Départ : \n     Longitude :${depart!.latitude} \n     Latitude : ${depart!.longitude}',
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
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
                                    builder: (BuildContext context) => DriverTrackingPage(
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
            ],
          ),
        ),
      ],
    );
  }
}