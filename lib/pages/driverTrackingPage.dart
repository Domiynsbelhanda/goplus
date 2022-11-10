import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goplus/utils/app_colors.dart';
import 'package:goplus/utils/global_variable.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/bottom_type_car.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../widget/app_button.dart';
import '../widget/notification_dialog.dart';
import 'google_maps_popylines.dart';

class DriverTrackingPage extends StatefulWidget{
  LatLng origine;
  LatLng destination;
  BitmapDescriptor picto;
  List<LatLng> destinationPolylines;
  String uuid;
  DriverTrackingPage({
    Key? key,
    required this.destination,
    required this.origine,
    required this.picto,
    required this.destinationPolylines,
    required this.uuid
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DriverTrackingPage();
  }
}

class _DriverTrackingPage extends State<DriverTrackingPage>{

  Set<Marker> markers = {};
  Set<Circle> circles = {};
  String carType = "1";
  int? index;
  GoogleMapController? mapController;
  late Size size;
  bool offre = false;
  List<LatLng> driverPolylines = [];
  PolylineResult? driverResult;
  bool ride = false;
  bool driver = false;

  @override
  void initState() {
    data(widget.origine);
  }

  void data(LatLng value) async{
    setState(() {
      circles = {Circle(
        strokeColor: Colors.red,
        strokeWidth: 2,
        fillColor: Colors.red.withOpacity(0.2),
        circleId: const CircleId('1'),
        center: LatLng(value.latitude, value.longitude),
        radius: 3700,
      )};
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh(widget.origine);
  }

  void refresh(target) async {
    mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
                target: target,
                zoom: 12.0
            )
        )
    );
  }


