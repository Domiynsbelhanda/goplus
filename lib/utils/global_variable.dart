import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final storage = const FlutterSecureStorage();

LatLng position = const LatLng(-4.4163009, 15.2732314);
const double zoom = 15;


Future<BitmapDescriptor> bitmap(String url) async{
  return await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(),
    url,
  );
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
