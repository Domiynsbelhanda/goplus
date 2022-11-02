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
}


Future<BitmapDescriptor> bitmap(String url, int width) async{
  ByteData data = await rootBundle.load(url);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();

  final Uint8List markerIcon = (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(markerIcon);
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
