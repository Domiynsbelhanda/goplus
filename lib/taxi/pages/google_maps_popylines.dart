import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../widget/backButton.dart';

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

  Completer<GoogleMapController> _controller = Completer();
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

  BitmapDescriptor? markerbitmap;

  void readBitmap() async {
    markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/car_android.png",
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readBitmap();

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
    for(int i=1; i<latLen.length; i++){
      _markers.add(
        // added markers
          Marker(
              markerId: MarkerId(i.toString()),
              position: latLen[i],
              infoWindow: InfoWindow(
                title: i == 1 ? 'Lieu de ramassage' : i == 2 ? 'Destination du client' : '',
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
        child : StreamBuilder(
            stream: FirebaseFirestore.instance.collection("drivers").doc(widget.id).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              var data = snapshot.data!.data() as Map<String, dynamic>;
              _markers.clear();
              _markers.add(
                  Marker(
                    markerId: MarkerId('DriverPosition'),
                    position: LatLng(data['latitude'], data['longitude']),
                    infoWindow: const InfoWindow(
                      title: 'Driver Position',
                      snippet: '',
                    ),
                    icon: markerbitmap!,
                  )
              );

              return Stack(
          children: [
            SafeArea(
              child : GoogleMap(
                  initialCameraPosition: _kGoogle,
                  mapType: MapType.normal,
                  markers: _markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (ctrl){
                    ctrl.animateCamera(
                        CameraUpdate.newCameraPosition(
                            CameraPosition(
                                target: LatLng(
                                  data['latitude'],
                                  data['longitude']
                                ),
                                zoom: 17)
                          //17 is new zoom level
                        )
                    );
                    _controller.complete(ctrl);
                  },
                )
            ),

            Positioned(
              right: 16,
              top: 16,
              child: CloseButtons(context),
            ),

            Positioned(
                bottom: 32,
                left: 16,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: const BoxDecoration(
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(
                            Icons.call
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Text(
                            '+243${data['phone']}'
                        ),
                      ],
                    ),
                  ),
                )
            ),
          ],
        );
            })
      ),
    );
  }
}