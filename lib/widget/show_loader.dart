import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';

void showLoader(String message)async{
  await EasyLoading.show(
    status: '$message',
    maskType: EasyLoadingMaskType.black,
  );
}