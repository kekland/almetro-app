import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showMessage({
  @required BuildContext context,
  @required String message,
}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
