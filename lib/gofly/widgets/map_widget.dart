import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/gofly/pages/messages/chats_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class MapWidget extends StatelessWidget {

  void setPermissions() async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
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
          position: LatLng(21.215415017175165, 72.8879595194489),
          infoWindow: InfoWindow(
            title: "John Cruzz",
            snippet: " 85,W, Jockey Street Park Forest, IL 60466",
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
        target: LatLng(21.215415017175165, 72.8879595194489),
        zoom: 15,
      ),
    );
  }
}
