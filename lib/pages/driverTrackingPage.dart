import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goplus/utils/app_colors.dart';
import 'package:goplus/utils/global_variable.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/bottom_type_car.dart';
import 'package:goplus/widget/progresso_dialog.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../widget/app_button.dart';
import '../widget/notification_dialog.dart';

const double ZOOM = 19;

class DriverTrackingPage extends StatefulWidget{
  LatLng origine;
  LatLng destination;
  BitmapDescriptor picto;
  List<LatLng> destinationPolylines;
  DriverTrackingPage({
    Key? key,
    required this.destination,
    required this.origine,
    required this.picto,
    required this.destinationPolylines
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DriverTrackingPage();
  }
}

class _DriverTrackingPage extends State<DriverTrackingPage>{

  Set<Marker> markers = {};
  Set<Circle> circles = {};
  String carType = "1";
  int? index;
  GoogleMapController? mapController;

  @override
  void initState() {
    data(widget.origine);
    // getMyPosition();
  }

  void data(LatLng value) async{
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(value.latitude, value.longitude),
      zoom: 13,
    );

    setState(() {
      circles = {Circle(
        strokeColor: Colors.red,
        strokeWidth: 2,
        fillColor: Colors.red.withOpacity(0.2),
        circleId: const CircleId('1'),
        center: LatLng(value.latitude, value.longitude),
        radius: 3700,
      )};
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh(widget.origine);
  }

  void refresh(target) async {
    mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: target,
                zoom: 15.0
            )
        )
    );
  }


  @override
  Widget build(BuildContext context){
    // TODO: implement build
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("drivers").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            markers.clear();
            markers.add(
                Marker(
                  markerId: const MarkerId("1"),
                  position: position,
                  infoWindow: const InfoWindow(
                    title: 'Votre Position',
                  ),
                  icon: widget.picto,
                )
            );
            for(var i = 0; i < data.length; i++){
              if(data[i].get('online')){
                if(data[i].get('cartype') == carType){
                  double latitude = data[i].get('latitude');
                  double longitude = data[i].get('longitude');
                  GeoPoint location = GeoPoint(latitude, longitude);

                  if (location == null) {
                    return Text("There was no location data");
                  }
                  final latLng = LatLng(location.latitude, location.longitude);

                  markers
                      .add(
                      Marker(
                          markerId: MarkerId(data[i].id),
                          position: latLng,
                          icon: car_android!,
                          onTap: (){
                            setState(() {
                              index = i;
                            });
                          }
                      )
                  );
                }
              }
            }

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: position,
                      zoom: ZOOM
                  ),
                  // Markers to be pointed
                  markers: markers,
                  circles: circles,
                  onMapCreated: _onMapCreated,
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
                            prices: '10\$ / Heure',
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
                            prices: '20\$ / Heure',
                            onTap: (){
                              setState(() {
                                carType = "2";
                              });
                            },
                            active: carType == "2",

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
          return const Text(
            'Changement de la carte en cours...',
          );
        },
      ),
    );
  }

  Widget showDriver(data){
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.width + 120,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: const Icon(
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
                  data.get('cartype') == "1" ?
                  'assets/images/ist.png' : data.get('cartype') == "2" ?
                  'assets/images/berline.png' : 'assets/images/van.png' ,
                  width: 120,
                  height: 60,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(width: 16.0),
                Column(
                  children: [
                    Text(
                      data.get('cartype') == "1" ?
                      'TAXI Mini' : data.get('cartype') == "2" ?
                      'Berline VIP' : 'TAXI Bus',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Anton'
                      ),
                    ),

                    Text(
                      data.get('cartype') == "1" ?
                      '4 personnes' : data.get('cartype') == "2" ?
                      '4 personnes' : '8 personnes',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        fontFamily: 'Anton',
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 8.0,),

            Text(
              "- Climatisé \n - Wi-fi à bord \n - Coffre pour 3 valises. \n - Couleur : ${data.get('colour')}",
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
                    const Text(
                      'Mama baldé',
                        // 'A ${calculateDistance(LatLng(data.get('latitude'), data.get('longitude')), position).toStringAsFixed(2)} mètre(s)',
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
              color: AppColors.primaryColor,
              name: 'RESERVER',
              onTap: (){

                showLoader("Reservation en cours...");

                var don = {
                  "key": "ride",
                  "action": "create",
                  "phone": data.id
                };

                Provider.of<Auth>(context, listen: false).request(data : don).then((sms){
                  if(sms['code'] == 'OK'){
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
                            'depart_longitude': widget.origine.longitude,
                            'depart_latitude': widget.origine.latitude,
                            'destination_longitude': widget.destination.longitude,
                            'destination_latitude': widget.destination.latitude,
                            'distance': 'Bukayo Sada', //calculateDistance(widget.depart, position).toStringAsFixed(2),
                            'user_id': value!,
                            'sid_user': val,
                            'airport': '',
                            'carType': carType
                          });
                        } else {
                        }
                      });
                    });
                  } else {
                    notification_dialog(
                        context,
                        "Ce Chauffeur Injoignable.",
                        {'label': 'FERMER', "onTap": (){
                          Navigator.pop(context);
                        }},
                        20,
                        false);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}