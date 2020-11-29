import 'package:almaty_metro/model/app_model.dart';
import 'package:almaty_metro/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HolidayCard extends StatefulWidget {
  @override
  _HolidayCardState createState() => _HolidayCardState();
}

class _HolidayCardState extends State<HolidayCard> {
  bool _isShowing = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final model = context.watch<AppModel>();

    return AnimatedCrossFade(
      firstChild: CardWidget(
        hasShadow: false,
        child: Row(
          children: [
            Icon(Icons.notifications, color: textTheme.caption.color),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.currentHoliday != null
                        ? 'Сегодня ${model.currentHoliday}!'
                        : 'Показывается расписание на выходные',
                    style: textTheme.bodyText1,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Сменить расписание можно в настройках',
                    style: textTheme.caption,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_drop_up),
              onPressed: () => setState(() => _isShowing = false),
            ),
          ],
        ),
      ),
      secondChild: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              Icons.warning_rounded,
              color: textTheme.caption.color,
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'Показывается расписание на выходные',
                style: textTheme.bodyText1,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () => setState(() => _isShowing = true),
            ),
          ],
        ),
      ),
      crossFadeState:
          _isShowing ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 250),
      alignment: Alignment.center,
    );
  }
}
