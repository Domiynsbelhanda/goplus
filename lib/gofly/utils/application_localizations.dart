import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';

class ApplicationLocalizations {
  final Locale? appLocale;

  ApplicationLocalizations(this.appLocale);

  static ApplicationLocalizations? of(BuildContext context) {
    return Localizations.of<ApplicationLocalizations>(
        context, ApplicationLocalizations);
  }

  LocaleModel? _localizedStrings;
  LocaleModel? _enString;
  LocaleModel? _gjString;
  LocaleModel? _hnString;

  Future<bool> loadLangs(BuildContext context) async {
    if (Provider.of<LocalesProviderModel>(context, listen: false)
            .getLocalizedStrings ==
        null) {
      for (var langCode in ["en", "gj", "hn"]) {
        String jsonString =
            await rootBundle.loadString('assets/translations/$langCode.json');
        switch (langCode) {
          case "en":
            _enString = localeModelFromJson(jsonString);
            break;
          case "gj":
            _gjString = localeModelFromJson(jsonString);
            break;
          case "hn":
            _hnString = localeModelFromJson(jsonString);
            break;
          default:
        }
      }
      Provider.of<LocalesProviderModel>(context, listen: false)
          .updateLocalizedString(_enString!);
    }

    return true;
  }

  bool changeLang(BuildContext context, {required String langCode}) {
    if (langCode == null) langCode = appLocale!.languageCode;
    switch (langCode) {
      case "en":
        _localizedStrings = _enString;
        Provider.of<LocalesProviderModel>(context, listen: false)
            .updateLocalizedString(_localizedStrings!);
        break;
      case "gj":
        _localizedStrings = _gjString;
        Provider.of<LocalesProviderModel>(context, listen: false)
            .updateLocalizedString(_localizedStrings!);
        break;
      case "hn":
        _localizedStrings = _hnString;
        Provider.of<LocalesProviderModel>(context, listen: false)
            .updateLocalizedString(_localizedStrings!);
        break;
      default:
    }
    return true;
  }
}
