import 'package:flutter/material.dart';
import 'package:texi_booking/models/locales_models.dart';

class LocalesProviderModel extends ChangeNotifier {
  LocaleModel _localeModelData;

  LocaleModel get getLocalizedStrings => _localeModelData;

  void updateLocalizedString(LocaleModel newLocaleData) {
    _localeModelData = newLocaleData;
    // notifyListeners();
  }
}
