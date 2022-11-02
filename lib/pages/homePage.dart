import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:goplus/screens/mapsPickLocation.dart';
import 'package:goplus/widget/app_button.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:toast/toast.dart';
import '../main.dart';
import '../utils/global_variable.dart';
import '../utils/app_colors.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  Set<Marker> markers = {};
  late Size size;
  String? destination;

  void requestPermission() async{
    Map<Permission, PermissionStatus> request =  await [
      Permission.location
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ToastContext().init(context);
    return Scaffold(
      body: FutureBuilder<bool>(
        future: Permission.location.serviceStatus.isEnabled,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!){
              return FutureBuilder<PermissionStatus>(
                  future: Permission.location.status,
                  builder: (context, status){
                    if(status.hasData){
                      if(status.data!.isGranted){
                        showLoader("Recherche de votre position\nVeuillez patienter...");
                        return FutureBuilder<Position>(
                          future: Geolocator.getCurrentPosition(),
                          builder: (context, location){
                            if(location.hasData){
                              disableLoader();
                              position = LatLng(location.data!.latitude, location.data!.longitude);
                              return FutureBuilder<BitmapDescriptor>(
                                future: bitmap("assets/images/pictogramme.png", 90),
                                builder: (context, pictogramme){
                                  if(pictogramme.hasData){
                                    return body(position, pictogramme.data!);
                                  } else {
                                    return Container();
                                  }
                                },
                              );
                            } else {
                              return Container();
                            }
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
                    } else {
                      requestPermission();
                      return Container();
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
          } else {
            return Container();
          }
        }
      ),
    );
  }

  Widget body(LatLng pos, BitmapDescriptor? picto){
    markers.add(
        Marker(
          markerId: const MarkerId('Ma Position'),
          position: position,
          infoWindow: const InfoWindow(
            title: 'Ma Position',
            snippet: 'Moi',
          ),
          icon: picto!,
        )
    );
    CameraPosition? cam = CameraPosition(
        target: pos,
        zoom: zoom
    );

    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: cam,
          markers: markers,
          onMapCreated: (GoogleMapController _controller){
            _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: pos,
                    zoom: zoom
                ),
              ),
            );
          },
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(48.0)
                  ),
                  child: IconButton(
                    onPressed: () {
                      logOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => const MyApp()
                          ),
                              (Route<dynamic> route) => false
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Container(
                  height: size.width / 1.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width / 15),
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                        child: Image.asset(
                          'assets/images/bonjour.png',
                          height: size.width / 9,
                          fit: BoxFit.fitWidth,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 36.0, bottom: 16.0),
                        child: Text(
                            "OU ALLEZ-VOUS?",
                            style: TextStyle(
                                fontSize: size.width / 15,
                              fontFamily: 'Anton',
                              color: Colors.white
                            )
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: GestureDetector(
                          onTap: () async {
                            var place = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: androidApiKey,
                                mode: Mode.overlay,
                                types: [],
                                strictbounds: false,
                                components: [Component(Component.country, 'cd')],
                                //google_map_webservice package
                                onError: (err){
                                  print(err);
                                }
                            );

                            if(place != null){
                              //form google_maps_webservice package
                              final plist = GoogleMapsPlaces(apiKey:androidApiKey,
                                apiHeaders: await const GoogleApiHeaders().getHeaders(),
                                //from google_api_headers package
                              );
                              String placeid = place.placeId ?? "0";
                              final detail = await plist.getDetailsByPlaceId(placeid);
                              final geometry = detail.result.geometry!;
                              final lat = geometry.location.lat;
                              final lang = geometry.location.lng;
                              var newlatlang = LatLng(lat, lang);

                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0)
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search
                                ),

                                const SizedBox(
                                  width: 8.0,
                                ),

                                Text(
                                  destination != null ? '$destination!' : "Entrez votre destination"
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                          padding: const EdgeInsets.only(left: 0, top: 16.0, right: 0, bottom: 16.0),
                          child: AppButton(
                            color: Colors.black,
                            name: 'SUIVANT',
                            onTap: (){
                              if(destination == null){
                                Toast.show('Veuillez entrée une destination', duration: Toast.lengthLong, gravity: Toast.bottom);
                                return;
                              }
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
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}