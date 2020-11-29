import 'package:almaty_metro/api/api.dart';
import 'package:almaty_metro/l10n/localization.dart';
import 'package:almaty_metro/utils/snackbar.dart';
import 'package:almaty_metro/widgets/feature_discovery/feature.dart';
import 'package:almaty_metro/widgets/feature_discovery/feature_discovery_manager.dart';
import 'package:almaty_metro/widgets/holiday_card.dart';
import 'package:almaty_metro/widgets/loadable_list_tile.dart';
import 'package:geolocator/geolocator.dart';
import 'package:almaty_metro/model/app_model.dart';
import 'package:almaty_metro/widgets/station_info.dart';
import 'package:almaty_metro/widgets/station_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final gpsDiscoverableKey = GlobalKey<DiscoverableFeatureState>();
  final stationInfoDiscoverableKey = GlobalKey<DiscoverableFeatureState>();
  final stationPickerDiscoverableKey = GlobalKey<DiscoverableFeatureState>();

  @override
  Widget build(BuildContext context) {
    return FeatureDiscoveryManager(
      keys: [
        stationPickerDiscoverableKey,
        stationInfoDiscoverableKey,
        gpsDiscoverableKey,
      ],
      child: _HomePageBody(
        gpsDiscoverableKey: gpsDiscoverableKey,
        stationInfoDiscoverableKey: stationInfoDiscoverableKey,
        stationPickerDiscoverableKey: stationPickerDiscoverableKey,
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  final GlobalKey<DiscoverableFeatureState> gpsDiscoverableKey;
  final GlobalKey<DiscoverableFeatureState> stationInfoDiscoverableKey;
  final GlobalKey<DiscoverableFeatureState> stationPickerDiscoverableKey;

  const _HomePageBody({
    Key key,
    @required this.gpsDiscoverableKey,
    @required this.stationInfoDiscoverableKey,
    @required this.stationPickerDiscoverableKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = context.watch<AppModel>();

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Align(
            alignment: Alignment.center,
            child: Hero(
              tag: 'app_logo',
              child: SvgPicture.asset(
                'assets/icon.svg',
                height: 24.0,
              ),
            ),
          ),
        ),
        title: Text(
          'Almetro',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        brightness: theme.brightness,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: theme.colorScheme.onSurface,
        ),
        actions: [
          DiscoverableFeature(
            key: gpsDiscoverableKey,
            featureKey: 'gps',
            title: context.l10n.featureDiscoveryGpsTitle,
            description: context.l10n.featureDiscoveryGpsDescription,
            child: Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.gps_fixed_rounded),
                onPressed: () async {
                  final permission = await Geolocator.checkPermission();

                  if (permission == LocationPermission.denied) {
                    await Geolocator.requestPermission();
                  }
                  Position position;
                  try {
                    position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high,
                      timeLimit: Duration(seconds: 2),
                    );
                  } catch (e) {
                    position = await Geolocator.getLastKnownPosition();
                  }

                  model.selectedStation = model.getClosestStation(position);

                  showMessage(
                    context: context,
                    message: context.l10n.snackbarGpsResultSuccess,
                  );
                },
              ),
            ),
          ),
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.settings_rounded),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
      ),
      endDrawer: Builder(
        builder: (context) => Drawer(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Версия Almetro'),
                  subtitle: Text('v0.1.0'),
                  trailing: Icon(Icons.verified_user_outlined),
                ),
                Spacer(),
                LoadableListTile(
                  trailing: Icon(Icons.cached_rounded),
                  title: Text(context.l10n.labelRefreshCache),
                  subtitle: Text(
                      'Обновлено: ${MaterialLocalizations.of(context).formatShortMonthDay(model.settings.lastFetchTime)}'),
                  onTap: () async {
                    try {
                      await model.fetchFromNetwork();
                      showMessage(
                        context: context,
                        message: context.l10n.snackbarCacheRefreshResultSuccess,
                      );
                    } catch (e) {
                      showMessage(
                        context: context,
                        message: context.l10n.snackbarCacheRefreshResultFailure,
                      );
                    }
                  },
                ),
                SwitchListTile(
                  title: Text(context.l10n.labelShowHolidaySchedule),
                  value: model.scheduleType == ScheduleType.holiday,
                  activeColor: theme.accentColor,
                  contentPadding: EdgeInsets.only(left: 16.0, right: 8.0),
                  onChanged: (v) => model.scheduleType =
                      v ? ScheduleType.holiday : ScheduleType.normal,
                ),
                CheckboxListTile(
                  title: Text(context.l10n.labelAutoupdate),
                  value: model.settings.autoUpdate ?? false,
                  activeColor: theme.accentColor,
                  contentPadding: EdgeInsets.only(left: 16.0, right: 8.0),
                  onChanged: (v) => model.settings.autoUpdate = v,
                ),
                ListTile(
                  trailing: Icon(Icons.lightbulb_outline),
                  title: Text(context.l10n.labelChangeBrightness),
                  onTap: () {
                    final currentBrightness = model.settings.brightness ??
                        MediaQuery.of(context).platformBrightness;

                    model.settings.brightness =
                        currentBrightness == Brightness.light
                            ? Brightness.dark
                            : Brightness.light;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              if (model.scheduleType == ScheduleType.holiday) HolidayCard(),
              Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                child: DiscoverableFeature(
                  key: stationInfoDiscoverableKey,
                  featureKey: 'station-info',
                  title: context.l10n.featureDiscoveryStationInfoTitle,
                  description:
                      context.l10n.featureDiscoveryStationInfoDescription,
                  child: StationInfo(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: DiscoverableFeature(
            key: stationPickerDiscoverableKey,
            featureKey: 'station-picker',
            title: context.l10n.featureDiscoveryStationPickerTitle,
            description: context.l10n.featureDiscoveryStationInfoDescription,
            child: StationPicker(),
          ),
        ),
      ),
    );
  }
}
