import 'dart:async';
import 'package:label_marker/label_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPolylines extends StatefulWidget {
  LatLng origine;
  LatLng destination;
  LatLng position;

  GoogleMapsPolylines({Key? key, required this.origine, required this.destination, required this.position}) : super(key: key);

  @override
  _Poly createState() => _Poly();
}

class _Poly extends State<GoogleMapsPolylines> {
  // created controller to display Google Maps
  Completer<GoogleMapController> _controller = Completer();
  //on below line we have set the camera position
  CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(19.0759837, 72.8776559),
    zoom: 14,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  // list of locations to display polylines
  late List<LatLng> latLen;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    latLen = [
      widget.position,
      widget.origine,
      widget.destination,
    ];

    _kGoogle = CameraPosition(
      target: widget.position,
      zoom: 14,
    );

    // declared for loop for various locations
    for(int i=0; i<latLen.length; i++){
      _markers.addLabelMarker(
        // added markers
          LabelMarker(
            label: '${i + 1} ${i == 0 ? 'Votre Position' : i == 1 ? 'Lieu de ramassage' : i == 2 ? 'Destination du client' : ''}',
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 50.0
            ),
            markerId: MarkerId(i.toString()),
            position: latLen[i],
            infoWindow: InfoWindow(
              title: 'TRAJET',
              snippet: '',
            ),
            icon: BitmapDescriptor.defaultMarker,
          )
      );
      setState(() {

      });
      _polyline.add(
          Polyline(
            polylineId: PolylineId('1'),
            points: latLen,
            color: Colors.green,
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: GoogleMap(
            initialCameraPosition: _kGoogle,
            mapType: MapType.normal,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            compassEnabled: true,
            polylines: _polyline,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}