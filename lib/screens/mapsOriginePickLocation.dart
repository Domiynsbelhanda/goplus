import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:toast/toast.dart';

import '../utils/app_colors.dart';
import '../utils/global_variable.dart';
import '../widget/app_button.dart';

class OriginePickLocation extends StatefulWidget{
  LatLng destination;
  LatLng positions;
  BitmapDescriptor picto;

  OriginePickLocation({super.key, required this.destination, required this.positions, required this.picto});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PickLocation();
  }
}

class _PickLocation extends State<OriginePickLocation>{

  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  List<LatLng> polylinesCoordinates = [];
  GoogleMapController? mapController;

  String location = "Chercher un lieu";
  late LatLng origine;

  late Size size;
  late CameraPosition cam = CameraPosition(
    target: widget.positions,
    zoom: 15
    );

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    refresh(widget.positions);
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

  addPolyLine(List<LatLng> polylineCoordinates, color, pinId) {
    PolylineId id = PolylineId("$pinId");
    Polyline polyline = Polyline(
      polylineId: id,
      color: color,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }

  void addPoly(origine) async{
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
          position: widget.destination,
          infoWindow: const InfoWindow(
            title: 'Votre Destination',
            snippet: "Destination",
          ),
          icon: arriveBitmap!,
        )
    );

    markers.add(
        Marker(
          markerId: const MarkerId('Depart'),
          position: origine,
          infoWindow: const InfoWindow(
            title: 'Lieu de depart',
            snippet: "Depart",
          ),
          icon: pinner!,
        )
    );
    PolylineResult origines = await polylinePoints.getRouteBetweenCoordinates(
        androidApiKey,
        PointLatLng(widget.positions.latitude, widget.positions.longitude),
        PointLatLng(origine.latitude, origine.longitude)
    );
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        androidApiKey,
        PointLatLng(origine.latitude, origine.longitude),
        PointLatLng(widget.destination.latitude, widget.destination.longitude)
    );

    polylinesCoordinates.clear();
    if(origines.points.isNotEmpty){
      for (var points in origines.points) {
        polylinesCoordinates.add(LatLng(points.latitude, points.longitude));
      }
      setState(() {
        addPolyLine(polylinesCoordinates, Colors.red, 1);
      });
    }
    polylineCoordinates.clear();
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {
        addPolyLine(polylineCoordinates, Colors.green, 2);
      });
    }
  }

  @override
  void initState() {
    origine = widget.positions;
    addPoly(widget.positions);
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
                  origine = camposition.target;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vous êtes à  : ',
                          style: TextStyle(
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          '${distanceDeuxPoint(polylinesCoordinates)}',
                          style: TextStyle(
                              fontSize: size.width / 20
                          ),
                        ),
                      ],
                    ),

                    Text(
                      'de votre lieu de départ et',
                      style: TextStyle(
                          fontSize: size.width / 22
                      ),
                    ),

                    const SizedBox(height: 8.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Votre destination est à :',
                          style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        Text(
                          '${distanceDeuxPoint(polylineCoordinates)}',
                          style: TextStyle(
                              fontSize: size.width / 20
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16.0),

                    AppButton(
                      color: AppColors.primaryColor,
                      name: 'MODIFIER DESTINATION',
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),

                    const SizedBox(height: 16.0),

                    AppButton(
                      color: Colors.black,
                      name: 'TROUVER UN TAXI',
                      onTap: (){

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