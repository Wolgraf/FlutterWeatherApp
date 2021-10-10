import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/common/resources/text_styles.dart';

class PlatformAlertDialog {
  static Future<bool?> showAlertDialog(BuildContext context, String title,
      String bodyText, String applyText, String cancelText) {
    Widget? dialog;
    if (Platform.isIOS) {
      dialog =
          _getCupertinoAlert(context, title, bodyText, applyText, cancelText);
    } else if (Platform.isAndroid) {
      dialog =
          _getAndroidAlert(context, title, bodyText, applyText, cancelText);
    }

    return showDialog(
      context: context,
      builder: (BuildContext context) => dialog!,
    );
  }

  static Widget _getCupertinoAlert(BuildContext context, String title,
      String bodyText, String applyText, String cancelText) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(bodyText),
      actions: [
        CupertinoDialogAction(
          child: Text(cancelText),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        CupertinoDialogAction(
          child: Text(applyText),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        )
      ],
    );
  }

  static Widget _getAndroidAlert(BuildContext context, String title,
      String bodyText, String applyText, String cancelText) {
    final Widget cancelButton = TextButton(
      child: Text(
        cancelText,
        style: TEXT_STYLE_HEADLINE_4_ACCENT,
      ),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    final Widget applyButton = TextButton(
      child: Text(
        applyText,
        style: TEXT_STYLE_HEADLINE_4_ACCENT,
      ),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
    return AlertDialog(
      title: Text(title),
      content: Text(bodyText),
      actions: [
        applyButton,
        cancelButton,
      ],
    );
  }
}
