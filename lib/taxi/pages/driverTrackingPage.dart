import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goplus/pages/homePage.dart';
import 'package:goplus/screens/loadingAnimationWidget.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/bottom_type_car.dart';
import 'package:goplus/widget/notification_loader.dart';
import 'package:goplus/widget/progresso_dialog.dart';
import 'package:goplus/widget/show_loader.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../utils/datas.dart';
import '../../widget/app_button.dart';

const double ZOOM = 13;

class DriverTrackingPage extends StatefulWidget{
  LatLng depart;
  LatLng destination;
  bool airport;
  DriverTrackingPage({Key? key, required this.depart, required this.destination, required this.airport}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DriverTrackingPage();
  }
}

class _DriverTrackingPage extends State<DriverTrackingPage>{

  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kPosition = CameraPosition(
    target: LatLng(-11.6565, 27.4782),
    zoom: 14.4746,
  );
  Set<Marker> markers = Set();
  Set<Circle> circles = Set();
  late BitmapDescriptor markerbitmap;
  late BitmapDescriptor pinner;
  LatLng? position;
  double? distance;
  int? index;
  String carType = "1";

  @override
  void initState() {
    readBitconMarker();
    readBitconMarkerPinner();
  }

  void data(LatLng value) async{
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(value.latitude, value.longitude),
      zoom: ZOOM,
    );



    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {
      circles = {Circle(
        strokeColor: Colors.red,
        strokeWidth: 2,
        fillColor: Colors.red.withOpacity(0.2),
        circleId: CircleId('1'),
        center: LatLng(value.latitude, value.longitude),
        radius: 3700,
      )};

      markers.add(
          Marker(
            markerId: const MarkerId("1"),
            position: LatLng(value.latitude, value.longitude),
            infoWindow: const InfoWindow(
              title: 'Votre Position',
            ),
            icon: pinner,
          )
      );
    });
  }

  readBitconMarker() async {
    markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/car_android.png",
    );
  }

  readBitconMarkerPinner() async {
    pinner = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(

      ),
      "assets/icon/pinner.png",
    );
  }


  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return FutureBuilder<Position>(
      future: getUserCurrentLocation(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          showLoader('Chargement de votre position\nVeuillez patienter...');
          Future.delayed(const Duration(seconds: 30)).then((value) {
            EasyLoading.dismiss();
            showLoader("Chargement de votre position\nChargement lente... \nVérifiez si votre localisation est activée et recommencer");
            Future.delayed(const Duration(seconds: 15)).then((value) {
              EasyLoading.dismiss();
              Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context)=>HomePage()),
                      (route) => false
              );
            });
          });
          return SafeArea(child: Container());
        }

        position = LatLng(snapshot.data!.latitude, snapshot.data!.longitude);

        data(position!);

        EasyLoading.dismiss();

        return SafeArea(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("drivers").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs;
                  markers.clear();
                  for(var i = 0; i < data.length; i++){
                    if(data[i].get('online')){
                      if(data[i].get('cartype') == carType){
                        double latitude = data[i].get('latitude');
                        double longitude = data[i].get('longitude');
                        GeoPoint location = GeoPoint(latitude, longitude);

                        // Check if location is valid
                        if (location == null) {
                          return Text("There was no location data");
                        }
                        final latLng = LatLng(location.latitude, location.longitude);

                        // Add new marker with markerId.
                        markers
                            .add(
                            Marker(
                                markerId: MarkerId(data[i].id),
                                position: latLng,
                                icon: markerbitmap,
                                onTap: (){
                                  setState(() {
                                    index = i;
                                  });
                                }
                            )
                        );
                      }
                    } else {
                      markers.add(
                          Marker(
                            markerId: MarkerId("1"),
                            position: position!,
                            infoWindow: InfoWindow(
                              title: 'Votre Position',
                            ),
                            icon: pinner,
                          )
                      );
                    }
                  }

                  return Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: position!,
                          zoom: ZOOM
                        ),
                        // Markers to be pointed
                        markers: markers,
                        circles: circles,
                        onMapCreated: (GoogleMapController controller){
                          _controller.complete(controller);
                        },
                      ),

                      Positioned(
                        right: 16,
                        top: 16,
                        child: BackButtons(context),
                      ),

                      Positioned(
                        bottom: 16,
                        left: 16.0,
                        right: 58.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                BottomTypeCar(
                                  image: 'assets/images/ist.png',
                                  type: 'TAXI Mini',
                                  place: '4 personnes',
                                  prices: widget.airport ? '40\$' : '10\$ / 30 Min',
                                  onTap: (){
                                    setState(() {
                                      carType = "1";
                                    });
                                  },
                                  active: carType == "1",
                                ),

                                const SizedBox(
                                  width: 16.0,
                                ),

                                BottomTypeCar(
                                  image: 'assets/images/berline.png',
                                  type: 'Berline VIP',
                                  place: '4 personnes',
                                  prices: widget.airport ? '55\$' : '12\$ / 30 Min',
                                  onTap: (){
                                    setState(() {
                                      carType = "2";
                                    });
                                  },
                                  active: carType == "2",

                                ),

                                const SizedBox(
                                  width: 16.0,
                                ),

                                BottomTypeCar(
                                  image: 'assets/images/van.png',
                                  type: 'Taxi Bus',
                                  place: '8 personnes',
                                  prices: widget.airport ? '95\$' : '14\$ / 30 Min',
                                  onTap: (){
                                    setState(() {
                                      carType = "3";
                                    });
                                  },
                                  active: carType == "3",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      index != null ?
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                            child: showDriver(data[index!])
                        ),
                      ) : const SizedBox(),
                    ],
                  );
                }
                return LoadingWidget(
                  message: 'Changement de la carte en cours...',
                );
              },
            ),
          );
      }
    );
  }

  Widget showDriver(data){
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.width + 66,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
              onTap: (){
                setState(() {
                  index = null;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/ist.png',
                  width: 120,
                  height: 60,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(width: 16.0),
                Column(
                  children: const [
                    Text(
                      "TAXI Mini",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Anton'
                      ),
                    ),

                    Text(
                      "4 personnes",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                        fontFamily: 'Anton',
                      ),
                    ),

                    Text(
                      "5\$/h",
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ],
            ),

            SizedBox(height: 8.0,),

            const Text(
              "- Climatisé \n - Wi-fi à bord \n - Coffre pour 3 valises.",
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4.0,),

            const Divider(
              height: 8.0,
            ),

            const SizedBox(height: 4.0,),

            const Text(
              "DETAILS DU CHAUFFEUR",
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/taxigo-e3fcc.appspot.com/o/profile.jpg?alt=media&token=609b45f5-2f3c-4edb-b5f4-c041b9eb0457',
                      ),
                      fit: BoxFit.fitWidth,
                    )
                  ),
                ),

                const SizedBox(
                  width: 8.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.get('firstn')} ${data.get('midn')}',
                      style: const TextStyle(
                          fontSize: 16.0
                      ),
                    ),
                    const SizedBox(height: 8.0,),
                    Text(
                        'A ${calculateDistance(LatLng(data.get('latitude'), data.get('longitude')), position!).toStringAsFixed(2)} mètre(s)',
                      style: const TextStyle(
                        fontSize: 14.0
                      ),
                    ),

                    GestureDetector(
                      onTap: (){},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.whatsapp,
                            color: Colors.green,
                          ),

                          const SizedBox(
                            width: 4.0,
                          ),

                          Text(
                              '+243${data.get('phone')}',
                            style: const TextStyle(
                              fontSize: 14.0
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),


            const SizedBox(height: 16.0,),

            AppButton(
              name: 'RESERVER',
              onTap: (){
                notification_loader(context, "Reservation en cours", (){});

                Provider.of<Auth>(context, listen: false).getToken().then((value){
                  Provider.of<Auth>(context, listen: false).getSid().then((val){
                    if(val != null){
                      Navigator.pop(context);
                      progresso_dialog(context, data.id, LatLng(data.get('latitude'), data.get('longitude')));
                      setState(() {
                        index = null;
                      });
                      FirebaseFirestore.instance.collection('drivers').doc(data.id).update({
                        'online': false,
                        'ride': true,
                        'ride_view': false,
                      });
                      FirebaseFirestore.instance.collection('drivers').doc(data.id).collection('courses')
                          .doc('courses')
                          .set({
                        'status': 'pending',
                        'depart_longitude': widget.depart.longitude,
                        'depart_latitude': widget.depart.latitude,
                        'destination_longitude': widget.destination.longitude,
                        'destination_latitude': widget.destination.latitude,
                        'distance': calculateDistance(widget.depart, position!).toStringAsFixed(2),
                        'user_id': value!,
                        'sid_user': val,
                        'airport': widget.airport,
                        'carType': carType
                      });
                    } else {

                    }
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}