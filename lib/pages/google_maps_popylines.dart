import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/utils/app_colors.dart';
import 'package:location/location.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/global_variable.dart';
import 'homePage.dart';
import '../widget/app_button.dart';

class GoogleMapsPolylines extends StatefulWidget {
  String uuid;

  GoogleMapsPolylines({Key? key, required this.uuid}) : super(key: key);

  @override
  _Poly createState() => _Poly();
}

class _Poly extends State<GoogleMapsPolylines> {

  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  CameraPosition? cam;
  late Size size;

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("Trajet une");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }

  addPoly(LatLng origine, LatLng destination) async{
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        androidApiKey,
        PointLatLng(origine.latitude, origine.longitude),
        PointLatLng(destination.latitude, destination.longitude)
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {
        addPolyLine(polylineCoordinates);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ToastContext().init(context);
    readBitconMarkerPinner();
    return Scaffold(
      body: Container(
        child : StreamBuilder(
            stream: FirebaseFirestore.instance.collection("courses").doc(widget.uuid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

              if(!snapshot.hasData){
                return Text("Chargement en cours...");
              }

              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

              markers.add(
                  Marker(
                    markerId: const MarkerId('Depart'),
                    position: LatLng(data['depart_latitude'], data['depart_longitude']),
                    infoWindow: const InfoWindow(
                      title: 'Depart',
                      snippet: 'Moi',
                    ),
                    icon: departBitmap!,
                  )
              );

              markers.add(
                  Marker(
                    markerId: const MarkerId('Arrivée'),
                    position: LatLng(data['destination_latitude'], data['destination_longitude']),
                    infoWindow: const InfoWindow(
                      title: 'Arrivée',
                      snippet: 'Moi',
                    ),
                    icon: arriveBitmap!,
                  )
              );

              markers.add(
                  Marker(
                    markerId: const MarkerId('Driver'),
                    position: LatLng(data['driver_latitude'], data['driver_longitude']),
                    infoWindow: const InfoWindow(
                      title: 'Driver',
                      snippet: 'Moi',
                    ),
                    icon: car_android!,
                  )
              );

              cam = CameraPosition(
                  target: LatLng(data['driver_latitude'], data['driver_longitude']),
                  zoom: zoom
              );

              addPoly(
                  LatLng(data['driver_latitude'], data['driver_longitude']),
                  LatLng(data['origine_latitude'], data['origine_longitude'])
              );

              return Stack(
                children: [
                  SafeArea(
                      child : GoogleMap(
                        zoomGesturesEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: cam!,
                        markers: markers,
                        polylines: Set<Polyline>.of(polylines.values),
                        compassEnabled: true,
                        onMapCreated: (ctrl){
                          ctrl.animateCamera(
                              CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: LatLng(data['driver_latitude'], data['driver_longitude']),
                                      zoom: 17)
                                //17 is new zoom level
                              )
                          );
                        },
                      )
                  ),

                  Positioned(
                      bottom: 0,
                      right: 16,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: data['status'] == 'end'
                              ? showCourse(data)
                              : showDriver(data)
                      )
                  ),
                ],
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
        height: MediaQuery.of(context).size.width / 2,
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
                  data['carType'] == "1" ?
                  'assets/images/ist.png' : data['carType'] == "2" ?
                  'assets/images/berline.png' : 'assets/images/van.png' ,
                  width: 120.0,
                  height: 60.0,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Text(
                polylineCoordinates.length != 0 ? 'est à ${distanceDeuxPoint(polylineCoordinates)}' : "",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width / 25
              ),
            ),

            const SizedBox(height: 16.0,),

            AppButton(
              color: AppColors.primaryColor,
              name: 'APPELER ',
              onTap: ()=>makePhoneCall('+243${data['phone']}'),
            ),
          ],
        ),
      ),
    );
  }

  Widget showCourse(data){
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.width / 2.5,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'La course viens de prendre fin.\n Vous devez payez',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 25
              ),
            ),

            Text(
              '${data['prix']} \$',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width / 25
              ),
            ),

            const SizedBox(height: 16.0,),
            AppButton(
              color: AppColors.primaryColor,
              name: 'FERMER ',
              onTap: ()=>Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}