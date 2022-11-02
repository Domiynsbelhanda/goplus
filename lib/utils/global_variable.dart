import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

final storage = const FlutterSecureStorage();

String androidApiKey = 'AIzaSyAFtipYv6W0AWKFWsipPRhrgRdPHF5MOvk';

LatLng position = const LatLng(-4.4163009, 15.2732314);
const double zoom = 15;

BitmapDescriptor? pinner;
BitmapDescriptor? car_android;
BitmapDescriptor? departBitmap;
BitmapDescriptor? arriveBitmap;

readBitconMarkerPinner() async {
  pinner = await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(),
    "assets/icon/pinner.png",
  );

  departBitmap = await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(),
    "assets/images/drapeau-a-damier.png",
  );

  arriveBitmap = await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(),
    "assets/images/drapeau.png",
  );

  car_android = await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(),
    "assets/images/car_android.png",
  );
}


Future<BitmapDescriptor> bitmap(String url, int width) async{
  ByteData data = await rootBundle.load(url);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();

  final Uint8List markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(markerIcon);
}

double coordinateDistance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}

String distanceDeuxPoint(polylineCoordinates){
  double totalDistance = 0.0;
  for (int i = 0; i < polylineCoordinates.length - 1; i++) {
    totalDistance += coordinateDistance(
      polylineCoordinates[i].latitude,
      polylineCoordinates[i].longitude,
      polylineCoordinates[i + 1].latitude,
      polylineCoordinates[i + 1].longitude,
    );
  }
  if(totalDistance < 1){
    return '${(totalDistance * 1000).toStringAsFixed(2)} mètre (s)';
  }
  return '${totalDistance.toStringAsFixed(2)} Km';
}

void logOut() async{
  await storage.delete(key: 'token');
  await storage.delete(key: 'sid');
}

void showLoader(String message)async{
  await EasyLoading.show(
    status: '$message',
    maskType: EasyLoadingMaskType.black,
  );
}

void disableLoader()async{
  await EasyLoading.dismiss();
}
