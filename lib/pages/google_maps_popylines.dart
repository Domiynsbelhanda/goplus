import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/utils/app_colors.dart';
import 'package:location/location.dart';
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child : StreamBuilder(
            stream: FirebaseFirestore.instance.collection("courses").doc(widget.uuid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

              if(!snapshot.hasData){
                return Text("Chargement en cours...");
              }

              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

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
              'Fuso',
              // 'est à ${calculateDistance(LatLng(data['latitude'], data['longitude']), LatLng(datas['depart_latitude'], datas['depart_longitude'])).toStringAsFixed(2)} m du lieu de départ.',
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