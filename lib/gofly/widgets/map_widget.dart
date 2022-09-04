import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/gofly/pages/messages/chats_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapWidget();
  }
}

class _MapWidget extends State<MapWidget> {

  void setPermissions() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location
    ].request();
  }

  void getPosition(){
    Geolocator.getCurrentPosition().then((currLocation){
      setState(() {
        currentLatLng = LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
  }

  late LatLng currentLatLng;

  @override
  initState(){
    getPosition();
  }

  Widget mapView(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      mapType: MapType.terrain,
      markers: {
        Marker(
          markerId: MarkerId("1"),
          position: currentLatLng,
          infoWindow: InfoWindow(
            title: "Ma Position",
            snippet: "",
            anchor: Offset(45, 45),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Chats()),
            ),
          ),
          icon: BitmapDescriptor.defaultMarker,
        ),
      },
      initialCameraPosition: CameraPosition(
        target: currentLatLng,
        zoom: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setPermissions();
    return Container(child: mapView(context));
  }
}
