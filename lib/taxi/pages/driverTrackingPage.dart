import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goplus/widget/notification_dialog.dart';

import '../../utils/datas.dart';

const double ZOOM = 20;

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
        stream: FirebaseFirestore.instance.collection("location").snapshots(),
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
                  )
              );

              _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: latLng,
                  zoom: ZOOM,
                ),
              ));
            }

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(-11.6565, 27.4782),
                zoom: ZOOM
              ),
              // Markers to be pointed
              markers: markers,
              onMapCreated: (controller) {
                _googleMapController = controller;
              },
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