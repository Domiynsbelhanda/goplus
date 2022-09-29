import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:goplus/pages/homePage.dart';

import 'package:goplus/widget/app_button.dart';

import '../../widget/notification_dialog.dart';

class PickLocation extends StatefulWidget{
  String? place;
  PickLocation({this.place});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PickLocation();
  }
}

class _PickLocation extends State<PickLocation>{

  String androidApiKey = 'AIzaSyAFtipYv6W0AWKFWsipPRhrgRdPHF5MOvk';
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(27.6602292, 85.308027);
  String location = "Search Location";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            GoogleMap( //Map widget from google_maps_flutter package
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              initialCameraPosition: CameraPosition( //innital position in map
                target: startLocation, //initial position
                zoom: 14.0, //initial zoom level
              ),
              mapType: MapType.normal, //map type
              onMapCreated: (controller) { //method called when map is created
                setState(() {
                  mapController = controller;
                });
              },
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


                        //move map camera to selected place with animation
                        mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: newlatlang, zoom: 17)));
                      }
                    },
                    child:Padding(
                      padding: EdgeInsets.all(15),
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
      )
    );
  }
}