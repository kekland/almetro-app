import 'package:almaty_metro/api/db.dart';
import 'package:almaty_metro/l10n/delegate.dart';
import 'package:almaty_metro/l10n/localization.dart';
import 'package:almaty_metro/loading_page.dart';
import 'package:almaty_metro/model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(
    MyApp(),
  );
}

const accentRed = const Color(0xFFE53935);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    final localizationDelegate = AlmetroLocalizations.delegate;
    return ChangeNotifierProvider(
      create: (context) => AppModel(),
      builder: (context, child) {
        final model = context.watch<AppModel>();

        return MaterialApp(
          title: 'Almetro',
          debugShowCheckedModeBanner: false,
          themeMode: model.settings.themeMode,
          localizationsDelegates: [
            localizationDelegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: localizationDelegate.locales,
          localeResolutionCallback: (locale, list) {
            if (list.contains(locale)) return locale;
            return Locale('ru');
          },
          locale: Locale('kk'),
          theme: ThemeData(
            primaryColor: accentRed,
            accentColor: accentRed,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primaryColor: accentRed,
            accentColor: accentRed,
            brightness: Brightness.dark,
          ),
          home: LoadingPage(),
        );
      },
    );
  }
}
