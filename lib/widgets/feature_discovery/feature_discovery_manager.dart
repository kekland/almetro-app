import 'package:almaty_metro/model/app_model.dart';
import 'package:almaty_metro/widgets/feature_discovery/feature.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeatureDiscoveryManager extends StatefulWidget {
  final Widget child;
  final List<GlobalKey<DiscoverableFeatureState>> keys;

  const FeatureDiscoveryManager({
    Key key,
    @required this.keys,
    @required this.child,
  }) : super(key: key);

  @override
  _FeatureDiscoveryManagerState createState() =>
      _FeatureDiscoveryManagerState();
}

class _FeatureDiscoveryManagerState extends State<FeatureDiscoveryManager> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appModel = context.read<AppModel>();

      for (final key in widget.keys) {
        final featureKey = key.currentState.widget.featureKey;

        if (appModel.settings.hasSeenOnboarding(featureKey)) {
          return;
        }

        appModel.settings.setHasSeenOnboarding(featureKey, true);
        await key.currentState.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
