import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = const FlutterSecureStorage();

void showLoader(String message)async{
  await EasyLoading.show(
    status: '$message',
    maskType: EasyLoadingMaskType.black,
  );
}

void disableLoader()async{
  await EasyLoading.dismiss();
}