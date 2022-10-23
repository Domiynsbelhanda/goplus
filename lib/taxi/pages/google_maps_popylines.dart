import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/screens/loadingAnimationWidget.dart';
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
                    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snap) {

                      var datas = snap.data!.data() as Map<String, dynamic>;
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
                                  child: showDriver(datas)
                                ),
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

  Widget showDriver(data){
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.width + 120,
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
                  data.get('cartype') == "1" ?
                  'assets/images/ist.png' : data.get('cartype') == "2" ?
                  'assets/images/berline.png' : 'assets/images/van.png' ,
                  width: 120,
                  height: 60,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(width: 16.0),
                Column(
                  children: [
                    Text(
                      data.get('cartype') == "1" ?
                      'TAXI Mini' : data.get('cartype') == "2" ?
                      'Berline VIP' : 'TAXI Bus',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Anton'
                      ),
                    ),

                    Text(
                      data.get('cartype') == "1" ?
                      '4 personnes' : data.get('cartype') == "2" ?
                      '4 personnes' : '8 personnes',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Anton',
                      ),
                    ),

                    data.get('airport') ?
                    Text(
                      data.get('cartype') == "1" ?
                      '40\$' : data.get('cartype') == "2" ?
                      '55\$' : '95\$',
                      overflow: TextOverflow.ellipsis,
                    )
                        :Text(
                      data.get('cartype') == "1" ?
                      '10\$ / 30 Min' : data.get('cartype') == "2" ?
                      '12\$ / 30 Min' : '14\$ / 30 Min',
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ],
            ),

            SizedBox(height: 8.0,),

            Text(
              "- Climatisé \n - Wi-fi à bord \n - Coffre pour 3 valises. \n - Couleur : ${data.get('colour')}",
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4.0,),

            const Divider(
              height: 8.0,
            ),

            const SizedBox(height: 4.0,),

            const Text(
              "DETAILS DU CHAUFFEUR",
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 8.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/taxigo-e3fcc.appspot.com/o/profile.jpg?alt=media&token=609b45f5-2f3c-4edb-b5f4-c041b9eb0457',
                        ),
                        fit: BoxFit.fitWidth,
                      )
                  ),
                ),

                const SizedBox(
                  width: 8.0,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.get('firstn')} ${data.get('midn')}',
                      style: const TextStyle(
                          fontSize: 16.0
                      ),
                    ),

                    GestureDetector(
                      onTap: (){},
                      child: Row(
                        children: [
                          const Icon(
                            Icons.whatsapp,
                            color: Colors.green,
                          ),

                          const SizedBox(
                            width: 4.0,
                          ),

                          Text(
                            '+243${data.get('phone')}',
                            style: const TextStyle(
                                fontSize: 14.0
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}