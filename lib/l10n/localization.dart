import 'package:almaty_metro/api/model/station.dart';
import 'package:flutter/material.dart';

class AlmetroLocalization {
  final Locale locale;
  final String featureDiscoveryGpsDescription;
  final String featureDiscoveryGpsTitle;
  final String featureDiscoveryStationInfoDescription;
  final String featureDiscoveryStationInfoTitle;
  final String featureDiscoveryStationPickerDescription;
  final String featureDiscoveryStationPickerTitle;
  final String labelAppVersion;
  final String labelAutoupdate;
  final String labelChangeBrightness;
  final String labelChangeSettings;
  final String labelDateTimeIn;
  final String labelDateTimeNow;
  final String labelLastCacheRefresh;
  final String labelLoadingError;
  final String labelLoadingErrorTooltip;
  final String labelRefreshCache;
  final String labelShortHour;
  final String labelShortMinute;
  final String labelShortSecond;
  final String labelShowHolidaySchedule;
  final String labelShowingHolidaySchedule;
  final String labelStation;
  final String labelToday;
  final String labelToStation;
  final String labelTryAgain;
  final String snackbarCacheRefreshResultFailure;
  final String snackbarCacheRefreshResultSuccess;
  final String snackbarGpsResultSuccess;

  AlmetroLocalization({
    @required this.locale,
    @required this.featureDiscoveryGpsDescription,
    @required this.featureDiscoveryGpsTitle,
    @required this.featureDiscoveryStationInfoDescription,
    @required this.featureDiscoveryStationInfoTitle,
    @required this.featureDiscoveryStationPickerDescription,
    @required this.featureDiscoveryStationPickerTitle,
    @required this.labelAppVersion,
    @required this.labelAutoupdate,
    @required this.labelChangeBrightness,
    @required this.labelChangeSettings,
    @required this.labelDateTimeIn,
    @required this.labelDateTimeNow,
    @required this.labelLastCacheRefresh,
    @required this.labelLoadingError,
    @required this.labelLoadingErrorTooltip,
    @required this.labelRefreshCache,
    @required this.labelShortHour,
    @required this.labelShortMinute,
    @required this.labelShortSecond,
    @required this.labelShowHolidaySchedule,
    @required this.labelShowingHolidaySchedule,
    @required this.labelStation,
    @required this.labelToday,
    @required this.labelToStation,
    @required this.labelTryAgain,
    @required this.snackbarCacheRefreshResultFailure,
    @required this.snackbarCacheRefreshResultSuccess,
    @required this.snackbarGpsResultSuccess,
  });

  static AlmetroLocalization fromJson({
    @required Map<String, dynamic> json,
    @required Locale locale,
  }) {
    return AlmetroLocalization(
      locale: locale,
      featureDiscoveryGpsDescription: json['featureDiscoveryGpsDescription'],
      featureDiscoveryGpsTitle: json['featureDiscoveryGpsTitle'],
      featureDiscoveryStationInfoDescription:
          json['featureDiscoveryStationInfoDescription'],
      featureDiscoveryStationInfoTitle:
          json['featureDiscoveryStationInfoTitle'],
      featureDiscoveryStationPickerDescription:
          json['featureDiscoveryStationPickerDescription'],
      featureDiscoveryStationPickerTitle:
          json['featureDiscoveryStationPickerTitle'],
      labelAppVersion: json['labelAppVersion'],
      labelAutoupdate: json['labelAutoupdate'],
      labelChangeBrightness: json['labelChangeBrightness'],
      labelChangeSettings: json['labelChangeSettings'],
      labelDateTimeIn: json['labelDateTimeIn'],
      labelDateTimeNow: json['labelDateTimeNow'],
      labelLastCacheRefresh: json['labelLastCacheRefresh'],
      labelLoadingError: json['labelLoadingError'],
      labelLoadingErrorTooltip: json['labelLoadingErrorTooltip'],
      labelRefreshCache: json['labelRefreshCache'],
      labelShortHour: json['labelShortHour'],
      labelShortMinute: json['labelShortMinute'],
      labelShortSecond: json['labelShortSecond'],
      labelShowHolidaySchedule: json['labelShowHolidaySchedule'],
      labelShowingHolidaySchedule: json['labelShowingHolidaySchedule'],
      labelStation: json['labelStation'],
      labelToday: json['labelToday'],
      labelToStation: json['labelToStation'],
      labelTryAgain: json['labelTryAgain'],
      snackbarCacheRefreshResultFailure:
          json['snackbarCacheRefreshResultFailure'],
      snackbarCacheRefreshResultSuccess:
          json['snackbarCacheRefreshResultSuccess'],
      snackbarGpsResultSuccess: json['snackbarGpsResultSuccess'],
    );
  }

  static AlmetroLocalization of(BuildContext context) {
    return Localizations.of<AlmetroLocalization>(context, AlmetroLocalization);
  }

  String getSubwayStationName(SubwayStation station) {
    return station.name.resolveFromLocale(locale);
  }
}

extension Localization on BuildContext {
  AlmetroLocalization get l10n => AlmetroLocalization.of(this);
}
