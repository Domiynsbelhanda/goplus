import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:goplus/taxi/screens/mapsPickLocation.dart';
import 'package:goplus/widget/buildTextField.dart';
import 'package:goplus/widget/logo_text.dart';
import 'package:goplus/widget/notification_dialog.dart';

import '../formulaire/dashboard.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  late Size size;
  TextEditingController destinationController = TextEditingController();
  TextEditingController departController = TextEditingController();
  PickResult? selectedPlace;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LogoText(),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Card(
                elevation: 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Text(
                          'Où Allez-vous?',
                          style: TextStyle(
                              fontSize: size.width / 20,
                              fontFamily: 'Anton',
                          )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                      child: Text(
                          'Nos taxis vous y conduirons en toute sécurité et convivialité à bord.',
                          style: TextStyle(
                              fontSize: size.width / 25
                          )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                      child: BuildTextField(
                        labelText: 'Entrez votre destination',
                        context: context,
                        keyboardType: TextInputType.text,
                        validator: null,
                        suffixIcon: {
                          'icon': Icons.search,
                          'onTap': (){
                            String? destination = destinationController.text.trim();
                            if(destination.isEmpty){
                              notification_dialog(
                                  context,
                                  'Veuillez tapez le nom du lieu où vous voulez vous rendre.',
                                  Icons.map_outlined,
                                  Colors.blueAccent,
                                  {
                                    'label': 'FERMER',
                                    'onTap': ()=> Navigator.pop(context)
                                  },
                                  20,
                                  false);
                              return;
                            }
                          },
                        },
                        controller: destinationController,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: BuildTextField(
                        labelText: 'Entrez votre point de départ',
                        context: context,
                        keyboardType: TextInputType.text,
                        validator: null,
                        suffixIcon: {
                          'icon': Icons.search,
                          'onTap': (){
                            String? depart = departController.text.trim();
                            if(depart.isEmpty){
                              notification_dialog(
                                  context,
                                  'Veuillez tapez le nom du lieu où vous voulez vous rendre.',
                                  Icons.map_outlined,
                                  Colors.blueAccent,
                                  {
                                    'label': 'FERMER',
                                    'onTap': ()=> Navigator.pop(context)
                                  },
                                  20,
                                  false);
                              return;
                            }
                          },
                        },
                        controller: departController,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return PlacePicker(
                          resizeToAvoidBottomInset: false, // only works on fullscreen, less flickery
                          apiKey: 'AIzaSyAFtipYv6W0AWKFWsipPRhrgRdPHF5MOvk',
                          hintText: "Trouvez un lieu ...",
                          searchingText: "Veuillez patienter ...",
                          selectText: "Choisir une place",
                          outsideOfPickAreaText: "Pas de lieu trouvée.",
                          initialPosition: LatLng(37.43296265331129, -122.08832357078792),
                          useCurrentLocation: true,
                          selectInitialPosition: true,
                          usePinPointingSearch: true,
                          usePlaceDetailSearch: true,
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          onMapCreated: (GoogleMapController controller) {
                          },
                          onPlacePicked: (PickResult result) {
                            setState(() {
                              selectedPlace = result;
                              Navigator.of(context).pop();
                            });
                          },
                          onMapTypeChanged: (MapType mapType) {
                          },
                          forceSearchOnZoomChanged: true,
                          automaticallyImplyAppBarLeading: false,
                          autocompleteLanguage: "ko",
                          region: 'cd',
                          pickArea: CircleArea(
                            center: LatLng(37.43296265331129, -122.08832357078792),
                            radius: 300,
                            fillColor: Colors.lightGreen.withGreen(255).withAlpha(32),
                            strokeColor: Colors.lightGreen.withGreen(255).withAlpha(192),
                            strokeWidth: 2,
                          ),
                          selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                            return isSearchBarFocused
                                ? Container()
                                : FloatingCard(
                              bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                              leftPosition: 0.0,
                              rightPosition: 0.0,
                              width: 500,
                              borderRadius: BorderRadius.circular(12.0),
                              child: state == SearchingState.Searching
                                  ? Center(child: CircularProgressIndicator())
                                  : ElevatedButton(
                                child: Text("Choisir"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                          pinBuilder: (context, state) {
                            if (state == PinState.Idle) {
                              return Icon(
                                FontAwesomeIcons.solidHandPointDown,
                                size: 50,
                                color: Colors.blueAccent,
                              );
                            } else {
                              return Icon(
                                FontAwesomeIcons.solidHandPointDown,
                                size: 50,
                                color: Colors.blueAccent,
                              );
                            }
                          },
                          // introModalWidgetBuilder: (context,  close) {
                          //   return Positioned(
                          //       top: MediaQuery.of(context).size.height * 0.35,
                          //       right: MediaQuery.of(context).size.width * 0.15,
                          //       left: MediaQuery.of(context).size.width * 0.15,
                          //       child: Container(
                          //         width: MediaQuery.of(context).size.width * 0.7,
                          //         child: Material(
                          //           type: MaterialType.canvas,
                          //           color: Theme.of(context).cardColor,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(12.0),
                          //           ),
                          //           elevation: 4.0,
                          //           child: ClipRRect(
                          //             borderRadius: BorderRadius.circular(12.0),
                          //             child: Container(
                          //                 padding: EdgeInsets.all(8.0),
                          //                 child: Column(
                          //                     children: [
                          //                       SizedBox.fromSize(size: new Size(0, 10)),
                          //                       Text("Please select your preferred address.",
                          //                           style: TextStyle(
                          //                             fontWeight: FontWeight.bold,
                          //                           )
                          //                       ),
                          //                       SizedBox.fromSize(size: new Size(0, 10)),
                          //                       SizedBox.fromSize(
                          //                         size: Size(MediaQuery.of(context).size.width * 0.6, 56), // button width and height
                          //                         child: ClipRRect(
                          //                           borderRadius: BorderRadius.circular(10.0),
                          //                           child: Material(
                          //                             child: InkWell(
                          //                                 overlayColor: MaterialStateColor.resolveWith(
                          //                                         (states) => Colors.blueAccent
                          //                                 ),
                          //                                 onTap: ()=>close!,
                          //                                 child: Row(
                          //                                   mainAxisAlignment: MainAxisAlignment.center,
                          //                                   children: [
                          //                                     Icon(Icons.check_sharp, color: Colors.blueAccent),
                          //                                     SizedBox.fromSize(size: new Size(10, 0)),
                          //                                     Text("OK",
                          //                                         style: TextStyle(
                          //                                             color: Colors.blueAccent
                          //                                         )
                          //                                     )
                          //                                   ],
                          //                                 )
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       )
                          //                     ]
                          //                 )
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //   );
                          // },
                        );
                      },
                    ),
                  );
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => PickLocation()
                  //   )
                  // );
                },
                child: Text(
                    'GO FLY SERVICES',
                    style: TextStyle(
                        fontSize: size.width / 20,
                        fontFamily: 'Anton'
                    )
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}