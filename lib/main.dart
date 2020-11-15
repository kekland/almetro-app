import 'package:almaty_metro/api/db.dart';
import 'package:almaty_metro/loading_page.dart';
import 'package:almaty_metro/model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(MyApp());
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

    return ChangeNotifierProvider(
      create: (context) => AppModel(),
      builder: (context, child) {
        final model = context.watch<AppModel>();

        return MaterialApp(
          title: 'Almetro',
          debugShowCheckedModeBanner: false,
          themeMode: model.settings.themeMode,
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
