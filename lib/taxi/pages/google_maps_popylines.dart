import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/screens/loadingAnimationWidget.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/datas.dart';
import '../../widget/app_button.dart';
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

              if(!snapshot.hasData){
                return LoadingWidget(message: "Chargement en cours...");
              }

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

              return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('drivers')
                        .doc(widget.id).collection('courses').doc('courses').snapshots(),
                    builder:
                    (BuildContext context, AsyncSnapshot<DocumentSnapshot> courses) {

                      var donnees = courses.data!.data() as Map<String, dynamic>;

                      print('$donnees');
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
                              bottom: 0,
                              right: 16,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: showDriver(data, donnees)
                              )
                          ),
                        ],
                      );
                    }
              );
            })
      ),
    );
  }

  Widget showDriver(data, datas){
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.width / 1.7,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  data['cartype'] == "1" ?
                  'assets/images/ist.png' : data['cartype'] == "2" ?
                  'assets/images/berline.png' : 'assets/images/van.png' ,
                  width: 120,
                  height: 60,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data['firstn']} ${data['midn']}',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anton'
                      ),
                    ),

                    Text(
                      'est à ${calculateDistance(LatLng(data['latitude'], data['longitude']), LatLng(datas['destination_latitude'], datas['destination_longitude'])).toStringAsFixed(2)} M',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width / 25
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8.0,),

            Text(
              "- Couleur : ${data['colour']} \n- Plaque : ${data['carplate']}",
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4.0,),

            AppButton(
              name: 'APPELER ',
              onTap: ()=>_makePhoneCall('+243${data['phone']}'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}