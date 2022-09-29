import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const double ZOOM = 20;

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

  late BitmapDescriptor markerbitmap;
  Position? myPosition;

  @override
  void initState() {
    readBitconMarker();
    readPosition();
  }

  readPosition() async{
    myPosition = await determinePosition();
  }

  readBitconMarker() async {
    markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/car_android.png",
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
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
            data.map((value) => () async{
                double latitude = value.get('latitude');
                double longitude = value.get('longitude');
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
            });

            _googleMapController?.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(myPosition!.latitude, myPosition!.longitude),
                zoom: ZOOM,
              ),
            ));

            return GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(myPosition!.latitude, myPosition!.longitude),
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