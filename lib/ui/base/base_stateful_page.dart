import 'package:flutter/material.dart';
import 'package:flutter_weather_app/common/resources/strings.dart';
import 'package:flutter_weather_app/ui/widgets/alert_dialogs/platform_alert_dialog.dart';

abstract class BaseStatefulPage extends StatefulWidget {
  const BaseStatefulPage({Key? key}) : super(key: key);

  Route getRoute() {
    return PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            this,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          final Offset begin = const Offset(0.0, 1.0);
          final Offset end = Offset.zero;
          final tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.ease));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        settings: RouteSettings(name: getRouteName));
  }

  String? get getRouteName => null;

  Future<bool?> showNetworkErrorPopup(BuildContext? context) async {
    if (context == null) return false;
    return await PlatformAlertDialog.showAlertDialog(context, Strings.error,
        Strings.connectionError, Strings.retry, Strings.cancel);
  }
}
