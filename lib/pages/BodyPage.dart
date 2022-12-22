import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Maps;
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:toast/toast.dart';

import '../screens/mapsPickLocation.dart';
import '../utils/app_colors.dart';
import '../utils/global_variable.dart';
import '../widget/app_button.dart';

class BodyPage extends KFDrawerContent {
  BodyPage({Key? key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BodyPage();
  }
}

class _BodyPage extends State<BodyPage> {
  Set<Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Maps.Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  late Size size;
  String? destination;
  LatLng? destinationLatLng;
  CameraPosition? cam;

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("Trajet une");
    Maps.Polyline polyline = Maps.Polyline(
      polylineId: id,
      color: Colors.deepOrange,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ToastContext().init(context);
    markers.add(Marker(
      markerId: const MarkerId('Ma Position'),
      position: position,
      infoWindow: const InfoWindow(
        title: 'Ma Position',
        snippet: 'Moi',
      ),
      icon: pinner!,
    ));
    cam = CameraPosition(target: position, zoom: zoom);

    return Stack(
      children: [
        GoogleMap(
          zoomGesturesEnabled: true,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          initialCameraPosition: cam!,
          markers: markers,
          polylines: Set<Maps.Polyline>.of(polylines.values),
          onMapCreated: (GoogleMapController _controller) {
            _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(target: position, zoom: zoom),
              ),
            );
          },
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(48.0)),
                  child: IconButton(
                    onPressed: widget.onMenuPressed,
                    icon: const Icon(
                      Icons.menu,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 16.0),
                child: Container(
                  height:
                      destination != null ? size.width / 1.1 : size.width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(size.width / 15),
                    color: AppColors.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 16.0, right: 16.0),
                        child: Image.asset(
                          'assets/images/bonjour.png',
                          height: size.width / 9,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 36.0, bottom: 16.0),
                        child: Text("OU ALLEZ-VOUS?",
                            style: TextStyle(
                                fontSize: size.width / 15,
                                fontFamily: 'Anton',
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: GestureDetector(
                          onTap: () async {
                            var place = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: androidApiKey,
                                mode: Mode.overlay,
                                types: [],
                                strictbounds: false,
                                components: [
                                  Component(Component.country, 'cd')
                                ],
                                //google_map_webservice package
                                onError: (err) {
                                  print(err);
                                });

                            if (place != null) {
                              final plist = GoogleMapsPlaces(
                                apiKey: androidApiKey,
                                apiHeaders:
                                    await const GoogleApiHeaders().getHeaders(),
                              );
                              String placeid = place.placeId ?? "0";
                              final detail =
                                  await plist.getDetailsByPlaceId(placeid);
                              final geometry = detail.result.geometry!;
                              final lat = geometry.location.lat;
                              final lang = geometry.location.lng;

                              // PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
                              //   androidApiKey,
                              //   PointLatLng(position.latitude, position.longitude),
                              //   PointLatLng(lat, lang)
                              // );

                              // if (result.points.isNotEmpty) {
                              //
                              // } else {
                              //   Toast.show(
                              //       '${result.errorMessage}',
                              //       duration: Toast.lengthLong,
                              //       gravity: Toast.bottom
                              //   );
                              // }

                              markers.clear();
                              polylineCoordinates.clear();
                              polylineCoordinates.add(LatLng(
                                  position.latitude, position.longitude));
                              polylineCoordinates.add(LatLng(lat, lang));
                              setState(() {
                                addPolyLine(polylineCoordinates);
                              });

                              setState(() {
                                destinationLatLng = LatLng(lat, lang);
                                destination = place.description.toString();
                                CameraPosition cameraPosition = CameraPosition(
                                  target: LatLng(lat, lang),
                                  zoom: 13,
                                );
                                cam = cameraPosition;
                                markers.add(Marker(
                                  markerId: const MarkerId('Ma Position'),
                                  position: position,
                                  infoWindow: const InfoWindow(
                                    title: 'Ma Position',
                                    snippet: 'Moi',
                                  ),
                                  icon: pinner!,
                                ));
                                markers.add(Marker(
                                  markerId: const MarkerId('Destination'),
                                  position: destinationLatLng!,
                                  infoWindow: InfoWindow(
                                    title: 'Votre Destination',
                                    snippet: '${destination}',
                                  ),
                                  icon: arriveBitmap!,
                                ));
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.black),
                            )),
                            child: Row(
                              children: [
                                const Icon(Icons.search),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                Flexible(
                                  child: Text(destination != null
                                      ? '${destination}'
                                      : "Entrez votre destination"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 0, top: 16.0, right: 0, bottom: 16.0),
                          child: AppButton(
                            color: Colors.black,
                            name: 'SUIVANT',
                            onTap: () {
                              if (destination == null) {
                                Toast.show('Veuillez entrée une destination',
                                    duration: Toast.lengthLong,
                                    gravity: Toast.bottom);
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PickLocation(
                                          positions: position,
                                          destination: destinationLatLng!,
                                          picto: pinner!,
                                        )),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
