import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/utils/app_colors.dart';
import 'package:toast/toast.dart';

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
  List<LatLng> destinationPolylineCoordinates = [];
  CameraPosition? cam;
  late Size size;

  addPolyLine(List<LatLng> polylineCoordinates, String ids) {
    PolylineId id = PolylineId(ids);
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }

  addDestinationPolyLine(List<LatLng> polylineCoordinates, String ids) {
    PolylineId id = PolylineId(ids);
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }

  addPoly(LatLng driver, LatLng depart, LatLng destination) async{
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        androidApiKey,
        PointLatLng(driver.latitude, driver.longitude),
        PointLatLng(depart.latitude, depart.longitude)
    );

    PolylineResult destinations = await polylinePoints.getRouteBetweenCoordinates(
        androidApiKey,
        PointLatLng(depart.latitude, depart.longitude),
        PointLatLng(destination.latitude, destination.longitude)
    );

    polylineCoordinates.clear();
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {
        addPolyLine(polylineCoordinates, 'frist');
      });
    }

    destinationPolylineCoordinates.clear();

    if (destinations.points.isNotEmpty) {
      for (var points in destinations.points) {
        destinationPolylineCoordinates.add(LatLng(points.latitude, points.longitude));
      }
      setState(() {
        addDestinationPolyLine(destinationPolylineCoordinates, 'second');
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

              markers.clear();

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
                  LatLng(data['depart_latitude'], data['depart_longitude']),
                  LatLng(data['destination_latitude'], data['destination_longitude'])
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
        height: MediaQuery.of(context).size.width / 3.0,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            data['status'] == "start" ?
                Text(
                  'Votre course est en cours...',
                  style: TextStyle(
                    fontFamily: 'Anton',
                    fontSize: MediaQuery.of(context).size.width / 15
                  ),
                )
                : Text(
                polylineCoordinates.length != 0 ? 'Le chauffeur est à ${distanceDeuxPoint(polylineCoordinates)} de votre position.' : "Distance",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width / 25
              ),
            ),

            const SizedBox(height: 16.0,),

            data['status'] == "start" ?
                const SizedBox() :
            AppButton(
              color: AppColors.primaryColor,
              name: 'APPELER ',
              onTap: ()=>makePhoneCall('+243${data['driver']}'),
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
        height: MediaQuery.of(context).size.width / 2.3,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
              onTap: (){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage()
                  ),
                    (route)=>false
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}