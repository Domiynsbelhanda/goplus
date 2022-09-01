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
  LocaleModel? _lgString;
  LocaleModel? _frString;

  Future<bool> loadLangs(BuildContext context) async {
    if (Provider.of<LocalesProviderModel>(context, listen: false)
            .getLocalizedStrings ==
        null) {
      for (var langCode in ["lg", "fr"]) {
        String jsonString =
            await rootBundle.loadString('assets/translations/$langCode.json');
        switch (langCode) {
          case "lg":
            _lgString = localeModelFromJson(jsonString);
            break;
          case "fr":
            _frString = localeModelFromJson(jsonString);
            break;
          default:
        }
      }
    }
    return true;
  }

  bool changeLang(BuildContext context, String jsonString, {required String langCode}) {
    if (langCode == null) langCode = appLocale!.languageCode;

    LocaleModel lg = localeModelFromJson(jsonString);

    Provider.of<LocalesProviderModel>(context, listen: false)
        .updateLocalizedString(lg);

    return true;
  }
}
