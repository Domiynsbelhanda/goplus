import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../pages/driverTrackingPage.dart';
import '../services/auth.dart';
import '../utils/global_variable.dart';
import '../widget/app_button.dart';
import 'mapsOriginePickLocation.dart';

class PickLocation extends StatefulWidget{
  LatLng destination;
  LatLng positions;
  BitmapDescriptor picto;

  PickLocation({super.key, required this.destination, required this.positions, required this.picto});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PickLocation();
  }
}

class _PickLocation extends State<PickLocation>{

  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  GoogleMapController? mapController;

  String location = "Chercher un lieu";
  late LatLng destination;

  late Size size;
  late CameraPosition cam = CameraPosition(
    target: widget.destination,
    zoom: 15
    );

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh(widget.destination);
  }

  void refresh(target) async {
    mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(
              target: target,
                zoom: 15.0
            )
        )
    );
  }

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

  void addPoly(desti) async{
    markers.clear();
    markers.add(
        Marker(
          markerId: const MarkerId('Ma Position'),
          position: widget.positions,
          infoWindow: const InfoWindow(
            title: 'Ma Position',
            snippet: 'Moi',
          ),
          icon: widget.picto,
        )
    );
    markers.add(
        Marker(
          markerId: const MarkerId('Destination'),
          position: desti,
          infoWindow: const InfoWindow(
            title: 'Votre Destination',
            snippet: "Destiantion",
          ),
          icon: pinner!,
        )
    );
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        androidApiKey,
        PointLatLng(widget.positions.latitude, widget.positions.longitude),
        PointLatLng(desti.latitude, desti.longitude)
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates.clear();
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {
        addPolyLine(polylineCoordinates);
      });
    } else {
      Toast.show(
          '${result.errorMessage}',
          duration: Toast.lengthLong,
          gravity: Toast.bottom
      );
    }
  }

  @override
  void initState() {
    destination = widget.destination;
    addPoly(destination);
  }

  @override
  Widget build(BuildContext context) {
    readBitconMarkerPinner();
    size = MediaQuery.of(context).size;
    ToastContext().init(context);
    return SizedBox(
        child: Stack(
          children: [
            GoogleMap( //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: markers,
              onMapCreated: _onMapCreated,
              polylines: Set<Polyline>.of(polylines.values),
              initialCameraPosition: cam,
              mapType: MapType.normal,
              onCameraMove: (CameraPosition camposition) {
                setState(() {
                  destination = camposition.target;
                  addPoly(camposition.target);
                });
              },
            ),

            Positioned(  //search input bar
                top:10,
                child: InkWell(
                    onTap: () async {
                      var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: androidApiKey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [Component(Component.country, 'cd')],
                          //google_map_webservice package
                          onError: (err){
                            print(err);
                          }
                      );

                      if(place != null){
                        setState(() {
                          location = place.description.toString();
                        });

                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(apiKey:androidApiKey,
                          apiHeaders: await GoogleApiHeaders().getHeaders(),
                          //from google_api_headers package
                        );
                        String placeid = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeid);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newlatlang = LatLng(lat, lang);

                        CameraPosition cameraPosition = CameraPosition(
                          target: newlatlang,
                          zoom: 15,
                        );

                        setState(() {
                          mapController!.animateCamera(
                              CameraUpdate.newCameraPosition(
                                  cameraPosition
                              )
                          );
                        });
                      }
                    },
                    child:Padding(
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        child: Container(
                            padding: const EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListTile(
                              title:Text(location, style: const TextStyle(fontSize: 18),),
                              trailing: const Icon(
                                  Icons.search
                              ),
                              dense: true,
                            )
                        ),
                      ),
                    )
                )
            ),

            Positioned(
              bottom: 32.0,
              right: 16,
              left: 16.0,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size.width / 30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Votre destination est à :',
                      style: TextStyle(
                        fontSize: size.width / 25,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(height: 4.0,),

                    Text(
                      '${distanceDeuxPoint(polylineCoordinates)}',
                      style: TextStyle(
                        fontSize: size.width / 20
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    AppButton(
                      color: Colors.black,
                      name: 'TROUVEZ UN TAXI',
                      onTap: (){
                        showLoader("Recherche d'un taxi en cours...");
                        Provider.of<Auth>(context, listen: false).getToken().then((token){
                          disableLoader();
                          String uuid = '$token${DateTime.now().toString()}';
                          FirebaseFirestore.instance.collection('courses').doc(uuid).update({
                            'users': token,
                            'depart_latitude': widget.positions.latitude,
                            'depart_longitude': widget.positions.longitude,
                            'destination_latitude': destination.latitude,
                            'destination_longitude': destination.longitude,
                            'uuid': uuid
                          });
                          FirebaseFirestore.instance.collection('clients').doc(token).update({
                            'ride': true,
                            'status': 'pending',
                            'uuid': uuid
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DriverTrackingPage(
                                      destination: destination,
                                      picto: widget.picto,
                                      origine: widget.positions,
                                      destinationPolylines: polylineCoordinates,
                                    )
                            ),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}