import 'dart:convert';

import 'package:almaty_metro/l10n/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlmetroLocalizationDelegate extends LocalizationsDelegate {
  final locales = <Locale>[
    Locale('ru'),
    Locale('en'),
    Locale('kk'),
  ];

  @override
  bool isSupported(Locale locale) => locales.contains(locale);

  @override
  Future<AlmetroLocalization> load(Locale locale) async {
    final jsonString = await rootBundle.loadString(
      'assets/l10n/${locale.languageCode}.json',
    );

    final map = json.decode(jsonString);
    return AlmetroLocalization.fromJson(
      json: map,
      locale: locale,
    );
  }

  @override
  bool shouldReload(covariant AlmetroLocalizationDelegate old) => false;
}