  @override
  Widget build(BuildContext context){
    size = MediaQuery.of(context).size;
    FirebaseFirestore.instance.collection('courses').doc(widget.uuid).update({
      'carType': carType
    });
    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("drivers").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("courses").doc(widget.uuid).snapshots(),
              builder: (BuildContext context, coursesSnap){
                if(coursesSnap.hasData){
                  var data = snapshot.data!.docs;
                  var coursesdata = coursesSnap.data! as DocumentSnapshot;
                  Map<String, dynamic> courses = coursesdata.data() as Map<String, dynamic>;

                  markers.clear();
                  markers.add(
                      Marker(
                        markerId: const MarkerId("1"),
                        position: position,
                        infoWindow: const InfoWindow(
                          title: 'Votre Position',
                        ),
                        icon: widget.picto,
                      )
                  );
                  for(var i = 0; i < data.length; i++){
                    if(data[i].get('online')){
                      if(data[i].get('cartype') == carType){
                        double latitude = data[i].get('latitude');
                        double longitude = data[i].get('longitude');
                        GeoPoint location = GeoPoint(latitude, longitude);

                        if (location == null) {
                          return const Text("There was no location data");
                        }
                        final latLng = LatLng(location.latitude, location.longitude);

                        markers
                            .add(
                            Marker(
                                markerId: MarkerId(data[i].id),
                                position: latLng,
                                icon: car_android!,
                                onTap: (){
                                  index = i;
                                  setState(() {
                                    index = i;
                                    driver = true;
                                  });
                                }
                            )
                        );
                      }
                    }
                  }

                  return Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: widget.origine,
                            zoom: 12
                        ),
                        // Markers to be pointed
                        markers: markers,
                        circles: circles,
                        onMapCreated: _onMapCreated,
                      ),

                      Positioned(
                        right: 16,
                        top: 16,
                        child: BackButtons(context),
                      ),

                      Positioned(
                        bottom: 16,
                        left: 16.0,
                        right: offre ? 72 : 16.0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(size.width / 15),
                            color: offre ? Colors.transparent : AppColors.primaryColor,
                            boxShadow: [
                              offre ? BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: const Offset(0, 0), // changes position of shadow
                              ): BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: offre ?
                          AppButton(
                            name: 'MODIFIEZ L\'OFFRE',
                            color: Colors.black,
                            onTap: (){
                              setState(() {
                                offre = !offre;
                              });
                            },
                          )
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CHOISISSEZ UNE OFFRE',
                                style: TextStyle(
                                    fontSize: size.width / 15,
                                    fontFamily: 'Anton',
                                    color: Colors.white
                                ),
                              ),

                              const SizedBox(
                                height: 8.0,
                              ),

                              BottomTypeCar(
                                image: 'assets/images/ist.png',
                                type: 'GO+',
                                place: "Petite voiture de 3 places \nIdéale pour les Courses rapides et à bon prix",
                                prices: '10\$ / Heure',
                                onTap: (){
                                  setState(() {
                                    carType = "1";
                                  });
                                  FirebaseFirestore.instance.collection('courses').doc(widget.uuid).update({
                                    'carType': carType
                                  });
                                },
                                active: carType == "1",
                              ),

                              const SizedBox(
                                height: 16.0,
                              ),

                              BottomTypeCar(
                                image: 'assets/images/berline.png',
                                type: 'GO+ VIP',
                                place: "Berline de 4 places\nIdéal pour des trajets moyens et longs",
                                prices: '15\$ / Heure',
                                onTap: (){
                                  FirebaseFirestore.instance.collection('courses').doc(widget.uuid).update({
                                        'carType': carType
                                  });
                                  setState(() {
                                    carType = "2";
                                  });
                                },
                                active: carType == "2",

                              ),

                              // const SizedBox(
                              //   height: 8.0,
                              // ),
                              //
                              // AppButton(
                              //   color: Colors.black,
                              //   name: 'SUIVANT',
                              //   onTap: (){
                              //     FirebaseFirestore.instance.collection('courses').doc(widget.uuid).update({
                              //       'carType': carType
                              //     }).then((value){
                              //     });
                              //     setState(() {
                              //       offre = !offre;
                              //       ride = !ride;
                              //     });
                              //   },
                              // )
                            ],
                          ),
                        ),
                      ),

                      driver ?
                      Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: showDriver(data[index!])
                        ),
                      ) : const SizedBox(),

                      ride ?
                      Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
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
                                child: courses['status'] == 'pending' || courses['status'] == 'view' ?
                                    SizedBox(
                                      width: size.width / 1,
                                      height: size.width /1.3,
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children : [
                                                const Text(
                                                  'En attente de la réponse',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),

                                                TimerCountdown(
                                                  secondsDescription: 'Secondes',
                                                  minutesDescription: 'Minutes',
                                                  timeTextStyle: const TextStyle(
                                                      fontSize: 25,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  format: CountDownTimerFormat.minutesSeconds,
                                                  endTime: DateTime.now().add(
                                                    const Duration(
                                                      minutes: 5,
                                                      seconds: 30,
                                                    ),
                                                  ),
                                                  onEnd: () {
                                                    FirebaseFirestore.instance.collection('courses').doc(widget.uuid).update({
                                                      'status': "no"
                                                    }).then((value){
                                                      FirebaseFirestore.instance.collection('clients').doc('${courses['users']}').update({
                                                        'status': 'no',
                                                      });
                                                      FirebaseFirestore.instance.collection('drivers').doc(data[index!].id).update({
                                                        'online': true,
                                                        'ride': false,
                                                        'uuid': null,
                                                      });
                                                    });
                                                    setState(() {
                                                      ride = false;
                                                    });
                                                  },
                                                ),

                                                TextButton(
                                                  child: Container(
                                                      padding: const EdgeInsets.all(16.0),
                                                      decoration: BoxDecoration(
                                                          color: AppColors.primaryColor,
                                                          borderRadius: BorderRadius.circular(8.0)
                                                      ),
                                                      child: const Text(
                                                        'ANNULER VOTRE COMMANDE',
                                                        style: TextStyle(
                                                            color: Colors.black
                                                        ),
                                                      )
                                                  ),
                                                  onPressed: (){
                                                    FirebaseFirestore.instance.collection('courses').doc(widget.uuid).update({
                                                      'status': "cancel"
                                                    }).then((value){
                                                      FirebaseFirestore.instance.collection('clients').doc('${courses['users']}').update({
                                                        'status': 'cancel',
                                                      });

                                                      FirebaseFirestore.instance.collection('drivers').doc(data[index!].id).update({
                                                        'online': true,
                                                        'ride': false,
                                                        'uuid': null,
                                                      });
                                                    });
                                                    setState(() {
                                                      ride = false;
                                                    });
                                                  },
                                                ),
                                              ]
                                          )
                                      ),
                                    )
                                    : courses['status'] == 'cancel' ?
                                    SizedBox(
                                      width: size.width / 1,
                                      height: size.width / 1.1,
                                      child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                              children : [
                                                Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: size.width / 5,
                                                ),

                                                const SizedBox(height: 16.0),

                                                SizedBox(
                                                  width : size.width / 1.5,
                                                  child: const Text(
                                                      'Votre commande a été annulée.',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      )
                                                  ),
                                                ),

                                                const SizedBox(height: 16.0),

                                                TextButton(
                                                  child: Container(
                                                      padding: const EdgeInsets.all(16.0),
                                                      decoration: BoxDecoration(
                                                          color: AppColors.primaryColor,
                                                          borderRadius: BorderRadius.circular(8.0)
                                                      ),
                                                      child: const Text(
                                                        'FERMER',
                                                        style: TextStyle(
                                                            color: Colors.black
                                                        ),
                                                      )
                                                  ),
                                                  onPressed: (){
                                                    FirebaseFirestore.instance.collection('clients').doc('${courses['users']}').update({
                                                      'status': 'cancel',
                                                    });
                                                    setState(() {
                                                      ride = false;
                                                    });
                                                  },
                                                )
                                              ]
                                          )
                                      ),
                                    )
                                        :
                                        courses['status'] == 'no' ?
                                        SizedBox(
                                          width: size.width / 1,
                                          height: size.width / 1.1,
                                          child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Column(
                                                  children : [
                                                    Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                      size: size.width / 5,
                                                    ),

                                                    const SizedBox(height: 16.0),

                                                    SizedBox(
                                                      width : size.width / 1.5,
                                                      child: const Text(
                                                          'Pas de chauffeur disponible',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                          )
                                                      ),
                                                    ),

                                                    const SizedBox(height: 16.0),

                                                    TextButton(
                                                      child: Container(
                                                          padding: const EdgeInsets.all(16.0),
                                                          decoration: BoxDecoration(
                                                              color: AppColors.primaryColor,
                                                              borderRadius: BorderRadius.circular(8.0)
                                                          ),
                                                          child: const Text(
                                                            'FERMER',
                                                            style: TextStyle(
                                                                color: Colors.black
                                                            ),
                                                          )
                                                      ),
                                                      onPressed: (){
                                                        FirebaseFirestore.instance.collection('courses').doc(widget.uuid).update({
                                                          'status': "cancel"
                                                        });
                                                        setState(() {
                                                          ride = false;
                                                        });
                                                      },
                                                    )
                                                  ]
                                              )
                                          ),
                                        )
                                        :
                                            courses['status'] == 'confirm' ?
                                            SizedBox(
                                              width: size.width / 1,
                                              height: size.width / 1.1,
                                              child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Column(
                                                      children : [
                                                        Icon(
                                                          Icons.drive_eta_rounded,
                                                          color: Colors.green,
                                                          size: size.width / 5,
                                                        ),

                                                        const SizedBox(height: 16.0),

                                                        SizedBox(
                                                          width : size.width / 1.5,
                                                          child: const Text(
                                                              'Votre course a été confirmée.',
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors.black,
                                                              )
                                                          ),
                                                        ),

                                                        const SizedBox(height: 16.0),

                                                        TextButton(
                                                          child: Container(
                                                              padding: const EdgeInsets.all(16.0),
                                                              decoration: BoxDecoration(
                                                                  color: AppColors.primaryColor,
                                                                  borderRadius: BorderRadius.circular(8.0)
                                                              ),
                                                              child: const Text(
                                                                'SUIVRE LE CHAUFFEUR',
                                                                style: TextStyle(
                                                                    color: Colors.black
                                                                ),
                                                              )
                                                          ),
                                                          onPressed: (){
                                                            Navigator.pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext context) =>
                                                                      GoogleMapsPolylines(
                                                                        uuid: widget.uuid
                                                                      )
                                                              ),
                                                                (route)=> false
                                                            );
                                                          },
                                                        )
                                                      ]
                                                  )
                                              ),
                                            )
                                        :
                                        const SizedBox()
                              ),
                            )
                        ),
                      ) : const SizedBox(),
                    ],
                  );
                }
                return Container();
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  getResult(LatLng driver) async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult resultat = await polylinePoints.getRouteBetweenCoordinates(
        androidApiKey,
        PointLatLng(driver.latitude, driver.longitude),
        PointLatLng(widget.origine.latitude, widget.origine.longitude)
    );
    setState(() {
      driverResult = resultat;
    });
  }

  Widget showDriver(data){
    getResult(LatLng(data.get('latitude'), data.get('longitude')));
    driverPolylines.clear();
    PolylineResult result  = driverResult!;
    if(result.points.isNotEmpty){
      for (var points in result.points) {
        driverPolylines.add(LatLng(points.latitude, points.longitude));
      }
    }
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.width + 17,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DETAILS DU CHAUFFEUR",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: size.width / 20
                  ),
                ),

                GestureDetector(
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onTap: (){
                    setState(() {
                      index = null;
                      ride = true;
                      driver = false;
                    });
                  },
                ),
              ],
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
                      image: DecorationImage(
                        image: NetworkImage(
                          data.get('image') != null ? data.get('image')! : 'https://firebasestorage.googleapis.com/v0/b/taxigo-e3fcc.appspot.com/o/profile.jpg?alt=media&token=609b45f5-2f3c-4edb-b5f4-c041b9eb0457',
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
                      style: TextStyle(
                          fontSize: size.width / 18,
                        fontFamily: 'Anton'
                      ),
                    ),
                    const SizedBox(height: 8.0,),

                    GestureDetector(
                      onTap: ()=>makePhoneCall('+243${data.get('phone')}'),
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

            const SizedBox(
              height: 8.0,
            ),

            Text(
              "Ce chauffeur est à ${distanceDeuxPoint(driverPolylines)} de votre position.",
              style: const TextStyle(
                  fontSize: 14.0
              ),
            ),

            const SizedBox(height: 8.0,),

            const Divider(
              height: 8.0,
            ),

            Text(
              "Plaque : ${data.get('carplate')}\nCouleur : ${data.get('colour')}",
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4.0,),

            const SizedBox(height: 16.0,),

            AppButton(
              color: AppColors.primaryColor,
              name: 'RESERVER',
              onTap: (){
                showLoader("Reservation en cours...");
                var don = {
                  "key": "ride",
                  "action": "create",
                  "phone": data.id
                };

                Provider.of<Auth>(context, listen: false).request(data : don).then((sms){
                  if("sms['code']" == "sms['code']"){
                    Provider.of<Auth>(context, listen: false).getToken().then((value){
                      Provider.of<Auth>(context, listen: false).getSid().then((val){
                        disableLoader();
                        if(val != null){
                          setState(() {
                            ride = true;
                            driver = false;
                          });
                          FirebaseFirestore.instance.collection('courses').doc(widget.uuid).update({
                            'status': "pending",
                            'depart_longitude': widget.origine.longitude,
                            'depart_latitude': widget.origine.latitude,
                            'destination_longitude': widget.destination.longitude,
                            'destination_latitude': widget.destination.latitude,
                            'sid_user': val,
                          }).then((val){
                            FirebaseFirestore.instance.collection('clients').doc(value!).update({
                              'status': 'pending',
                            });
                          });
                          FirebaseFirestore.instance.collection('drivers').doc(data.id).update({
                            'online': false,
                            'ride': true,
                            'uuid': widget.uuid,
                          });
                        } else {
                        }
                      });
                    });
                  } else {
                    disableLoader();
                    notification_dialog(
                        context,
                        "Ce Chauffeur Injoignable.",
                        {'label': 'FERMER', "onTap": (){
                          Navigator.pop(context);
                        }},
                        20,
                        false);
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}