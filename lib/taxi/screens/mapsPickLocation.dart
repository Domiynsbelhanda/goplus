import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: implementation_imports, unused_import
import 'package:google_maps_place_picker_mb/src/google_map_place_picker.dart'; // do not import this yourself
import 'dart:io' show Platform;

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

  PickResult? selectedPlace;
  String androidApiKey = 'AIzaSyAFtipYv6W0AWKFWsipPRhrgRdPHF5MOvk';
  String iosApiKey = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: PlacePicker(
                    forceAndroidLocationManager: true,
                    apiKey: androidApiKey,
                    hintText: widget.place != null ? '${widget.place}' : "Trouver une place",
                    searchingText: "Veuillez patienter ...",
                    selectText: "Selectionner une place",
                    initialPosition: LatLng(37.43296265331129, -122.08832357078792),
                    useCurrentLocation: true,
                    selectInitialPosition: true,
                    usePinPointingSearch: true,
                    usePlaceDetailSearch: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    forceSearchOnZoomChanged: true,
                    automaticallyImplyAppBarLeading: false,
                    autocompleteLanguage: "fr",
                    region: 'cd',
                    pinBuilder: (context, state) {
                      if (state == PinState.Idle) {
                        return const Icon(
                          FontAwesomeIcons.solidHandPointDown,
                          size: 50,
                          color: Colors.red,
                        );
                      } else {
                        return const Icon(
                          FontAwesomeIcons.solidHandPointDown,
                          size: 50,
                          color: Colors.red,
                        );
                      }
                    },
                    pickArea: CircleArea(
                      center: LatLng(37.43296265331129, -122.08832357078792),
                      radius: 300,
                      fillColor: Colors.lightGreen.withGreen(255).withAlpha(32),
                      strokeColor: Colors.lightGreen.withGreen(255).withAlpha(192),
                      strokeWidth: 2,
                    ),
                    onPlacePicked: (PickResult result) {
                      setState(() {
                        selectedPlace = result;
                      });
                    },
                    onTapBack: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    })),
          ],
        )
      )
    );
  }
}