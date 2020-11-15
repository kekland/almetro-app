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
  bool _errored = false;

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

    if (model.subway == null && !model.isFetching) {
      setState(() => _errored = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: _errored ? 0.0 : 1.0,
              curve: Curves.easeInOut,
              child: SizedBox(
                width: 160.0,
                height: 160.0,
                child: CircularProgressIndicator(
                  strokeWidth: 6.0,
                ),
              ),
            ),
            Hero(
              tag: 'app_logo',
              child: SvgPicture.asset(
                'assets/icon.svg',
                height: 80.0,
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 150),
              opacity: _errored ? 1.0 : 0.0,
              curve: Curves.easeInOut,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.cloud_off,
                          color: textTheme.caption.color,
                        ),
                        SizedBox(height: 8.0),
                        if (_errored) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Произошла ошибка при загрузке',
                                style: textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Text(
                            'Если вы запускаете приложение в первый раз - пожалуйста, проверьте подключение к сети.',
                            style: textTheme.caption,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.0),
                          RaisedButton.icon(
                            color: theme.accentColor,
                            textColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            elevation: 0.0,
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              setState(() {
                                _errored = false;
                                context.read<AppModel>().fetchFromNetwork();
                              });
                            },
                            label: Text('Повторить попытку'),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
