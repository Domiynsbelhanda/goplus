import 'package:flutter/material.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: implementation_imports, unused_import
import 'package:google_maps_place_picker_mb/src/google_map_place_picker.dart'; // do not import this yourself
import 'dart:io' show Platform;

class PickLocation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PickLocation();
  }
}

class _PickLocation extends State<PickLocation>{

  PickResult? selectedPlace;
  bool showPlacePickerInContainer = false;
  bool showGoogleMapInContainer = false;
  String androidApiKey = 'AIzaSyAFtipYv6W0AWKFWsipPRhrgRdPHF5MOvk';
  String iosApiKey = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Google Map Place Picker Demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Platform.isAndroid && !showPlacePickerInContainer
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(value: AndroidGoogleMapsFlutter.useAndroidViewSurface, onChanged: (value) {
                    setState(() {
                      showGoogleMapInContainer = false;
                      AndroidGoogleMapsFlutter.useAndroidViewSurface = value;
                    });
                  }),
                  Text("Use Hybrid Composition"),
                ],
              )
                  : Container(),
              !showPlacePickerInContainer
                  ? ElevatedButton(
                child: Text("Load Place Picker"),
                onPressed: () {

                },
              )
                  : Container(),
              !showPlacePickerInContainer
                  ? ElevatedButton(
                child: Text("Load Place Picker in Container"),
                onPressed: () {
                  setState(() {
                    showPlacePickerInContainer = true;
                  });
                },
              )
                  : Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: PlacePicker(
                      forceAndroidLocationManager: true,
                      apiKey: Platform.isAndroid
                          ? androidApiKey
                          : iosApiKey,
                      hintText: "Find a place ...",
                      searchingText: "Please wait ...",
                      selectText: "Select place",
                      initialPosition: LatLng(37.43296265331129, -122.08832357078792),
                      useCurrentLocation: true,
                      selectInitialPosition: true,
                      usePinPointingSearch: true,
                      usePlaceDetailSearch: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      onPlacePicked: (PickResult result) {
                        setState(() {
                          selectedPlace = result;
                          showPlacePickerInContainer = false;
                        });
                      },
                      onTapBack: () {
                        setState(() {
                          showPlacePickerInContainer = false;
                        });
                      })),
              selectedPlace == null
                  ? Container()
                  : Text(
                '${selectedPlace!.formattedAddress}'
              ),
              selectedPlace == null
                  ? Container()
                  : Text('(lat : ${selectedPlace!.geometry!.location.lat.toString()}'
                      ', lng : ${selectedPlace!.geometry!.location.lng.toString()})'),
              //
              showPlacePickerInContainer
                  ? Container()
                  : ElevatedButton(
                child: Text("Toggle Google Map w/o Provider"),
                onPressed: () {
                  setState(() {
                    showGoogleMapInContainer = !showGoogleMapInContainer;
                  });
                },
              ),
              !showGoogleMapInContainer
                  ? Container()
                  : Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: GoogleMap(
                    zoomGesturesEnabled: false,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    compassEnabled: false,
                    mapToolbarEnabled: false,
                    initialCameraPosition: new CameraPosition(target: LatLng(37.43296265331129, -122.08832357078792), zoom: 15),
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                    },
                    onCameraIdle: () {
                    },
                    onCameraMoveStarted: () {
                    },
                    onCameraMove: (CameraPosition position) {
                    },
                  )
              ),
              !showGoogleMapInContainer
                  ? Container()
                  : TextField(
              ),
              // #endregion
            ],
          ),
        ));
  }
}