import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:goplus/pages/homePage.dart';

import '../utils/global_variable.dart';

class PickLocation extends StatefulWidget{
  LatLng? destination;
  LatLng? position;

  PickLocation({required this.destination, required position});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PickLocation();
  }
}

class _PickLocation extends State<PickLocation>{

  Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kPosition = CameraPosition(
    target: LatLng(-11.6565, 27.4782),
    zoom: 14.4746,
  );
  Set<Marker> markers = Set();
  String location = "Chercher un lieu";
  LatLng? selectedPlace;
  LatLng? departPlace;
  late BitmapDescriptor pinner;
  LatLng position = const LatLng(-4.4005633, 15.2758414);//const LatLng(-11.6480959, 27.4755775);

  @override
  void initState() {
    readBitconMarkerPinner();
  }

  void assetLocation(LatLng value) async{
    CameraPosition cameraPosition = CameraPosition(
      target: value,
      zoom: 13,
    );



    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    setState(() {
      markers.add(
          Marker(
              markerId: MarkerId("1"),
              position: value,
              infoWindow: const InfoWindow(
                title: 'Votre Position',
              )
          )
      );
    });
  }

  readBitconMarkerPinner() async {
    pinner = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      "assets/icon/pinner.png",
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
        child: Stack(
          children: [
            GoogleMap( //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition(
                  target: position,
                  zoom: 15
              ),
              mapType: MapType.normal, //map type
              markers: markers,
              onTap: (LatLng position){

                var markerIdVal = 'ma destination';
                final MarkerId markerId = MarkerId(markerIdVal);

                final Marker marker = Marker(
                  markerId: markerId,
                  position: position,
                  icon: pinner,
                );
                setState(() {
                  markers.add(marker);
                });
              },
              onMapCreated: (controller) {
                setState(() {
                  _controller.complete(controller);
                });
              },
            ),

            Positioned(
              bottom: 16.0,
              left: 0,
              right: 0,
              child : Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 16.0),
                  child: GestureDetector(
                    onTap: (){
                      if(selectedPlace != null){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(
                              )
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width / 7,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: Colors.black,
                              width: 2
                          )
                      ),
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                    Icons.map_outlined
                                ),
                                const SizedBox(width: 4.0,),
                                Text(
                                  departPlace == null
                                      ? 'Cliquez sur le point de départ' : 'VALIDEZ VOTRE CHOIX',
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          )
                      ),
                    ),
                  )
              ),
            ),

            //search autoconplete input
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

                        CameraPosition cameraPosition = new CameraPosition(
                          target: newlatlang,
                          zoom: 13,
                        );

                        final GoogleMapController controller = await _controller.future;
                        controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
                      }
                    },
                    child:Padding(
                      padding: const EdgeInsets.all(15),
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListTile(
                              title:Text(location, style: TextStyle(fontSize: 18),),
                              trailing: Icon(Icons.search),
                              dense: true,
                            )
                        ),
                      ),
                    )
                )
            ),
            //
            // Positioned(
            //     bottom: 20.0,
            //     child: AppButton(onTap: () async{
            //       Navigator.pushAndRemoveUntil(
            //           context,
            //           MaterialPageRoute<void>(builder: (BuildContext context) => HomePage(destination: null,)),
            //           (route) => false
            //       );
            //     }, name: 'Choisir ce lieu')
            // ),
          ],
        )
    );
  }
}