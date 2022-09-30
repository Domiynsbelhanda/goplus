import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/notification_dialog.dart';

import '../../utils/datas.dart';
import '../../widget/app_button.dart';

const double ZOOM = 19;

class DriverTrackingPage extends StatefulWidget{
  LatLng depart;
  LatLng destination;
  DriverTrackingPage({required this.depart, required this.destination});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DriverTrackingPage();
  }
}

class _DriverTrackingPage extends State<DriverTrackingPage>{

  static GoogleMapController? _googleMapController;
  Set<Marker> markers = Set();
  late BitmapDescriptor markerbitmap;
  LatLng position = LatLng(-11.6565, 27.4782);
  double? distance;

  @override
  void initState() {
    readBitconMarker();
  }

  readBitconMarker() async {
    markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/car_android.png",
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
            markers.clear();
            //Extract the location from document
            var data = snapshot.data!.docs;
            for(var i = 0; i < data.length; i++){
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
                    markerId: MarkerId("location"),
                    position: latLng,
                    icon: markerbitmap,
                    onTap: (){
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16.0),
                                  height: MediaQuery.of(context).size.width / 2.5,
                                  child: Image.network(
                                    '${data[i].get('profpic')}'
                                  ),
                                ),
                                Text(
                                    '${data[i].get('firstn')} ${data[i].get('lastn')} ${data[i].get('midn')}',
                                  style: TextStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                                Text(
                                  'A ${calculateDistance(widget.depart, latLng).toStringAsFixed(2)} mètre(s)'
                                ),

                                SizedBox(height: 16.0,),

                                AppButton(
                                  name: 'RESERVER',
                                  onTap: (){
                                    Navigator.pop(context);
                                    FirebaseFirestore.instance.collection('drivers').doc(data[i].id).update({
                                      'ride': true,
                                      'depart_longitude': widget.depart.longitude,
                                      'depart_latitude': widget.depart.latitude,
                                      'destination_longitude': widget.destination.longitude,
                                      'destination_latitude': widget.destination.latitude,
                                      'distance': calculateDistance(widget.depart, latLng).toStringAsFixed(2)
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                  )
              );

              position = latLng;
            }

            _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: position,
                zoom: ZOOM,
              ),
            ));

            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: position,
                    zoom: ZOOM
                  ),
                  // Markers to be pointed
                  markers: markers,
                  onMapCreated: (controller) {
                    _googleMapController = controller;
                  },
                ),

                Positioned(
                  right: 16,
                  top: 16,
                  child: BackButtons(context),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}