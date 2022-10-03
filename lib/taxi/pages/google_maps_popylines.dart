
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:label_marker/label_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsPolylines extends StatefulWidget {
  LatLng origine;
  LatLng destination;
  LatLng position;
  String? id;

  GoogleMapsPolylines({Key? key, this.id, required this.origine, required this.destination, required this.position}) : super(key: key);

  @override
  _Poly createState() => _Poly();
}

class _Poly extends State<GoogleMapsPolylines> {

  GoogleMapController? _controller;
  Location _location = Location();
  CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(19.0759837, 72.8776559),
    zoom: 14,
  );
  late LatLng position;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  // list of locations to display polylines
  late List<LatLng> latLen;

  void _onMapCreated (_cntlr) async
  {
    _controller = _cntlr;
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/car_android.png",
    );

    setState(() {
      _markers.add(
          Marker( //add start location marker
            markerId: MarkerId('Ma Position'),
            position: latLen[0], //position of marker
            infoWindow: InfoWindow( //popup info
              title: 'Ma Position',
              snippet: 'Moi',
            ),
            icon: markerbitmap, //Icon for Marker
          )
      );

      position = latLen[0];
    });
  }

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
      _markers.add(
        // added markers
          Marker(
              markerId: MarkerId(i.toString()),
              position: latLen[i],
              infoWindow: InfoWindow(
                title: '${i + 1} ${i == 0 ? 'Driver' : i == 1 ? 'Lieu de ramassage' : i == 2 ? 'Destination du client' : ''}',
                snippet: '',
              )
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
            onMapCreated: _onMapCreated,
          ),
        ),
      ),
    );
  }
}