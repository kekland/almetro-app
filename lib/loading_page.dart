import 'package:almaty_metro/home_page.dart';
import 'package:almaty_metro/model/app_model.dart';
import 'package:almaty_metro/widgets/transitions/circular_reveal_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future _navigationFuture;
  void _navigate() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      CircularRevealPageRoute(builder: (_) => HomePage()),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = Provider.of<AppModel>(context);

    if (model.subway != null && _navigationFuture == null) {
      _navigationFuture = Future.delayed(Duration(seconds: 2), _navigate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 160.0,
              height: 160.0,
              child: CircularProgressIndicator(
                strokeWidth: 6.0,
              ),
            ),
            Hero(
              tag: 'app_logo',
              child: SvgPicture.asset(
                'assets/icon.svg',
                height: 80.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
