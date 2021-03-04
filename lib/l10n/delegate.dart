import 'dart:convert';

import 'package:almaty_metro/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlmetroLocalizationsDelegate
    extends LocalizationsDelegate<AlmetroLocalizations> {
  final locales = <Locale>[
    Locale('ru'),
    Locale('en'),
    Locale('kk'),
    Locale('de'),
  ];

  @override
  bool isSupported(Locale locale) => locales.contains(locale);

  @override
  Future<AlmetroLocalizations> load(Locale locale) async {
    final jsonString = await rootBundle.loadString(
      'assets/l10n/${locale.languageCode}.json',
    );

    final map = json.decode(jsonString);
    return AlmetroLocalizations.fromJson(
      json: map,
      locale: locale,
    );
  }

  @override
  bool shouldReload(covariant AlmetroLocalizationsDelegate old) => false;
}
