import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/gofly/pages/messages/chats_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapWidget extends StatelessWidget {

  void setPermissions() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location
    ].request();
  }

  late LatLng currentLatLng;

  @override
  initState(){
    Geolocator.getCurrentPosition().then((currLocation){
      currentLatLng = new LatLng(currLocation.latitude, currLocation.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    setPermissions();
    return Container(child: mapView(context));
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
}
