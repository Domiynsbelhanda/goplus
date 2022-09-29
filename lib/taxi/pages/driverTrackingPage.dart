import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const double ZOOM = 1;

class DriverTrackingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DriverTrackingPage();
  }
}

class _DriverTrackingPage extends State<DriverTrackingPage>{

  static GoogleMapController? _googleMapController;
  Set<Marker> markers = Set();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("location").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            //Extract the location from document
            double latitude = snapshot.data!.docs.first.get('latitude');
            double longitude = snapshot.data!.docs.first.get('longitude');
            GeoPoint location = GeoPoint(latitude, longitude);

            // Check if location is valid
            if (location == null) {
              return Text("There was no location data");
            }

            // Remove any existing markers
            markers.clear();

            final latLng = LatLng(location.latitude, location.longitude);

            // Add new marker with markerId.
            markers
                .add(Marker(markerId: MarkerId("location"), position: latLng));

            // If google map is already created then update camera position with animation
            _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: latLng,
                zoom: ZOOM,
              ),
            ));

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(location.latitude, location.longitude)),
              // Markers to be pointed
              markers: markers,
              onMapCreated: (controller) {
                // Assign the controller value to use it later
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