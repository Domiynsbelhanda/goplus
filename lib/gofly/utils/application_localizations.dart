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
  late LocaleModel _frString;

  Future<bool> loadLangs(BuildContext context) async {
    String jsonString =
    await rootBundle.loadString('assets/translations/fr.json');
    _frString = localeModelFromJson(jsonString);
    return true;
  }

  bool changeLang(BuildContext context, String jsonString, {required String langCode}) {
    if (langCode == null) langCode = appLocale!.languageCode;

    Provider.of<LocalesProviderModel>(context, listen: false)
        .updateLocalizedString(_frString);

    return true;
  }
}
